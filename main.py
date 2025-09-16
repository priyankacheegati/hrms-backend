# main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import employees

app = FastAPI(title="HRMS Backend")

# Allow local frontend (served on :8000 or :5500 or file)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost", "http://127.0.0.1", "http://localhost:8000", "http://localhost:5500"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(employees.router)

@app.get("/")
def root():
    return {"msg":"HRMS Backend Running"}

 