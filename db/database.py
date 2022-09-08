from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import urllib


server = 'localhost' # to specify an alternate port
database = 'SCADA' 
username = 'test' 
password = '53709398'


SQLALCHEMY_DATABASE_URL = f"mssql+pyodbc://{username}:{password}@{server}\\SQLEXPRESS/{database}?trusted_connection=yes&driver=ODBC+Driver+13+for+SQL+Server"

engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()