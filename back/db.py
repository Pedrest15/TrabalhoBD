import oracledb
from settings import settings

class DB:
    """
        Classe generica para fazer conexao com BD Oracle.
    """

    def __init__(self, user:str, password:str, dns:str):
        """
            Instancia objeto e estabele a conexao com banco desejado.

            - Args:
                - conn_info (str): endereço para se conectar.
        """
        self.conn = oracledb.connect(user=user, password=password, dsn=dns)
        self.cursor = self.conn.cursor()
    
    def close(self):
        """
            Encerra conexao com banco.
        """
        self.cursor.close()
        self.conn.close()

    def insert(self, table: str, data: dict) -> None:
        """
            Metodo generico para realizar inserts em uma tabela. Caso ocorra erro, o banco volta para a situação anterior ao insert.

            - Args:
                - table (str): Nome da tabela que se deseja inserir novos dados.
                - data (dict): Dicionario onde as chaves são os nomes das colunas e os valores sao os dados a serem inseridos.
        """
        try:
            columns_names = ', '.join(data.keys())
            placeholders = ', '.join([f":{key}" for key in data.keys()])

            query = f"""
                INSERT INTO {table} ({columns_names}) VALUES ({placeholders})
            """

            self.cursor.execute(query, data)
            self.conn.commit()

        except Exception as err:
            self.conn.rollback()
            raise err
        
    def select(self, table: str, columns_wanted: list[str] = None,
               where_data: dict = None, return_one: bool = False,
               orderby_asc:bool=None, order_column:str=None) -> list[any]:
        """
            Metodo generico para realizar selects em uma tabela.

            - Args:
                - table (str): Nome da tabela que se deseja consultar.
                - columns_wanted (list[str]): Lista de nomes das colunas que se deseja consultar.
                - where_data (dict): Dicionario com colunas e valores para a cláusula WHERE {coluna: valor}.
                - return_one (bool): Indica se deseja retornar a primeira tupla da consulta (True),
                ou a consulta inteira (default=False).

            - Returns:
                - (list[tuple] | tuple): Retorna a consulta inteira ou apenas a primeira tupla.
        """
        try:
            select_columns = ', '.join(columns_wanted) if columns_wanted else '*'

            query = f"SELECT {select_columns} FROM {table}"

            if where_data:
                where_clause = ' AND '.join([f"{col} = :{col}" for col in where_data.keys()])
                query += f" WHERE {where_clause}"
                params = where_data
                if order_column:
                    order_clause = f" ORDER BY {order_column} {'ASC' if orderby_asc else 'DESC'}"
                    query += order_clause
                self.cursor.execute(query, params)
            else:
                if order_column:
                    order_clause = f" ORDER BY {order_column} {'ASC' if orderby_asc else 'DESC'}"
                    query += order_clause
                self.cursor.execute(query)

            # Retorna o resultado conforme o valor de return_one
            return self.cursor.fetchone() if return_one else self.cursor.fetchall()

        except Exception as err:
            raise err
        
db_assist = DB(user=settings.DB_USER, password=settings.DB_PASSWORD, dns=settings.DB_DNS)





