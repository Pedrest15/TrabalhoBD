from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import router

# Criar servidor
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],  
)

# Incluir rotas das aplicacoes 
app.include_router(router=router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, port=2000, host='127.0.0.1')
    