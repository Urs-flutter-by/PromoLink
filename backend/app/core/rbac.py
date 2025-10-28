from fastapi import HTTPException, status, Depends
from typing import List
from app.models.models import User
from app.api.deps import get_current_active_user

def check_roles(allowed_roles: List[str]):
    def role_checker(current_user: User = Depends(get_current_active_user)):
        if current_user.role not in allowed_roles:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Not enough permissions"
            )
        return current_user
    return role_checker

# Specific role dependencies
def is_admin(current_user: User = Depends(check_roles(["admin"]))):
    return current_user

def is_sales_manager(current_user: User = Depends(check_roles(["admin", "sales"]))):
    return current_user

def is_cto(current_user: User = Depends(check_roles(["admin", "cto"]))):
    return current_user
