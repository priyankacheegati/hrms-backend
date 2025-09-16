# models.py
from pydantic import BaseModel

class EmployeeIn(BaseModel):
    name: str
    department: str | None = None
    email: str | None = None
    salary: float | None = None

class EmployeeOut(EmployeeIn):
    id: int
    created_at: str
