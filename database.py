# database.py
import mysql.connector
from mysql.connector import Error

def get_db_connection():
    conn = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Priyanka@2001",   
        database="hrms"
    )
    return conn
