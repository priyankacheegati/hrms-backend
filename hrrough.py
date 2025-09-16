from fastapi import FastAPI

app = FastAPI()

employees = [
    {"id": 1, "name": "John", "dept": "HR", "email": "john@example.com", "salary": 50000},
    {"id": 2, "name": "Alice", "dept": "IT", "email": "alice@example.com", "salary": 60000}
]

@app.get("/employees")
def get_employees():
    return employees
