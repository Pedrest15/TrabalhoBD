from oracledb import DatabaseError
from fastapi import HTTPException
from log import logger

def oracle_select_errors(err:DatabaseError):
    error_code = err.args[0].code
    error_message = err.args[0].message

    if error_code == 942:  # ORA-00942: Table or view does not exist
        raise HTTPException(
            status_code=400,
            detail=f"Tabela ou view não encontrada. Verifique a configuração do banco. Mensagem do erro: {error_message}"
        )
    elif error_code == 904:  # ORA-00904: Invalid identifier
        raise HTTPException(
            status_code=400,
            detail=f"Coluna inválida especificada na consulta. Mensagem do erro: {error_message}"
        )
    elif error_code == 918:  # ORA-00918: Column ambiguously defined
        raise HTTPException(
            status_code=400,
            detail=f"Coluna definida de forma ambígua na consulta. Mensagem do erro: {error_message}"
        )
    elif error_code == 1403:  # ORA-01403: No data found
        raise HTTPException(
            status_code=404,
            detail="Nenhum dado encontrado para a consulta especificada."
        )
    elif error_code == 1406:  # ORA-01406: Fetched column value was truncated
        raise HTTPException(
            status_code=500,
            detail=f"Valor da coluna truncado. Mensagem do erro: {error_message}"
        )
    elif error_code == 12899:  # ORA-12899: Value too large for column
        raise HTTPException(
            status_code=400,
            detail=f"Valor excede o tamanho permitido para uma coluna. Mensagem do erro: {error_message}"
        )
    else:
        # Log para erros desconhecidos
        logger.error(f"Código {error_code} - {error_message}")
        raise HTTPException(
            status_code=500,
            detail=f"Código: {error_code}. Mensagem: {error_message}"
        )
    
def oracle_insert_errors(err: DatabaseError):
    error_code = err.args[0].code
    error_message = err.args[0].message

    if error_code == 1:  # ORA-00001: Unique constraint violated
        raise HTTPException(
            status_code=400,
            detail=f"Um registro com esses dados já existe. Mensagem do erro: {error_message}"
        )
    elif error_code == 1400:  # ORA-01400: Cannot insert NULL into column
        raise HTTPException(
            status_code=400,
            detail=f"Um campo obrigatório está ausente. Mensagem do erro: {error_message}"
        )
    elif error_code == 12899:  # ORA-12899: Value too large for column
        raise HTTPException(
            status_code=400,
            detail=f"Valor excede o tamanho permitido para uma coluna. Mensagem do erro: {error_message}"
        )
    elif error_code == 2291:  # ORA-02291: Foreign key constraint violated
        raise HTTPException(
            status_code=400,
            detail=f"Valor fornecido não existe na tabela relacionada. Mensagem do erro: {error_message}"
        )
    elif error_code == 2292:  # ORA-02292: Child record found, cannot delete parent
        raise HTTPException(
            status_code=400,
            detail=f"Tentativa de inserir dados conflitantes com registros filhos. Mensagem do erro: {error_message}"
        )
    else:
        # Log para erros desconhecidos
        logger.error(f"Código {error_code} - {error_message}")
        raise HTTPException(
            status_code=500,
            detail=f"Código: {error_code}. Mensagem: {error_message}"
        )