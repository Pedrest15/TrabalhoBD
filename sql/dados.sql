-- inserindo na tabela organizacao_universitaria
INSERT INTO Universidade (Codigo_MEC, Nome) VALUES ('123456', 'Universidade Federal de Tecnologia');
INSERT INTO Universidade (Codigo_MEC, Nome) VALUES ('654321', 'Universidade Estadual do Saber');
INSERT INTO Universidade (Codigo_MEC, Nome) VALUES ('789123', 'Universidade Municipal de Aprendizado');
INSERT INTO Universidade (Codigo_MEC, Nome) VALUES ('15715', 'Universidade de São Paulo');
INSERT INTO Universidade (Codigo_MEC, Nome) VALUES ('1302', 'Universidade Federal de São Carlos');

-- inserindo na tabela organizacao_universitaria
INSERT INTO Organizacao_Universitaria (Universidade, Nome, Tipo) VALUES ('123456', 'Liga da Engenharia', 'CURSO');
INSERT INTO Organizacao_Universitaria (Universidade, Nome, Tipo) VALUES ('15715', 'Liga da Engenharia', 'CURSO');
INSERT INTO Organizacao_Universitaria (Universidade, Nome, Tipo) VALUES ('1302', 'Atlética UFSCar', 'Atlética');
INSERT INTO Organizacao_Universitaria (Universidade, Nome, Tipo) VALUES ('15715', 'CAASO', 'ATLÉTICA');
INSERT INTO Organizacao_Universitaria (Universidade, Nome, Tipo) VALUES ('15715', 'ENGENHARIA DE COMPUTAÇÃO', 'CURSO');
INSERT INTO Organizacao_Universitaria (Universidade, Nome, Tipo) VALUES ('1302', 'ENGENHARIA DE COMPUTAÇÃO', 'CURSO');

-- inserindo na tabela atletica
INSERT INTO ATLETICA (UNIVERSIDADE, NOME) VALUES ('15715', 'CAASO');
INSERT INTO ATLETICA (UNIVERSIDADE, NOME) VALUES ('1302', 'Atlética UFSCar');

-- inserindo na tabela curso
INSERT INTO CURSO (UNIVERSIDADE, NOME) VALUES ('15715', 'ENGENHARIA DE COMPUTAÇÃO');
INSERT INTO CURSO (UNIVERSIDADE, NOME) VALUES ('1302', 'ENGENHARIA DE COMPUTAÇÃO');

-- inserindo na tabela esporte
INSERT INTO Esporte (Nome, Numero_Titulares, Numero_Reservas, Equipamento) VALUES ('Futebol', 11, 7, 'Bola');
INSERT INTO Esporte (Nome, Numero_Titulares, Numero_Reservas, Equipamento) VALUES ('Vôlei', 6, 6, 'Bola');
INSERT INTO Esporte (Nome, Numero_Titulares, Numero_Reservas, Equipamento) VALUES ('Basquete', 5, 7, 'Bola');

-- inserindo na tabela local
INSERT INTO Local (ID, RUA, BAIRRO, NUMERO, CIDADE, UF) VALUES (0, 'Rua A', 'Bairro A', 123, 'São Carlos', 'SP');
INSERT INTO Local (ID, RUA, BAIRRO, NUMERO, CIDADE, UF) VALUES (1, 'Rua B', 'Bairro B', 123, 'São Carlos', 'SP');

-- inserindo dados na tabela time
INSERT INTO Time (Esporte, Universidade, Organizacao_Universitaria, Genero) VALUES ('Futebol', '15715', 'CAASO', 'M');
INSERT INTO Time (Esporte, Universidade, Organizacao_Universitaria, Genero) VALUES ('Futebol', '15715', 'CAASO', 'F');
INSERT INTO Time (Esporte, Universidade, Organizacao_Universitaria, Genero) VALUES ('Vôlei', '15715', 'CAASO', 'M');
INSERT INTO Time (Esporte, Universidade, Organizacao_Universitaria, Genero) VALUES ('Vôlei', '15715', 'CAASO', 'F');
INSERT INTO Time (Esporte, Universidade, Organizacao_Universitaria, Genero) VALUES ('Futebol', '1302', 'Atlética UFSCar', 'M');
INSERT INTO Time (Esporte, Universidade, Organizacao_Universitaria, Genero) VALUES ('Futebol', '1302', 'Atlética UFSCar', 'F');

-- inserindo dados na tabela juiz
INSERT INTO Juiz (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Anos_Experiencia, Salario, Esporte) VALUES ('32165498712', 'André Gomes', 'M', 40, 'Rua Juízes', 'Centro', 'Porto Alegre', 'RS', '51988885555', 15, 4500.00, 'Futebol');
INSERT INTO Juiz (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Anos_Experiencia, Salario, Esporte) VALUES ('65432178909', 'Fernanda Lima', 'F', 35, 'Rua dos Árbitros', 'Zona Sul', 'Recife', 'PE', '81999997777', 12, 4000.00, 'Vôlei');
INSERT INTO Juiz (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Anos_Experiencia, Salario, Esporte) VALUES ('78965412301', 'Pedro Almeida', 'M', 28, 'Avenida Apitos', 'Zona Leste', 'São Paulo', 'SP', '11955554444', 5, 3500.00, 'Basquete');
INSERT INTO Juiz (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Anos_Experiencia, Salario, Esporte) VALUES ('89012345678', 'Juliana Souza', 'F', 33, 'Av. Sete de Setembro', 'Rebouças', 'Curitiba', 'PR', '41912345678', 10, 3800.00, 'Vôlei');

-- inserindo dados na tabela atleta
INSERT INTO Atleta (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Codigo_Matricula, Ano_Ingresso, Universidade, Nome_Curso) VALUES ('12345678901', 'MICHEL HECKER FARIA', 'M', 22, 'Rua das Flores', 'Centro', 'São Carlos', 'SP', '11988887777', '12609690', 2021, 15715, 'ENGENHARIA DE COMPUTAÇÃO');
INSERT INTO Atleta (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Codigo_Matricula, Ano_Ingresso, Universidade, Nome_Curso) VALUES ('12345678902', 'PEDRO LUCAS DE CASTRO ANDRADE', 'M', 22, 'Rua das Flores', 'Centro', 'São Carlos', 'SP', '11988887771', '12609691', 2020, 15715, 'ENGENHARIA DE COMPUTAÇÃO');

-- inserindo dados na tabela atleta_participa_atletica
INSERT INTO ATLETA_PARTICIPA_ATLETICA (ATLETA, UNIVERSIDADE, NOME_ATLETICA) VALUES ('12345678901', 15715, 'CAASO');
INSERT INTO ATLETA_PARTICIPA_ATLETICA (ATLETA, UNIVERSIDADE, NOME_ATLETICA) VALUES ('12345678902', 15715, 'CAASO');

-- inserindo dados na tabela regras_esportes
INSERT INTO REGRAS_ESPORTES (ESPORTE, REGRA) VALUES ('Futebol', 'Dois times de 11 jogadores cada. A duração padrão é de 90 minutos.');
INSERT INTO REGRAS_ESPORTES (ESPORTE, REGRA) VALUES ('Vôlei', 'Dois times de 6 jogadores. Jogo é disputado em 5 sets.');
INSERT INTO REGRAS_ESPORTES (ESPORTE, REGRA) VALUES ('Basquete', 'Dois times de 5 jogadores. Jogo com 4 períodos de 10 minutos.');

-- inserindo dados na tabela treinador
INSERT INTO Treinador (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Anos_Experiencia, Salario, Time) VALUES ('12345678901', 'Carlos Silva', 'M', 45, 'Rua das Flores', 'Centro', 'São Paulo', 'SP', '11987654321', 20, 7500.00, 1);
INSERT INTO Treinador (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Anos_Experiencia, Salario, Time) VALUES ('98765432100', 'Ana Pereira', 'F', 38, 'Avenida Paulista', 'Bela Vista', 'São Paulo', 'SP', '11912345678', 15, 6800.50, 2);
INSERT INTO Treinador (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Anos_Experiencia, Salario, Time) VALUES ('45678912345', 'João Santos', 'M', 50, 'Rua das Palmeiras', 'Vila Mariana', 'São Paulo', 'SP', '11911223344', 25, 8500.75, 3);
INSERT INTO Treinador (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Anos_Experiencia, Salario, Time) VALUES ('65432198765', 'Mariana Oliveira', 'F', 29, 'Rua das Acácias', 'Jardim Europa', 'Rio de Janeiro', 'RJ', '21987651234', 5, 4500.00, 4);
INSERT INTO Treinador (CPF, Nome, Genero, Idade, Rua, Bairro, Cidade, UF, Telefone, Anos_Experiencia, Salario, Time) VALUES ('78912345678', 'Pedro Costa', 'M', 34, 'Rua do Comércio', 'Centro', 'Belo Horizonte', 'MG', '31987654321', 10, 6200.00, 5);

-- inserindo dados na tabela torneio
INSERT INTO Torneio (Nome, Tipo, Campeao) VALUES ('TUSCA 2024', 'ATLÉTICA', 'CAASO');
INSERT INTO Torneio (Nome, Tipo, Campeao) VALUES ('TUSCA 2023', 'ATLÉTICA', 'CAASO');
INSERT INTO Torneio (Nome, Tipo, Campeao) VALUES ('INTERCURSO 2024 USP SÃO CARLOS', 'CURSO', NULL);
INSERT INTO Torneio (Nome, Tipo, Campeao) VALUES ('TUSCA 2021', 'ATLÉTICA', NULL);

-- inserindo dados na tabela jogo
INSERT INTO Jogo (Torneio, Local, DataHora) VALUES ('TUSCA 2024', 0, TO_DATE('2024-12-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Jogo (Torneio, Local, DataHora) VALUES ('TUSCA 2024', 0, TO_DATE('2024-12-11 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Jogo (Torneio, Local, DataHora) VALUES ('TUSCA 2023', 1, TO_DATE('2023-10-09 17:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Jogo (Torneio, Local, DataHora) VALUES ('TUSCA 2024', 1, TO_DATE('2024-10-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));


-- inserindo dados na tabela atleta_participa_time
INSERT INTO Atleta_Participa_Time (Atleta, Time) VALUES ('12345678901', 1);
INSERT INTO Atleta_Participa_Time (Atleta, Time) VALUES ('12345678902', 1);

-- inserindo dados na tabela time_disputa_jogo
INSERT INTO Time_Disputa_Jogo (Time, Jogo, Pontos) VALUES (1, 1, 1);
INSERT INTO Time_Disputa_Jogo (Time, Jogo, Pontos) VALUES (5, 1, 0);
INSERT INTO Time_Disputa_Jogo (Time, Jogo, Pontos) VALUES (2, 2, 2);
INSERT INTO Time_Disputa_Jogo (Time, Jogo, Pontos) VALUES (6, 2, 4);
INSERT INTO Time_Disputa_Jogo (Time, Jogo, Pontos) VALUES (1, 3, 0);
INSERT INTO Time_Disputa_Jogo (Time, Jogo, Pontos) VALUES (5, 3, 0);

-- inserindo dados na tabela juiz_apita_jogo
INSERT INTO Juiz_Apita_Jogo (Jogo, Juiz) VALUES (1, '32165498712');
INSERT INTO Juiz_Apita_Jogo (Jogo, Juiz) VALUES (2, '65432178909');
INSERT INTO Juiz_Apita_Jogo (Jogo, Juiz) VALUES (3, '78965412301');
