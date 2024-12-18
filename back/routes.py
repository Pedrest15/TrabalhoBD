from fastapi import APIRouter, HTTPException
from log import logger
from models import InsertAtletaRequest, VerifyCpfRequest, SelectTimesRequest
from db import db_assist
import oracledb
from utils import oracle_select_errors, oracle_insert_errors

router = APIRouter()

@router.get("/uf-code")
async def get_uf_code():
    try:
        sig = db_assist.select(table='UF_CODE', columns_wanted=['CODIGO_UF','SIGLA'], orderby_asc=True, order_column="SIGLA")
        siglas = [{"CODIGO_UF": s[0], "SIGLA": s[1]} for s in sig]

        return {"message": siglas}
    
    except oracledb.DatabaseError as err:
        oracle_select_errors(err)  # Chama a função de tratamento
    except oracledb.IntegrityError as err:
        raise HTTPException(
            status_code=400,
            detail=f"Erro de integridade no banco de dados: {err}"
        )
    except Exception as err:
        logger.error(err)
        raise HTTPException(
            status_code=500,
            detail="Erro interno no servidor"
        )

@router.get("/universidades")
async def get_universidades():
    try:
        uni = db_assist.select(table='UNIVERSIDADE', columns_wanted=['CODIGO_MEC', 'NOME'])
        universidades = [{"CODIGO_MEC": u[0], "NOME": u[1]} for u in uni]

        return {"message": universidades}
    
    except oracledb.DatabaseError as err:
        oracle_select_errors(err)  # Chama a função de tratamento
    except oracledb.IntegrityError as err:
        raise HTTPException(
            status_code=400,
            detail=f"Erro de integridade no banco de dados: {err}"
        )
    except Exception as err:
        logger.error(err)
        raise HTTPException(
            status_code=500,
            detail="Erro interno no servidor"
        )

@router.get("/cursos")
async def get_cursos(universidade_codigo: str = None):
    if not universidade_codigo:
        raise HTTPException(status_code=400, detail="universidade_codigo é necessário")

    try:
        cur = db_assist.select(table='CURSO', columns_wanted=['NOME'], where_data={"UNIVERSIDADE": universidade_codigo})
        cursos = [{"NOME": c[0]} for c in cur]

        return {"message": cursos}
    
    except oracledb.DatabaseError as err:
        oracle_select_errors(err)  # Chama a função de tratamento
    except oracledb.IntegrityError as err:
        raise HTTPException(
            status_code=400,
            detail=f"Erro de integridade no banco de dados: {err}"
        )
    except Exception as err:
        logger.error(err)
        raise HTTPException(
            status_code=500,
            detail="Erro interno no servidor"
        )

@router.post("/insert-atleta")
async def insert_atleta(request: InsertAtletaRequest):
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
    
    except oracledb.DatabaseError as err:
        oracle_insert_errors(err)  # Chama a função de tratamento
    except oracledb.IntegrityError as err:
        raise HTTPException(
            status_code=400,
            detail=f"Problema de integridade no banco de dados: {err}"
        )
    except Exception as err:
        logger.error(err)
        raise HTTPException(
            status_code=500,
            detail="Erro interno no servidor"
        )

@router.post("/times")
async def get_times(request: SelectTimesRequest):
    try:
        data={
            "genero": 'M' if request.genero == "Masculino" else 'F',
            "universidade": request.universidade,
            "nome_curso": request.nome_curso.upper()
            }

        query = """
            (
                SELECT t.esporte, u.NOME AS "Universidade", o.NOME AS "Organização", t.genero, tr.NOME AS "Treinador"
                FROM TIME t
                JOIN ORGANIZACAO_UNIVERSITARIA o 
                    ON o.UNIVERSIDADE = t.UNIVERSIDADE AND o.NOME = t.ORGANIZACAO_UNIVERSITARIA
                JOIN UNIVERSIDADE u 
                    ON u.CODIGO_MEC = o.UNIVERSIDADE
                JOIN TREINADOR tr ON tr.TIME = t.ID
                where t.genero = :genero 
                    AND o.UNIVERSIDADE = :universidade 
                    AND o.NOME = :nome_curso
            )
            UNION
            (
                SELECT t.esporte, u.NOME AS "Universidade", atl.NOME AS "Organização", t.genero, tr.NOME AS "Treinador"
                FROM TIME t
                JOIN ATLETICA atl ON atl.UNIVERSIDADE = t.UNIVERSIDADE AND atl.NOME = t.ORGANIZACAO_UNIVERSITARIA
                JOIN UNIVERSIDADE u
                    ON u.CODIGO_MEC = t.UNIVERSIDADE
                JOIN TREINADOR tr ON tr.TIME = t.ID
                WHERE t.genero = :genero 
                    AND t.UNIVERSIDADE = :universidade
            )
        """

        times = db_assist.cursor.execute(query, data).fetchall()

        times_list = []
        for t in times:
            times_list.append({
                "esporte": t[0],
                "universidade": t[1],
                "organizacao": t[2],
                "genero": 'Masculino' if t[3] == 'M' else 'Feminino',
                "treinador": t[4]
            })

        # Retornando os dados
        return {
            "message": True,
            "times": times_list
        }
    
    except oracledb.DatabaseError as err:
        oracle_select_errors(err)  # Chama a função de tratamento
    except oracledb.IntegrityError as err:
        raise HTTPException(
            status_code=400,
            detail=f"Erro de integridade no banco de dados: {err}"
        )
    except Exception as err:
        logger.error(err)
        raise HTTPException(
            status_code=500,
            detail="Erro interno no servidor"
        )

@router.post("/verify-cpf")
def verify_cpf(request: VerifyCpfRequest):
    try:
        cpf = request.cpf

        # Consulta no banco
        atleta = db_assist.select(
            table="ATLETA", 
            columns_wanted=["CPF"], 
            where_data={"CPF": cpf}, 
            return_one=True
        )

        # Retorna se o CPF foi encontrado
        if atleta:
            return {"message": True}
        return {"message": False}
    
    # Tratamento de erros do banco de dados
    except oracledb.DatabaseError as err:
        oracle_select_errors(err)  # Chama a função de tratamento
    except oracledb.IntegrityError as err:
        raise HTTPException(
            status_code=400,
            detail=f"Erro de integridade no banco de dados: {err}"
        )
    except Exception as err:
        logger.error(err)
        raise HTTPException(
            status_code=500,
            detail="Erro interno no servidor"
        )

@router.post("/get-atleta-infos")
def get_atleta_infos(request: VerifyCpfRequest):  
    try:
        # Dados para a consulta
        data = {"cpf": request.cpf}

        # Query SQL
        query = """
            SELECT 
                A.CPF,
                A.NOME,
                A.IDADE,
                CASE 
                    WHEN A.GENERO = 'M' THEN 'Masculino'
                    ELSE 'Feminino'
                END AS GENERO,
                A.TELEFONE,
                A.CIDADE || ' - ' || UF.SIGLA AS ENDERECO,
                A.UNIVERSIDADE,
                A.NOME_CURSO
            FROM 
                ATLETA A
            JOIN UF_CODE UF ON A.UF = UF.CODIGO_UF
            WHERE A.CPF = :cpf
        """

        # Execução da consulta
        atleta = db_assist.cursor.execute(query, data).fetchone()

        # Verifica se o CPF foi encontrado
        if not atleta:
            raise HTTPException(
                status_code=404,
                detail="Atleta não encontrado para o CPF informado."
            )

        # Retorno dos dados
        return {
            "message": True,
            "cpf": atleta[0],
            "nome": atleta[1],
            "idade": atleta[2],
            "genero": atleta[3],
            "telefone": atleta[4],
            "endereco": atleta[5],
            "universidade": atleta[6],
            "curso": atleta[7]
        }
    
    # Tratamento de erros do banco de dados
    except oracledb.DatabaseError as err:
        oracle_select_errors(err)  # Chama a função de tratamento
    except oracledb.IntegrityError as err:
        raise HTTPException(
            status_code=400,
            detail=f"Erro de integridade no banco de dados: {err}"
        )
    except Exception as err:
        logger.error(err)
        raise HTTPException(
            status_code=500,
            detail="Erro interno no servidor"
        )

