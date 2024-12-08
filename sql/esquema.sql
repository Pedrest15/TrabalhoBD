-- cria tabela esporte
CREATE TABLE Esporte (
    Nome VARCHAR2(50) NOT NULL,
    Numero_Titulares NUMBER NOT NULL,
    Numero_Reservas NUMBER NOT NULL,
    Equipamento VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_ESPORTE PRIMARY KEY (Nome)
);

-- cria tabela juiz
CREATE TABLE Juiz (
    CPF VARCHAR2(11) NOT NULL,
    Nome VARCHAR2(50) NOT NULL,
    Genero CHAR(1),
    Idade NUMBER,
    Rua VARCHAR2(50),
    Bairro VARCHAR2(50),
    Numero NUMBER(5),
    Cidade VARCHAR2(50),
    UF CHAR(2),
    Telefone VARCHAR2(15),
    Anos_Experiencia NUMBER NOT NULL,
    Salario NUMBER(10, 2) NOT NULL,
    Esporte VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_JUIZ PRIMARY KEY(CPF),
    CONSTRAINT FK_JUIZ_ESPORTE FOREIGN KEY(Esporte) REFERENCES Esporte(Nome)
);

-- cria tabela universidade
CREATE TABLE Universidade (
    Codigo_MEC VARCHAR2(10) NOT NULL,
    Nome VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_UNIVERSIDADE PRIMARY KEY (Codigo_MEC)
);

-- cria tabela organizacao_universitaria
CREATE TABLE Organizacao_Universitaria (
    Universidade VARCHAR2(10) NOT NULL,
    Nome VARCHAR2(100) NOT NULL,
    Tipo VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_ORGANIZACAO_UNIVERSITARIA PRIMARY KEY (Universidade, Nome),
    CONSTRAINT FK_ORGANIZACAO_UNIVERSITARIA_UNIVERSIDADE FOREIGN KEY (Universidade) REFERENCES Universidade (Codigo_MEC) ON DELETE CASCADE,
    CONSTRAINT CK_ORGANIZACAO_UNIVERSITARIA_TIPO CHECK (UPPER(Tipo) IN ('ATLÉTICA', 'CURSO'))
);

-- cria tabela atletica
CREATE TABLE Atletica (
    Universidade VARCHAR2(10) NOT NULL,
    Nome VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_ATLETICA PRIMARY KEY (Universidade, Nome),
    CONSTRAINT FK_ATLETICA_ORGANIZACAO_UNIVERSITARIA FOREIGN KEY (Universidade, Nome) REFERENCES Organizacao_Universitaria (Universidade, Nome) ON DELETE CASCADE
);

-- cria tabela curso
CREATE TABLE Curso (
    Universidade VARCHAR2(10) NOT NULL,
    Nome VARCHAR2(30) NOT NULL,
    CONSTRAINT PK_CURSO PRIMARY KEY (Universidade, Nome),
    CONSTRAINT FK_CURSO_ORGANIZACAO_UNIVERSITARIA FOREIGN KEY (Universidade, Nome) REFERENCES Organizacao_Universitaria (Universidade, Nome) ON DELETE CASCADE
);

-- cria tabela time
CREATE TABLE Time (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    Esporte VARCHAR2(50) NOT NULL,
    Universidade VARCHAR2(10) NOT NULL,
    Organizacao_Universitaria VARCHAR2(100) NOT NULL,
    Genero CHAR(1) NOT NULL,
    CONSTRAINT PK_TIME PRIMARY KEY (ID), 
    CONSTRAINT SK_TIME UNIQUE (Esporte, Universidade, Organizacao_Universitaria, Genero), 
    CONSTRAINT FK_TIME_ESPORTE FOREIGN KEY (Esporte) REFERENCES Esporte (Nome) ON DELETE CASCADE,
    CONSTRAINT FK_TIME_ORGANIZACAO_UNIVERSITARIA FOREIGN KEY (Universidade, Organizacao_Universitaria) REFERENCES Organizacao_Universitaria (Universidade, Nome) ON DELETE CASCADE
);

-- cria tabela treinador
CREATE TABLE Treinador (
    CPF VARCHAR2(11) NOT NULL,
    Nome VARCHAR2(50) NOT NULL,
    Genero CHAR(1),
    Idade NUMBER,
    Rua VARCHAR2(50),
    Bairro VARCHAR2(50),
    Cidade VARCHAR2(50),
    UF CHAR(2),
    Telefone VARCHAR2(15),
    Anos_Experiencia NUMBER NOT NULL,
    Salario NUMBER(10, 2) NOT NULL,
    Time NUMBER NOT NULL,
    CONSTRAINT PK_TREINADOR PRIMARY KEY (CPF),
    CONSTRAINT SK_TREINADOR UNIQUE (Time),
    CONSTRAINT FK_TREINADOR_TIME FOREIGN KEY (Time) REFERENCES Time (ID) ON DELETE CASCADE

);

-- cria tabela atleta
CREATE TABLE Atleta (
    CPF VARCHAR2(11) NOT NULL,
    Nome VARCHAR2(100) NOT NULL,
    Genero CHAR(1),
    Idade NUMBER,
    Rua VARCHAR2(50),
    Bairro VARCHAR2(50),
    Cidade VARCHAR2(20),
    UF CHAR(2),
    Telefone VARCHAR2(15),
    Codigo_Matricula VARCHAR2(20) NOT NULL, 
    Ano_Ingresso NUMBER NOT NULL,
    Universidade VARCHAR2(10) NOT NULL,
    Nome_Curso VARCHAR2(30) NOT NULL,
    CONSTRAINT PK_ATLETA PRIMARY KEY (CPF),
    CONSTRAINT SK_ATLETA UNIQUE (Codigo_Matricula),
    CONSTRAINT FK_ATLETA_CURSO FOREIGN KEY (Universidade, Nome_Curso) REFERENCES Curso (Universidade, Nome) ON DELETE CASCADE
);

-- cria tabela atleta participa atletica
CREATE TABLE Atleta_Participa_Atletica (
    Atleta VARCHAR2(11) NOT NULL,
    Universidade VARCHAR2(10) NOT NULL,
    Nome_Atletica VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_ATLETA_PARTICIPA_ATLETICA PRIMARY KEY (Atleta),
    CONSTRAINT FK_ATLETA_PARTICIPA_ATLETICA_ATLETICA FOREIGN KEY (Universidade, Nome_Atletica) REFERENCES Atletica (Universidade, Nome)
);

-- cria tabela local
CREATE TABLE Local (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    Rua VARCHAR2(100) NOT NULL,
    Bairro VARCHAR2(100) NOT NULL,
    Numero VARCHAR2(10) NOT NULL,
    Cidade VARCHAR2(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    CONSTRAINT PK_LOCAL PRIMARY KEY (ID),
    CONSTRAINT SK_LOCAL UNIQUE (Rua, Bairro, Numero, Cidade, UF)
);

-- cria tabela torneio
CREATE TABLE Torneio (
    Nome VARCHAR2(100) NOT NULL,
    Tipo VARCHAR2(50) NOT NULL,
    Campeao VARCHAR2(100),
    CONSTRAINT PK_TORNEIO PRIMARY KEY (Nome),
    CONSTRAINT CK_TORNEIO_TIPO CHECK (UPPER(Tipo) IN ('ATLÉTICA', 'CURSO'))
);

-- cria tabela jogo
CREATE TABLE Jogo (
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    Torneio VARCHAR2(100) NOT NULL,
    Local NUMBER NOT NULL,
    DataHora TIMESTAMP NOT NULL,
    Resultado VARCHAR2(50),
    CONSTRAINT PK_JOGO PRIMARY KEY (ID),
    CONSTRAINT SK_JOGO UNIQUE (Torneio, Local, DataHora),
    CONSTRAINT FK_JOGO_TORNEIO FOREIGN KEY (Torneio) REFERENCES Torneio (Nome) ON DELETE CASCADE
);

-- cria tabela time_disputa_jogo
CREATE TABLE Time_Disputa_Jogo (
    Time NUMBER NOT NULL,
    Jogo NUMBER NOT NULL,
    Pontos NUMBER NOT NULL,
    CONSTRAINT PK_TIME_DISPUTA_JOGO PRIMARY KEY (Time, Jogo),
    CONSTRAINT FK_JOGO_DISPUTA_JOGO_TIME FOREIGN KEY (Time) REFERENCES Time (ID) ON DELETE CASCADE,
    CONSTRAINT FK_JOGO_DISPUTA_JOGO_JOGO FOREIGN KEY (Jogo) REFERENCES Jogo (ID) ON DELETE CASCADE
);

-- cria tabela juiz_apita_jogo
CREATE TABLE Juiz_Apita_Jogo (
    Jogo NUMBER NOT NULL,
    Juiz VARCHAR2(11) NOT NULL,
    CONSTRAINT PK_JUIZ_APITA_JOGO PRIMARY KEY (Jogo, Juiz),
    CONSTRAINT FK_JUIZ_APITA_JOGO_JOGO FOREIGN KEY (Jogo) REFERENCES Jogo (ID) ON DELETE CASCADE, 
    CONSTRAINT FK_JUIZ_APITA_JOGO_JUIZ FOREIGN KEY (Juiz) REFERENCES Juiz (CPF) ON DELETE CASCADE
);

-- cria tabela atleta_participa_time
CREATE TABLE Atleta_Participa_Time (
    Atleta VARCHAR2(11) NOT NULL,
    Time NUMBER NOT NULL,
    CONSTRAINT PK_ATLETA_PARTICIPA_TIME PRIMARY KEY (Atleta, Time),
    CONSTRAINT FK_ATLETA_PARTICIPA_TIME FOREIGN KEY (Atleta) REFERENCES Atleta (CPF) ON DELETE CASCADE,
    CONSTRAINT FK_ATLETA_PARTICIPA_TIME_TIME FOREIGN KEY (Time) REFERENCES Time (ID) ON DELETE CASCADE
);

-- cria tabela regras_esportes 
CREATE TABLE Regras_Esportes (
    Esporte VARCHAR2(50) NOT NULL,
    Regra VARCHAR2(255) NOT NULL,
    CONSTRAINT PK_REGRAS_ESPORTES PRIMARY KEY (Esporte, Regra),
    CONSTRAINT FK_REGRAS_ESPORTES_ESPORTE FOREIGN KEY (Esporte) REFERENCES Esporte (Nome) ON DELETE CASCADE
);
