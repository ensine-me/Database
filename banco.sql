-- Drop e create database
DROP DATABASE IF EXISTS ensineme;
CREATE DATABASE ensineme;
\c ensineme;

-- Criação de tabelas
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(80),
    email VARCHAR(255),
    senha VARCHAR(45),
    data_nasc DATE,
    is_professor BOOLEAN,
    qtd_experiencia INTEGER,
    foto_perfil VARCHAR(255)
);

CREATE TABLE log_experiencia(
    quantidade INTEGER,
    data_adquirida TIMESTAMP,
    fk_usuario INTEGER REFERENCES usuario (id_usuario)
);

CREATE TABLE chat(
    id_chat SERIAL PRIMARY KEY
);

CREATE TABLE chat_participante(
    fk_usuario INTEGER REFERENCES usuario (id_usuario),
    fk_chat INTEGER REFERENCES chat (id_chat),
    PRIMARY KEY (fk_usuario, fk_chat)
);

CREATE TABLE disciplina(
    id_disciplina SERIAL PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE disciplina_usuario(
    fk_disciplina INTEGER REFERENCES disciplina (id_disciplina),
    fk_usuario INTEGER REFERENCES usuario (id_usuario)
);

CREATE TABLE professor(
    id_professor SERIAL PRIMARY KEY,
    fk_usuario INTEGER REFERENCES usuario (id_usuario),
    descricao VARCHAR(2550),
    preco_hora_aula DECIMAL(5, 2)
);

CREATE TABLE disponibilidade_professor(
    fk_professor INTEGER REFERENCES professor (id_professor),
    dia_semana VARCHAR(10),
    horario_inicio TIME,
    horario_fim TIME
);

CREATE TABLE formacao(
    id_formacao SERIAL PRIMARY KEY,
    data_inicio DATE,
    data_termino DATE,
    instituicao VARCHAR(100),
    nome_curso VARCHAR(30),
    tipo_formacao VARCHAR(20),
    fk_professor INTEGER REFERENCES professor (id_professor)
);

CREATE TABLE horario_disponivel(
    id_horario_disponivel SERIAL PRIMARY KEY,
    fk_professor INTEGER REFERENCES professor (id_professor),
    data_hora_inicial TIMESTAMP,
    data_hora_final TIMESTAMP
);

CREATE TABLE aula(
    id_aula SERIAL PRIMARY KEY,
    fk_professor INTEGER REFERENCES professor (id_professor),
    fk_disciplina INTEGER REFERENCES disciplina (id_disciplina),
    titulo VARCHAR(255),
    data_hora TIMESTAMP,
    descricao VARCHAR(255),
    limite_participantes INTEGER,
    duracao_segundos INTEGER,
    status_aula VARCHAR(35),
    preco DECIMAL(5, 2)
);

CREATE TABLE aluno_aula(
    fk_usuario INTEGER REFERENCES usuario (id_usuario),
    fk_aula INTEGER REFERENCES aula (id_aula),
    PRIMARY KEY (fk_usuario, fk_aula)
);

CREATE TABLE mensagem(
    id_mensagem SERIAL PRIMARY KEY,
    fk_remetente INTEGER REFERENCES usuario (id_usuario),
    fk_chat INTEGER REFERENCES chat (id_chat),
    conteudo VARCHAR(300)
);
