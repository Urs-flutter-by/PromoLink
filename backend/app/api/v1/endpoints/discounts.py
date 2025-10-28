from typing import Annotated, List, Optional

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.db.database import get_db
from app.models.models import Discount, User
from ...app.schemas.schemas import Discount as DiscountSchema, DiscountCreate
from ...app.api.deps import get_current_active_user
from app.core.rbac import is_sales_manager

router = APIRouter()

@router.post("/discounts", response_model=DiscountSchema, status_code=status.HTTP_201_CREATED)
async def create_discount(
    discount_in: DiscountCreate,
    current_user: Annotated[User, Depends(is_sales_manager)], # Only sales managers can create
    db: Session = Depends(get_db)
):
    db_discount = Discount(**discount_in.dict())
    db.add(db_discount)
    db.commit()
    db.refresh(db_discount)
    return db_discount

@router.get("/discounts", response_model=List[DiscountSchema])
async def read_discounts(
    current_user: Annotated[User, Depends(get_current_active_user)], # Authenticated users can read
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100
):
    discounts = db.query(Discount).offset(skip).limit(limit).all()
    return discounts

@router.get("/discounts/{discount_id}", response_model=DiscountSchema)
async def read_discount(
    discount_id: int,
    current_user: Annotated[User, Depends(get_current_active_user)], # Authenticated users can read
    db: Session = Depends(get_db)
):
    discount = db.query(Discount).filter(Discount.id == discount_id).first()
    if not discount:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Discount not found")
    return discount

@router.put("/discounts/{discount_id}", response_model=DiscountSchema)
async def update_discount(
    discount_id: int,
    discount_in: DiscountCreate, # Using DiscountCreate for update for simplicity, can be DiscountUpdate
    current_user: Annotated[User, Depends(is_sales_manager)], # Only sales managers can update
    db: Session = Depends(get_db)
):
    db_discount = db.query(Discount).filter(Discount.id == discount_id).first()
    if not db_discount:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Discount not found")
    for key, value in discount_in.dict(exclude_unset=True).items():
        setattr(db_discount, key, value)
    db.add(db_discount)
    db.commit()
    db.refresh(db_discount)
    return db_discount

@router.delete("/discounts/{discount_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_discount(
    discount_id: int,
    current_user: Annotated[User, Depends(is_sales_manager)], # Only sales managers can delete
    db: Session = Depends(get_db)
):
    db_discount = db.query(Discount).filter(Discount.id == discount_id).first()
    if not db_discount:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Discount not found")
    db.delete(db_discount)
    db.commit()
    return {"ok": True}
