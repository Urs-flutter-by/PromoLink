from fastapi import FastAPI, Request, status
from fastapi.responses import JSONResponse
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

from app.api.v1.endpoints import auth, discounts, products, promo_cards, users

app.include_router(auth.router, prefix="/api/v1/auth", tags=["auth"])
app.include_router(discounts.router, prefix="/api/v1/discounts", tags=["discounts"])
app.include_router(products.router, prefix="/api/v1/products", tags=["products"])
app.include_router(promo_cards.router, prefix="/api/v1/promo_cards", tags=["promo_cards"])
app.include_router(users.router, prefix="/api/v1/users", tags=["users"])

@app.exception_handler(Exception)
async def validation_exception_handler(request: Request, exc: Exception):
    logger.error(f"Unhandled exception: {exc}", exc_info=True)
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content={"message": "An internal server error occurred."},
    )

@app.get("/")
async def root():
    return {"message": "Backend is running!"}