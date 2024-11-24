from loguru import logger
import os

log_directory = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'logs')

# se a pasta logs nao existir, sera criada
if not os.path.exists(log_directory):
    os.makedirs(log_directory)

logger.add('logs/api_infos.log',
            format="{time} {level} | {file} | {function} | {message}",
            level="INFO",
            rotation="5 MB",   # tamanho max de 5 MB
            retention=5  # 5 arquivos de backup
            )

class LoggerMessages:

    @staticmethod
    def time_info(duration:float):
        return f"Requisição durou {duration:.2f} seg."

    