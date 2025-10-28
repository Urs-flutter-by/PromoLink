from typing import Annotated, List, Optional

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.db.database import get_db
from ...app.models.models import Product, User
from ...app.schemas.schemas import Product as ProductSchema, ProductCreate
from ...app.api.deps import get_current_active_user
from app.core.rbac import is_sales_manager

router = APIRouter()

@router.post("/products", response_model=ProductSchema, status_code=status.HTTP_201_CREATED)
async def create_product(
    product_in: ProductCreate,
    current_user: Annotated[User, Depends(is_sales_manager)], # Only sales managers can create
    db: Session = Depends(get_db)
):
    db_product = Product(**product_in.dict())
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    return db_product

@router.get("/products", response_model=List[ProductSchema])
async def read_products(
    current_user: Annotated[User, Depends(get_current_active_user)], # Authenticated users can read
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100
):
    products = db.query(Product).offset(skip).limit(limit).all()
    return products

@router.get("/products/{product_id}", response_model=ProductSchema)
async def read_product(
    product_id: int,
    current_user: Annotated[User, Depends(get_current_active_user)], # Authenticated users can read
    db: Session = Depends(get_db)
):
    product = db.query(Product).filter(Product.id == product_id).first()
    if not product:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Product not found")
    return product

@router.put("/products/{product_id}", response_model=ProductSchema)
async def update_product(
    product_id: int,
    product_in: ProductCreate, # Using ProductCreate for update for simplicity, can be ProductUpdate
    current_user: Annotated[User, Depends(is_sales_manager)], # Only sales managers can update
    db: Session = Depends(get_db)
):
    db_product = db.query(Product).filter(Product.id == product_id).first()
    if not db_product:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Product not found")
    for key, value in product_in.dict(exclude_unset=True).items():
        setattr(db_product, key, value)
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    return db_product

@router.delete("/products/{product_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_product(
    product_id: int,
    current_user: Annotated[User, Depends(is_sales_manager)], # Only sales managers can delete
    db: Session = Depends(get_db)
):
    db_product = db.query(Product).filter(Product.id == product_id).first()
    if not db_product:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Product not found")
    db.delete(db_product)
    db.commit()
    return {"ok": True}
