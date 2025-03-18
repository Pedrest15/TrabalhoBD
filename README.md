# TrabalhoBD

## Project Overview
This project is a FastAPI-based application that interacts with an Oracle database. It provides an API for managing athletes, universities, and sports teams, handling data insertion, querying, and validation.

## Features
- **FastAPI Framework**: A modern, fast (high-performance) web framework for API development.
- **Oracle Database Integration**: Uses `oracledb` to interact with an Oracle database.
- **CRUD Operations**: Supports creating, reading, updating, and deleting database records.
- **Logging**: Implements structured logging using `loguru`.
- **Error Handling**: Handles database and application errors efficiently.
- **CORS Support**: Enables cross-origin requests using `CORSMiddleware`.

## Dependencies
Before running the project, ensure you have the following dependencies installed:
- Python (>= 3.8)
- FastAPI
- Uvicorn
- Oracledb
- Loguru
- Pydantic
- Pydantic-settings

### Requirements File
If you do not have a `requirements.txt` file, create one with the following content:
```txt
fastapi
uvicorn
oracledb
loguru
pydantic
pydantic-settings
```

## Installation
1. **Clone the repository:**
   ```sh
   git clone https://github.com/Pedrest15/TrabalhoBD.git
   cd TrabalhoBD
   ```
2. **Create a virtual environment (optional but recommended):**
   ```sh
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   ```
3. **Install dependencies:**
   ```sh
   pip install -r requirements.txt
   ```

## Configuration
1. **Set up the database:**
   - Create an Oracle database instance.
   - Update the `.env` file with database credentials:
     ```env
     DB_USER=your_username
     DB_PASSWORD=your_password
     DB_DNS=your_database_dsn
     ```
2. **Load environment variables:**
   ```sh
   export $(cat .env | xargs)
   ```

## Usage
1. **Run the application:**
   ```sh
   uvicorn app:app --host 127.0.0.1 --port 2000 --reload
   ```
2. **Access the API:**
   - Open your browser and go to `http://127.0.0.1:2000/docs` for interactive API documentation.
   - Use API endpoints to insert, retrieve, and manage data.

## API Endpoints
- `GET /uf-code` - Fetches state codes and abbreviations.
- `GET /universidades` - Retrieves university names and codes.
- `GET /cursos` - Retrieves courses from a specific university.
- `POST /insert-atleta` - Inserts a new athlete record.
- `POST /times` - Fetches sports teams based on criteria.
- `POST /verify-cpf` - Checks if an athlete exists by CPF.
- `POST /get-atleta-infos` - Retrieves detailed athlete information.

## Logging
- Logs are stored in the `logs` directory.
- Uses `loguru` to log request details and errors.

## Contributing
If you want to contribute:
- Fork the repository
- Create a new branch (`git checkout -b feature-branch`)
- Commit your changes (`git commit -m 'Add new feature'`)
- Push to your branch (`git push origin feature-branch`)
- Open a Pull Request

## License
This project is licensed under the MIT License. See `LICENSE` for more details.

## Contact
For any questions or suggestions, feel free to open an issue or contact the repository owner.
