from fastapi import APIRouter, HTTPException
from log import LoggerMessages, logger
from time import time
from models import InsertAtletaRequest, SelectTimesRequest
from db import db_assist

router = APIRouter()

@router.get("/uf-code")
async def get_uf_code():
    start_time = time()
    
    try:
        siglas = db_assist.select(table='UF_CODE', columns_wanted=['CODIGO_UF','SIGLA'])

        return {"message": siglas}
    
    except Exception as err:
        logger.error(err)
        raise HTTPException(status_code=500, detail="Internal Server Error")
    
    finally:
        end_time = time()
        duration = end_time - start_time
        logger.info(LoggerMessages.time_info(duration=duration))

@router.get("universidades")
async def get_universidades():
    start_time = time()
    
    try:
        uni = db_assist.select(table='UNIVERSIDADE', columns_wanted=['CODIGO_MEC', 'NOME'])

        return {"message": uni}
    
    except Exception as err:
        logger.error(err)
        raise HTTPException(status_code=500, detail="Internal Server Error")
    
    finally:
        end_time = time()
        duration = end_time - start_time
        logger.info(LoggerMessages.time_info(duration=duration))

@router.get("cursos")
async def get_universidades():
    start_time = time()
    
    try:
        cursos = db_assist.select(table='CURSO', columns_wanted=['UNIVERSIDADE', 'NOME'])

        return {"message": cursos}
    
    except Exception as err:
        logger.error(err)
        raise HTTPException(status_code=500, detail="Internal Server Error")
    
    finally:
        end_time = time()
        duration = end_time - start_time
        logger.info(LoggerMessages.time_info(duration=duration))

@router.post("/insert-atleta")
async def insert_atleta(request: InsertAtletaRequest):
    start_time = time()

    try:
        data={"cpf": request.cpf,
              "nome": request.nome,
              "genero": request.genero,
              "idade": request.idade,
              "rua": request.rua,
              "bairro": request.bairro,
              "numero": request.numero,
              "cidade": request.cidade,
              "uf": request.uf,
              "telefone": request.telefone,
              "codigo_matricula": request.codigo_matricula,
              "ano_de_ingresso": request.ano_ingresso,
              "universidade": request.universidade,
              "nome_curso": request.nome_curso}

        db_assist.insert(table="ATLETA", data=data)

        return {"message": "sucesso"}

    except Exception as err:
        logger.error(err)
        raise HTTPException(status_code=500, detail="Internal Server Error")
    
    finally:
        end_time = time()
        duration = end_time - start_time
        logger.info(LoggerMessages.time_info(duration=duration))

@router.post("/times")
async def get_times(request: SelectTimesRequest):
    start_time = time()
    
    try:
        data={
            "genero": request.genero,
            "universidade": request.universidade,
            "nome_curso": request.nome_curso.upper()
            }

        query = """
            select t.esporte, u.NOME as "Universidade", o.NOME as "Organização", t.genero
            from TIME t
            join ORGANIZACAO_UNIVERSITARIA o 
                on o.UNIVERSIDADE = t.UNIVERSIDADE and o.NOME = t.ORGANIZACAO_UNIVERSITARIA
            join UNIVERSIDADE u 
                on u.CODIGO_MEC = o.UNIVERSIDADE
            where t.genero = :genero 
                AND o.UNIVERSIDADE = :universidade 
                AND o.NOME = :nome_curso
        """

        times = db_assist.cursor.execute(query, data).fetchall()

        return {"message": times}
    
    except Exception as err:
        logger.error(err)
        raise HTTPException(status_code=500, detail="Internal Server Error")
    
    finally:
        end_time = time()
        duration = end_time - start_time
        logger.info(LoggerMessages.time_info(duration=duration))


