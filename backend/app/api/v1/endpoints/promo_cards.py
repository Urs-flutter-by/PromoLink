from typing import Annotated, List, Optional

from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session
from sqlalchemy import or_

from app.db.database import get_db
from app.models.models import PromoCard, Client, Product, Discount, User
from ...app.schemas.schemas import PromoCard as PromoCardSchema, PromoCardCreate, PromoCardUpdate
from ...app.api.deps import get_current_active_user
from app.core.rbac import is_sales_manager, is_cto
from datetime import datetime, date
import logging # Add logging import

logger = logging.getLogger(__name__) # Initialize logger

router = APIRouter()

@router.get("/promo-cards/{qr_serial}", response_model=PromoCardSchema)
async def get_promo_card_by_qr_serial(
    qr_serial: str, db: Session = Depends(get_db)
):
    logger.info(f"Attempting to retrieve promo card with QR serial: {qr_serial}")
    promo_card = db.query(PromoCard).filter(PromoCard.qr_serial == qr_serial).first()
    if not promo_card:
        logger.warning(f"Promo card with QR serial {qr_serial} not found.")
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Promo card not found"
        )
    logger.info(f"Successfully retrieved promo card with QR serial: {qr_serial}")
    return promo_card

@router.post("/promo-cards", response_model=PromoCardSchema, status_code=status.HTTP_201_CREATED)
async def create_promo_card(
    promo_card_in: PromoCardCreate,
    current_user: Annotated[User, Depends(is_sales_manager)], # Only sales managers can create
    db: Session = Depends(get_db)
):
    logger.info(f"User {current_user.username} attempting to create promo card with QR serial: {promo_card_in.qr_serial}")
    # Check if QR serial already exists
    existing_card = db.query(PromoCard).filter(PromoCard.qr_serial == promo_card_in.qr_serial).first()
    if existing_card:
        logger.warning(f"Promo card with QR serial {promo_card_in.qr_serial} already exists.")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Promo card with this QR serial already exists"
        )

    # Check if client exists, if not, create a new one (or handle as per business logic) # TODO: Integrate UNP API here
    client = db.query(Client).filter(Client.unp == promo_card_in.unp).first()
    if not client:
        logger.warning(f"Client with UNP {promo_card_in.unp} not found during promo card creation.")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Client with provided UNP not found. Please create client first."
        )

    # Check if product exists
    product = db.query(Product).filter(Product.id == promo_card_in.product_id).first()
    if not product:
        logger.warning(f"Product with ID {promo_card_in.product_id} not found during promo card creation.")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Product not found"
        )

    # Check if discount exists
    discount = db.query(Discount).filter(Discount.id == promo_card_in.discount_id).first()
    if not discount:
        logger.warning(f"Discount with ID {promo_card_in.discount_id} not found during promo card creation.")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Discount not found"
        )

    db_promo_card = PromoCard(
        qr_serial=promo_card_in.qr_serial,
        client_id=client.id, # Assuming client is found or created
        product_id=promo_card_in.product_id,
        discount_id=promo_card_in.discount_id,
        issued_by_user_id=current_user.id,
        valid_from=promo_card_in.valid_from,
        valid_until=promo_card_in.valid_until,
        status="valid" # Default status
    )
    db.add(db_promo_card)
    db.commit()
    db.refresh(db_promo_card)
    logger.info(f"Promo card {db_promo_card.qr_serial} created successfully by user {current_user.username}.")
    return db_promo_card

@router.put("/promo-cards/{qr_serial}/redeem", response_model=PromoCardSchema)
async def redeem_promo_card(
    qr_serial: str,
    current_user: Annotated[User, Depends(is_sales_manager)], # Only sales managers can redeem
    db: Session = Depends(get_db)
):
    logger.info(f"User {current_user.username} attempting to redeem promo card with QR serial: {qr_serial}")
    promo_card = db.query(PromoCard).filter(PromoCard.qr_serial == qr_serial).first()
    if not promo_card:
        logger.warning(f"Promo card with QR serial {qr_serial} not found for redemption.")
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Promo card not found"
        )
    if promo_card.status == "redeemed":
        logger.warning(f"Promo card {qr_serial} already redeemed.")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Promo card already redeemed"
        )
    if promo_card.status == "expired":
        logger.warning(f"Promo card {qr_serial} has expired.")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Promo card has expired"
        )

    promo_card.status = "redeemed"
    promo_card.redeemed_at = datetime.utcnow()
    db.add(promo_card)
    db.commit()
    db.refresh(promo_card)
    logger.info(f"Promo card {qr_serial} redeemed successfully by user {current_user.username}.")
    return promo_card

@router.get("/promo-cards", response_model=List[PromoCardSchema])
async def list_promo_cards(
    current_user: Annotated[User, Depends(get_current_active_user)], # Authenticated users can list
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100,
    search: Optional[str] = Query(None, description="Search by QR serial, client UNP, or product name"),
    status_filter: Optional[str] = Query(None, description="Filter by promo card status (valid, redeemed, expired)")
):
    logger.info(f"User {current_user.username} requesting list of promo cards. Search: {search}, Status Filter: {status_filter}")
    query = db.query(PromoCard)

    if search:
        query = query.join(Client).join(Product).filter(
            or_(
                PromoCard.qr_serial.ilike(f"%{search}%"),
                Client.unp.ilike(f"%{search}%"),
                Product.name.ilike(f"%{search}%")
            )
        )
    if status_filter:
        query = query.filter(PromoCard.status == status_filter)

    promo_cards = query.offset(skip).limit(limit).all()
    logger.info(f"Returning {len(promo_cards)} promo cards.")
    return promo_cards

@router.put("/promo-cards/{qr_serial}/service-discount", response_model=PromoCardSchema)
async def set_service_center_discount(
    qr_serial: str,
    service_center_discount_until: date,
    current_user: Annotated[User, Depends(is_cto)], # Only CTO can set service discount
    db: Session = Depends(get_db)
):
    logger.info(f"User {current_user.username} attempting to set service discount for promo card: {qr_serial} until {service_center_discount_until}")
    promo_card = db.query(PromoCard).filter(PromoCard.qr_serial == qr_serial).first()
    if not promo_card:
        logger.warning(f"Promo card with QR serial {qr_serial} not found for setting service discount.")
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Promo card not found"
        )
    
    promo_card.service_center_discount_until = service_center_discount_until
    db.add(promo_card)
    db.commit()
    db.refresh(promo_card)
    logger.info(f"Service discount for promo card {qr_serial} set successfully by user {current_user.username}.")
    return promo_card
