from sqlalchemy.orm import Session
from datetime import datetime
from typing import Optional

from app.models.models import AuditLog

def create_audit_log(
    db: Session,
    action: str,
    user_id: Optional[int] = None,
    details: Optional[str] = None
):
    audit_log = AuditLog(
        user_id=user_id,
        action=action,
        details=details,
        created_at=datetime.utcnow()
    )
    db.add(audit_log)
    db.commit()
    db.refresh(audit_log)
    return audit_log
