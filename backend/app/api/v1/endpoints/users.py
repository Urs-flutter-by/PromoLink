from typing import Annotated

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.models.models import User
from ...app.schemas.schemas import User as UserSchema
from ...app.api.deps import get_current_active_user

router = APIRouter()

@router.get("/users/me", response_model=UserSchema)
async def read_users_me(
    current_user: Annotated[User, Depends(get_current_active_user)]
):
    return current_user
