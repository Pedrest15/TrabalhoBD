from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    DB_USER:str
    DB_PASSWORD:str
    DB_DNS:str
    
    class Config:
        env_file = ".env"
        extra = "allow"

settings = Settings()

