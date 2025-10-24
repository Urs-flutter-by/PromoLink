from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from ...db.database import get_db
from ...app.models.models import PromoCard
from ...app.schemas.schemas import PromoCard as PromoCardSchema

router = APIRouter()

@router.get("/promo-cards/{qr_serial}", response_model=PromoCardSchema)
async def get_promo_card_by_qr_serial(
    qr_serial: str, db: Session = Depends(get_db)
):
    promo_card = db.query(PromoCard).filter(PromoCard.qr_serial == qr_serial).first()
    if not promo_card:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Promo card not found"
        )
    return promo_card
