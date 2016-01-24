
CREATE DATABASE desafio_integragrp
WITH OWNER = postgres
ENCODING = 'UTF8'
TABLESPACE = pg_default
LC_COLLATE = 'en_US.UTF-8'
LC_CTYPE = 'en_US.UTF-8'
CONNECTION LIMIT = -1;

-- Table: conta

-- DROP TABLE conta;

CREATE TABLE conta
(
id character(6) NOT NULL DEFAULT lpad(((nextval('sq_exemplo'::regclass))::character(6))::text, 6, '0'::text),
correntista_id integer,
flag_ativo character(1) DEFAULT 'S'::bpchar,
created_at timestamp with time zone,
updated_at timestamp with time zone,
saldo numeric(20,2),
CONSTRAINT conta_pkey PRIMARY KEY (id),
CONSTRAINT conta_correntista_id_fkey FOREIGN KEY (correntista_id)
REFERENCES correntista (id) MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE conta
OWNER TO postgres;


-- Table: correntista

-- DROP TABLE correntista;

CREATE TABLE correntista
(
id serial NOT NULL,
cpf character varying(11),
nome character varying(50),
datanascimento date,
endereco character varying(255),
numero integer,
bairro character varying(50),
cidade character varying(50),
estado character varying(2),
created_at timestamp with time zone,
users_id integer,
CONSTRAINT correntista_pkey PRIMARY KEY (id),
CONSTRAINT users_id FOREIGN KEY (users_id)
REFERENCES users (id) MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE correntista
OWNER TO postgres;

-- Index: fki_users_id

-- DROP INDEX fki_users_id;

CREATE INDEX fki_users_id
ON correntista
USING btree
(users_id);

-- Table: deposito

-- DROP TABLE deposito;

CREATE TABLE deposito
(
id serial NOT NULL,
valor numeric(20,2),
created_at timestamp with time zone,
conta_destino_id character(6) NOT NULL,
conta_origem_id character(6),
taxa numeric(10,2),
CONSTRAINT deposito_pkey PRIMARY KEY (id),
CONSTRAINT deposito_conta_destino_id_fkey FOREIGN KEY (conta_destino_id)
REFERENCES conta (id) MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT deposito_conta_origem_id_fkey FOREIGN KEY (conta_origem_id)
REFERENCES conta (id) MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE deposito
OWNER TO postgres;
-- Table: saque

-- DROP TABLE saque;

CREATE TABLE saque
(
id integer NOT NULL DEFAULT nextval('saques_id_seq'::regclass),
valor numeric(20,2),
created_at timestamp with time zone,
conta_id character(6) NOT NULL,
CONSTRAINT saques_pkey PRIMARY KEY (id),
CONSTRAINT saques_conta_origem_id_fkey FOREIGN KEY (conta_id)
REFERENCES conta (id) MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE saque
OWNER TO postgres;
-- Table: users

-- DROP TABLE users;

CREATE TABLE users
(
id serial NOT NULL,
email character varying NOT NULL DEFAULT ''::character varying,
encrypted_password character varying NOT NULL DEFAULT ''::character varying,
reset_password_token character varying,
reset_password_sent_at timestamp without time zone,
remember_created_at timestamp without time zone,
sign_in_count integer NOT NULL DEFAULT 0,
current_sign_in_at timestamp without time zone,
last_sign_in_at timestamp without time zone,
current_sign_in_ip inet,
last_sign_in_ip inet,
created_at timestamp without time zone NOT NULL,
updated_at timestamp without time zone NOT NULL,
CONSTRAINT users_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE users
OWNER TO postgres;

-- Index: index_users_on_email

-- DROP INDEX index_users_on_email;

CREATE UNIQUE INDEX index_users_on_email
ON users
USING btree
(email COLLATE pg_catalog."default");

-- Index: index_users_on_reset_password_token

-- DROP INDEX index_users_on_reset_password_token;

CREATE UNIQUE INDEX index_users_on_reset_password_token
ON users
USING btree
(reset_password_token COLLATE pg_catalog."default");
