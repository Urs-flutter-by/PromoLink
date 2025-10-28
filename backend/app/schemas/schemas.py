from pydantic import BaseModel, Field
from datetime import date, datetime
from typing import Optional

class UserBase(BaseModel):
    username: str
    role: str

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True

class ClientBase(BaseModel):
    unp: str
    company_name: str

class ClientCreate(ClientBase):
    pass

class Client(ClientBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True

class DiscountBase(BaseModel):
    name: str
    percentage: float = Field(..., gt=0, le=100)
    type: str # promo, service_center
    duration_months: Optional[int] = None

class DiscountCreate(DiscountBase):
    pass

class Discount(DiscountBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True

class ProductBase(BaseModel):
    name: str
    default_discount_id: Optional[int] = None

class ProductCreate(ProductBase):
    pass

class Product(ProductBase):
    id: int
    created_at: datetime
    default_discount: Optional[Discount] = None

    class Config:
        from_attributes = True

class PromoCardBase(BaseModel):
    qr_serial: str
    client_id: int
    product_id: int
    discount_id: int
    issued_by_user_id: int
    valid_from: date
    valid_until: date

class PromoCardCreate(PromoCardBase):
    pass

class PromoCardUpdate(BaseModel):
    status: Optional[str] = None
    redeemed_at: Optional[datetime] = None
    service_center_discount_until: Optional[date] = None

class PromoCard(PromoCardBase):
    id: int
    status: str
    created_at: datetime
    redeemed_at: Optional[datetime] = None
    service_center_discount_until: Optional[date] = None
    client: Client
    product: Product
    discount: Discount
    issuer: User

    class Config:
        from_attributes = True

class AuditLogBase(BaseModel):
    user_id: Optional[int] = None
    action: str
    details: Optional[str] = None

class AuditLogCreate(AuditLogBase):
    pass

class AuditLog(AuditLogBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: Optional[str] = None
    role: Optional[str] = None