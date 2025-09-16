# routers/employees.py
from fastapi import APIRouter, HTTPException
from database import get_db_connection
from models import EmployeeIn
from typing import List

router = APIRouter(prefix="/employees", tags=["employees"])

@router.get("/", response_model=List[dict])
def list_employees():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM employees ORDER BY id DESC")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return rows

@router.post("/", status_code=201)
def create_employee(emp: EmployeeIn):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO employees (name, department, email, salary) VALUES (%s, %s, %s, %s)",
        (emp.name, emp.department, emp.email, emp.salary)
    )
    conn.commit()
    new_id = cursor.lastrowid
    cursor.close()
    conn.close()
    return {"msg":"Employee created", "id": new_id}

@router.get("/{emp_id}")
def get_employee(emp_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM employees WHERE id=%s", (emp_id,))
    row = cursor.fetchone()
    cursor.close()
    conn.close()
    if not row:
        raise HTTPException(status_code=404, detail="Employee not found")
    return row

@router.put("/{emp_id}")
def update_employee(emp_id: int, emp: EmployeeIn):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE employees SET name=%s, department=%s, email=%s, salary=%s WHERE id=%s",
        (emp.name, emp.department, emp.email, emp.salary, emp_id)
    )
    conn.commit()
    cursor.close()
    conn.close()
    return {"msg":"Employee updated"}

@router.delete("/{emp_id}")
def delete_employee(emp_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM employees WHERE id=%s", (emp_id,))
    conn.commit()
    cursor.close()
    conn.close()
    return {"msg":"Employee deleted"}
