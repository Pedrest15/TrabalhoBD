from pydantic import BaseModel

class InsertAtletaRequest(BaseModel):
    cpf: str
    nome: str
    genero: str
    idade: int
    rua: str
    bairro: str
    numero: int
    cidade: str
    uf: int
    telefone: str
    codigo_matricula: str
    ano_ingresso: int
    universidade: str
    nome_curso: str

class VerifyCpfRequest(BaseModel):
    cpf:str

class SelectTimesRequest(BaseModel):
    genero: str
    universidade: str
    nome_curso: str

