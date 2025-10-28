from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey, DECIMAL, Date
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    role = Column(String, nullable=False) # admin, sales, cto
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    promo_cards_issued = relationship("PromoCard", back_populates="issuer")
    audit_logs = relationship("AuditLog", back_populates="user")

class Client(Base):
    __tablename__ = "clients"

    id = Column(Integer, primary_key=True, index=True)
    unp = Column(String, unique=True, index=True, nullable=False)
    company_name = Column(String, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    promo_cards = relationship("PromoCard", back_populates="client")

class Product(Base):
    __tablename__ = "products"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True, nullable=False)
    default_discount_id = Column(Integer, ForeignKey("discounts.id"))
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    default_discount = relationship("Discount", back_populates="products")
    promo_cards = relationship("PromoCard", back_populates="product")

class Discount(Base):
    __tablename__ = "discounts"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    percentage = Column(DECIMAL(5, 2), nullable=False)
    type = Column(String, nullable=False) # promo, service_center
    duration_months = Column(Integer, nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    products = relationship("Product", back_populates="default_discount")
    promo_cards = relationship("PromoCard", back_populates="discount")

class PromoCard(Base):
    __tablename__ = "promo_cards"

    id = Column(Integer, primary_key=True, index=True)
    qr_serial = Column(String, unique=True, index=True, nullable=False)
    status = Column(String, default="valid", nullable=False) # valid, redeemed, expired
    client_id = Column(Integer, ForeignKey("clients.id"), nullable=False)
    product_id = Column(Integer, ForeignKey("products.id"), nullable=False)
    discount_id = Column(Integer, ForeignKey("discounts.id"), nullable=False)
    issued_by_user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    valid_from = Column(Date, nullable=False)
    valid_until = Column(Date, nullable=False)
    redeemed_at = Column(DateTime(timezone=True), nullable=True)
    service_center_discount_until = Column(Date, nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    client = relationship("Client", back_populates="promo_cards")
    product = relationship("Product", back_populates="promo_cards")
    discount = relationship("Discount", back_populates="promo_cards")
    issuer = relationship("User", back_populates="promo_cards_issued")

class AuditLog(Base):
    __tablename__ = "audit_logs"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=True) # Nullable if system action or unauthenticated
    action = Column(String, nullable=False)
    details = Column(String, nullable=True) # Store as JSON string
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    user = relationship("User", back_populates="audit_logs")
