DROP TABLE client CASCADE CONSTRAINTS;
DROP TABLE adossat CASCADE CONSTRAINTS;
DROP TABLE contracte CASCADE CONSTRAINTS;
DROP TABLE cotxe CASCADE CONSTRAINTS;
DROP TABLE empresa CASCADE CONSTRAINTS;
DROP TABLE estada CASCADE CONSTRAINTS;
DROP TABLE estand CASCADE CONSTRAINTS;
DROP TABLE fabricant CASCADE CONSTRAINTS;
DROP TABLE lloguer CASCADE CONSTRAINTS;
DROP TABLE pack CASCADE CONSTRAINTS;
DROP TABLE pertany_a CASCADE CONSTRAINTS;
DROP TABLE plaça CASCADE CONSTRAINTS;
DROP TABLE producte CASCADE CONSTRAINTS;
DROP TABLE tiquet CASCADE CONSTRAINTS;
DROP TABLE venta CASCADE CONSTRAINTS;
DROP TABLE empleat CASCADE CONSTRAINTS;

CREATE TABLE adossat (
    estand_zona1   VARCHAR2(10 CHAR) NOT NULL,
    estand_numero1 INTEGER NOT NULL,
    estand_zona2   VARCHAR2(10 CHAR) NOT NULL,
    estand_numero2 INTEGER NOT NULL
);

CREATE TABLE client (
    dni         VARCHAR2(8 CHAR) NOT NULL,
    nom         VARCHAR2(25 CHAR),
    cognom      VARCHAR2(50 CHAR),
    edat        INTEGER,
    sexe        CHAR(1 CHAR),
    poblacio    VARCHAR2(50 CHAR),
    correu      VARCHAR2(50 CHAR),
    codi_postal VARCHAR2(5 CHAR)
);

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( dni );

CREATE TABLE contracte (
    data_inici            DATE NOT NULL,
    data_fi               DATE NOT NULL,
    empleat_dni           VARCHAR2(8 CHAR) NOT NULL,
    lloguer_data_inici    DATE NOT NULL,
    lloguer_data_fi       DATE NOT NULL,
    lloguer_estand_zona   VARCHAR2(10 CHAR) NOT NULL,
    lloguer_estand_numero INTEGER NOT NULL,
    lloguer_empresa_nif   VARCHAR2(50) NOT NULL
);

ALTER TABLE contracte
    ADD CONSTRAINT contracte_pk PRIMARY KEY ( data_inici,
                                              data_fi,
                                              empleat_dni );

CREATE TABLE cotxe (
    matricula           VARCHAR2(6 CHAR) NOT NULL,
    color               VARCHAR2(15 CHAR),
    marca               VARCHAR2(25 CHAR),
    model               VARCHAR2(25 CHAR),
    tipus               VARCHAR2(25 CHAR),
    distintiu_ambiental VARCHAR2(4 CHAR),
    client_dni          VARCHAR2(8 CHAR) NOT NULL
);

ALTER TABLE cotxe ADD CONSTRAINT cotxe_pk PRIMARY KEY ( matricula );

CREATE TABLE empleat (
    dni          VARCHAR2(8 CHAR) NOT NULL,
    nom          VARCHAR2(25 CHAR),
    cognom       VARCHAR2(50 CHAR),
    poblacio     VARCHAR2(50 CHAR),
    pais         VARCHAR2(50 CHAR),
    nacionalitat VARCHAR2(15 CHAR)
);

ALTER TABLE empleat ADD CONSTRAINT empleat_pk PRIMARY KEY ( dni );

CREATE TABLE empresa (
    nif         VARCHAR2(9 CHAR) NOT NULL,
    sector      VARCHAR2(50 CHAR),
    nom         VARCHAR2(50 CHAR),
    adreça      VARCHAR2(50 CHAR),
    poblacio    VARCHAR2(50 CHAR),
    pais        VARCHAR2(50 CHAR),
    any_creacio INTEGER
);

ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( nif );

CREATE TABLE estada (
    hora_entrada    TIMESTAMP NOT NULL,
    hora_sortida    TIMESTAMP,
    porta_entrada   VARCHAR2(2 CHAR),
    porta_sortida   VARCHAR2(2 CHAR),
    cotxe_matricula VARCHAR2(6 CHAR) NOT NULL,
    plaça_planta    INTEGER NOT NULL,
    plaça_numero    INTEGER NOT NULL,
    plaça_zona      INTEGER NOT NULL
);

ALTER TABLE estada ADD CONSTRAINT estada_pk PRIMARY KEY ( cotxe_matricula,
                                                          hora_entrada );

CREATE TABLE estand (
    zona            VARCHAR2(10 CHAR) NOT NULL,
    numero          INTEGER NOT NULL,
    superficie      NUMBER(6, 2),
    potencia_maxima NUMBER(6, 2),
    aigua           CHAR(1)
);

ALTER TABLE estand ADD CONSTRAINT estand_pk PRIMARY KEY ( zona,
                                                          numero );

CREATE TABLE fabricant (
    nif             VARCHAR2(9 CHAR) NOT NULL,
    nom             VARCHAR2(50 CHAR),
    any_establiment INTEGER,
    pais            VARCHAR2(50),
    adreça          VARCHAR2(50 CHAR),
    poblacio        VARCHAR2(50 CHAR)
);

ALTER TABLE fabricant ADD CONSTRAINT fabricant_pk PRIMARY KEY ( nif );

CREATE TABLE lloguer (
    data_inici    DATE NOT NULL,
    data_fi       DATE NOT NULL,
    empresa_nif   VARCHAR2(9 CHAR) NOT NULL,
    estand_zona   VARCHAR2(10 CHAR) NOT NULL,
    estand_numero INTEGER NOT NULL
);

ALTER TABLE lloguer
    ADD CONSTRAINT lloguer_pk PRIMARY KEY ( data_inici,
                                            data_fi,
                                            estand_zona,
                                            estand_numero,
                                            empresa_nif );

CREATE TABLE pack (
    producte_codi1 VARCHAR2(15 CHAR) NOT NULL,
    producte_codi2 VARCHAR2(15 CHAR) NOT NULL,
    unitats        INTEGER
);

ALTER TABLE pack ADD CONSTRAINT pack_pk PRIMARY KEY ( producte_codi1,
                                                      producte_codi2 );

CREATE TABLE pertany_a (
    lloguer_data_inici    DATE NOT NULL,
    lloguer_data_fi       DATE NOT NULL,
    lloguer_estand_zona   VARCHAR2(10 CHAR) NOT NULL,
    lloguer_estand_numero INTEGER NOT NULL,
    lloguer_empresa_nif   VARCHAR2(9 CHAR) NOT NULL,
    producte_codi         VARCHAR2(50 CHAR) NOT NULL
);

CREATE TABLE plaça (
    planta       INTEGER NOT NULL,
    numero       INTEGER NOT NULL,
    zona         INTEGER NOT NULL,
    electricitat CHAR(1),
    superficie   NUMBER(4, 2)
);

ALTER TABLE plaça
    ADD CONSTRAINT plaça_pk PRIMARY KEY ( planta,
                                          numero,
                                          zona );

CREATE TABLE producte (
    codi          VARCHAR2(10 CHAR) NOT NULL,
    nom           VARCHAR2(50 CHAR),
    tipus         VARCHAR2(50 CHAR),
    pes           NUMBER NOT NULL,
    preu          NUMBER,
    proximitat    VARCHAR2(50 CHAR),
    fabricant_nif VARCHAR2(9 CHAR) NOT NULL
);

ALTER TABLE producte ADD CONSTRAINT producte_pk PRIMARY KEY ( codi );

CREATE TABLE tiquet (
    numero_referencia     VARCHAR2(15 CHAR) NOT NULL,
    unitats_totals        INTEGER,
    iva                   NUMBER,
    import_total          NUMBER,
    data                  DATE,
    tipus_pagament        VARCHAR2(10 CHAR),
    tipus_targeta         VARCHAR2(50 CHAR),
    numero_targeta        INTEGER,
    lloguer_data_inici    DATE NOT NULL,
    lloguer_data_fi       DATE NOT NULL,
    lloguer_estand_zona   VARCHAR2(10 CHAR) NOT NULL,
    lloguer_estand_numero INTEGER NOT NULL,
    lloguer_empresa_nif   VARCHAR2(9 CHAR) NOT NULL,
    contracte_data_inici  DATE NOT NULL,
    contracte_data_fi     DATE NOT NULL,
    contracte_empleat_dni VARCHAR2(8 CHAR) NOT NULL,
    client_dni            VARCHAR2(8 CHAR) NOT NULL
);

ALTER TABLE tiquet ADD CONSTRAINT tiquet_pk PRIMARY KEY ( numero_referencia );

CREATE TABLE venta (
    unitats                  INTEGER,
    producte_codi            VARCHAR2(10 CHAR) NOT NULL,
    tiquet_numero_referencia VARCHAR2(15 CHAR) NOT NULL
);

ALTER TABLE adossat
    ADD CONSTRAINT adossat_estand_fk FOREIGN KEY ( estand_zona1,
                                                   estand_numero1 )
        REFERENCES estand ( zona,
                            numero );

ALTER TABLE adossat
    ADD CONSTRAINT adossat_estand_fkv2 FOREIGN KEY ( estand_zona2,
                                                     estand_numero2 )
        REFERENCES estand ( zona,
                            numero );

ALTER TABLE contracte
    ADD CONSTRAINT contracte_empleat_fk FOREIGN KEY ( empleat_dni )
        REFERENCES empleat ( dni );

ALTER TABLE contracte
    ADD CONSTRAINT contracte_lloguer_fk FOREIGN KEY ( lloguer_data_inici,
                                                      lloguer_data_fi,
                                                      lloguer_estand_zona,
                                                      lloguer_estand_numero,
                                                      lloguer_empresa_nif )
        REFERENCES lloguer ( data_inici,
                             data_fi,
                             estand_zona,
                             estand_numero,
                             empresa_nif );

ALTER TABLE cotxe
    ADD CONSTRAINT cotxe_client_fk FOREIGN KEY ( client_dni )
        REFERENCES client ( dni );

ALTER TABLE estada
    ADD CONSTRAINT estada_cotxe_fk FOREIGN KEY ( cotxe_matricula )
        REFERENCES cotxe ( matricula );

ALTER TABLE estada
    ADD CONSTRAINT estada_plaça_fk FOREIGN KEY ( plaça_planta,
                                                 plaça_numero,
                                                 plaça_zona )
        REFERENCES plaça ( planta,
                           numero,
                           zona );

ALTER TABLE lloguer
    ADD CONSTRAINT lloguer_empresa_fk FOREIGN KEY ( empresa_nif )
        REFERENCES empresa ( nif );

ALTER TABLE lloguer
    ADD CONSTRAINT lloguer_estand_fk FOREIGN KEY ( estand_zona,
                                                   estand_numero )
        REFERENCES estand ( zona,
                            numero );

ALTER TABLE pack
    ADD CONSTRAINT pack_producte_fk FOREIGN KEY ( producte_codi1 )
        REFERENCES producte ( codi );

ALTER TABLE pack
    ADD CONSTRAINT pack_producte_fkv2 FOREIGN KEY ( producte_codi2 )
        REFERENCES producte ( codi );

ALTER TABLE pertany_a
    ADD CONSTRAINT pertany_a_lloguer_fk FOREIGN KEY ( lloguer_data_inici,
                                                      lloguer_data_fi,
                                                      lloguer_estand_zona,
                                                      lloguer_estand_numero,
                                                      lloguer_empresa_nif )
        REFERENCES lloguer ( data_inici,
                             data_fi,
                             estand_zona,
                             estand_numero,
                             empresa_nif );

ALTER TABLE pertany_a
    ADD CONSTRAINT pertany_a_producte_fk FOREIGN KEY ( producte_codi )
        REFERENCES producte ( codi );

ALTER TABLE producte
    ADD CONSTRAINT producte_fabricant_fk FOREIGN KEY ( fabricant_nif )
        REFERENCES fabricant ( nif );

ALTER TABLE tiquet
    ADD CONSTRAINT tiquet_client_fk FOREIGN KEY ( client_dni )
        REFERENCES client ( dni );

ALTER TABLE tiquet
    ADD CONSTRAINT tiquet_contracte_fk FOREIGN KEY ( contracte_data_inici,
                                                     contracte_data_fi,
                                                     contracte_empleat_dni )
        REFERENCES contracte ( data_inici,
                               data_fi,
                               empleat_dni );

ALTER TABLE tiquet
    ADD CONSTRAINT tiquet_lloguer_fk FOREIGN KEY ( lloguer_data_inici,
                                                   lloguer_data_fi,
                                                   lloguer_estand_zona,
                                                   lloguer_estand_numero,
                                                   lloguer_empresa_nif )
        REFERENCES lloguer ( data_inici,
                             data_fi,
                             estand_zona,
                             estand_numero,
                             empresa_nif );

ALTER TABLE venta
    ADD CONSTRAINT venta_producte_fk FOREIGN KEY ( producte_codi )
        REFERENCES producte ( codi );

ALTER TABLE venta
    ADD CONSTRAINT venta_tiquet_fk FOREIGN KEY ( tiquet_numero_referencia )
        REFERENCES tiquet ( numero_referencia );

---------------------------------------------------------------------------------------INSERTS------------------------------------------------------------------------------------------------------------------

-----------------------CLIENTS----------------------------
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('0000000R', 'Iria', 'Boj Herrero', 19, 'F', 'Terrasa', '10000', 'iria.boj@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('1111111T', 'José', 'Furelos de Moral', 19, 'M', 'Cerdanyola del Valles', '10101', 'joseFurelos@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('2222222X', 'Carles', 'Sanchez Ramos', 30, 'M', 'Sabadell', '23456', 'carlesanchez@outlook.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('3333333Y', 'Eva', 'Gomez Pérez', 25, 'F', 'Granollers', '34567', 'eva.gomez@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('4444444U', 'Marc', 'Vidal Mendoza', 28, 'M', 'Mataró', '45678', 'marcvidal@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('5555555W', 'Anna', 'García Fernández', 22, 'F', 'Badalona', '56789', 'anna.fernandez@yahoo.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('6666666V', 'Sergio', 'Roca Martínez', 35, 'M', 'Barcelona', '67890', 'sergioroca@hotmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('7777777Z', 'Laura', 'Navarro López', 26, 'F', 'Sant Cugat', '78901', 'laura.navarro@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('8888888A', 'Pau', 'Soler Serra', 32, 'M', 'Vic', '89012', 'pau.soler@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('9999999B', 'Nuria', 'Castelló Torres', 29, 'F', 'Manresa', '90123', 'nuria.castello@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('1234567C', 'Alberto', 'Martínez Rodríguez', 45, 'M', 'Terrasa', '10000', 'alberto.martinez@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('2345678D', 'Carmen', 'Fernández Sánchez', 55, 'F', 'Cerdanyola del Valles', '10101', 'carmen.fernandez@yahoo.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('3456789E', 'Joaquín', 'Garrido López', 68, 'M', 'Sabadell', '23456', 'joaquin.garrido@outlook.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('4567890F', 'Isabel', 'Soler Serra', 75, 'F', 'Granollers', '34567', 'isabel.SolerS@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('5678901G', 'Antonio', 'Fernández González', 80, 'M', 'Mataró', '45678', 'antonio.fernandez@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('6789012H', 'María', 'Gómez Martínez', 70, 'F', 'Badalona', '56789', 'maria.gomez@yahoo.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('7890123I', 'Francisco', 'García Sánchez', 58, 'M', 'Barcelona', '67890', 'francisco.garcia@hotmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('8901234J', 'Rosa', 'Martínez López', 62, 'F', 'Sant Cugat', '78901', 'rosa.martinez@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('9012345K', 'Javier', 'Gómez Rodríguez', 70, 'M', 'Vic', '89012', 'javier.gomez@gmail.com');
INSERT INTO client(DNI, nom, cognom, edat, sexe, poblacio, codi_postal, correu) VALUES 
    ('0123456L', 'Isabel', 'Soler Serra', 65, 'F', 'Manresa', '90123', 'isabel.soler@gmail.com');



-----------------------------COTXE---------------------------

INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('A1B2C3', 'Tesla', 'Model S', 'Sedan', 'Negre', 'CERO', '2222222X');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('B0B1T0', 'Nissan', 'GT-R Nismo N-Attack', 'Deportiu', 'Blanc', 'C', '1111111T');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('C2D3E4', 'Renault', 'Zoe', 'Elèctric', 'Blau', 'CERO', '2222222X');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('O4P5Q6', 'BMW', 'X5', 'SUV', 'Blau', 'C', '0000000R');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('R7S8T9', 'Mercedes-Benz', 'C-Class', 'Sedan', 'Gris', 'B', '3456789E');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('U0V1W2', 'Ford', 'Mustang', 'Deportiu', 'Vermell', 'C', '1234567C');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('X3Y4Z5', 'Hyundai', 'Kona Electric', 'SUV', 'Gris', 'CERO', '0000000R');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('A5B6C7', 'Toyota', 'Prius', 'Híbrid', 'Blanc', 'ECO', '3333333Y');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('D8E9F0', 'Peugeot', '208', 'Hatchback', 'Gris', 'C', '4444444U');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('G1H2I3', 'Kia', 'Sorento', 'SUV', 'Blau', 'C', '5555555W');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('J4K5L6', 'Mazda', 'CX-5', 'SUV', 'Vermell', 'C', '6666666V');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('M7N8O9', 'Honda', 'Civic', 'Sedan', 'Negre', 'C', '7777777Z');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('P0Q1R2', 'Subaru', 'Outback', 'SUV', 'Blanc', 'C', '8888888A');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('S3T4U5', 'Lexus', 'RX', 'SUV', 'Gris', 'C', '9999999B');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('U6V7W8', 'Tesla', 'Model Y', 'SUV', 'Vermell', 'CERO', '2345678D');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('L7M8N9', 'Ford', 'Focus', 'Sedan', 'Vermell', 'C', '4567890F');
INSERT INTO cotxe(matricula, marca, model, tipus, color, distintiu_ambiental, client_dni) VALUES
    ('O0P1Q2', 'Tesla', 'Model S', 'Sedan', 'Negre', 'CERO', '5678901G');



---------------------------PLAÇA------------------------------

INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (-1, 1, 1, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (-1, 2, 1, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (-1, 3, 1, 'T', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (-1, 1, 2, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (-1, 2, 2, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (-1, 3, 2, 'T', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (-1, 1, 3, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (-1, 2, 3, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (-1, 3, 3, 'T', 12.5);  
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (0, 1, 1, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (0, 2, 1, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (0, 3, 1, 'T', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (0, 1, 2, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (0, 2, 2, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (0, 3, 2, 'T', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (0, 1, 3, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (0, 2, 3, 'F', 12.5);
INSERT INTO plaça(planta, numero, zona, electricitat, superficie) VALUES
    (0, 3, 3, 'T', 12.5);



---------------------------ESTADA-----------------------

INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES
    (to_date('11/12/2023 09:00:00', 'dd/mm/yyyy HH24:MI:SS'), null, 'E1', null, 'B0B1T0', 0, 1, 1); --JOSE
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES
    (to_date('10/12/2023 10:38:41', 'dd/mm/yyyy HH24:MI:SS'), to_date('10/12/2023 11:13:12', 'dd/mm/yyyy HH24:MI:SS'), 'E2', 'S2', 'B0B1T0', 0, 2, 1); --JOSE
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES
    (to_date('11/12/2023 13:21:37', 'dd/mm/yyyy HH24:MI:SS'), to_date('11/12/2023 14:08:58', 'dd/mm/yyyy HH24:MI:SS'), 'E3', 'S3', 'A1B2C3', 0, 3, 1); --CARLES
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES
    (to_date('11/12/2023 14:56:09', 'dd/mm/yyyy HH24:MI:SS'), null, 'E3', null, 'A1B2C3', 0, 1, 2); --CARLES
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES
    (to_date('10/12/2023 17:55:42', 'dd/mm/yyyy HH24:MI:SS'), to_date('10/12/2023 19:11:22', 'dd/mm/yyyy HH24:MI:SS'), 'E1', 'S3', 'C2D3E4', 0, 3, 2); --CARLES
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES
    (to_date('11/12/2023 15:02:31', 'dd/mm/yyyy HH24:MI:SS'), null, 'E1', null, 'R7S8T9', 0, 2, 2); --JOAQUIN
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 14:32:34', 'dd/mm/yyyy HH24:MI:SS'), null, 'E2', null, 'U0V1W2', 0, 1, 3); --ALBERTO
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 15:20:15', 'dd/mm/yyyy HH24:MI:SS'), null, 'E1', null, 'X3Y4Z5', 0, 2, 3); --IRIA
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('10/12/2023 13:45:30', 'dd/mm/yyyy HH24:MI:SS'), to_date('10/12/2023 15:15:45', 'dd/mm/yyyy HH24:MI:SS'), 'E3', 'S3', 'U6V7W8', -1, 3, 2); --CARMEN
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 15:01:33', 'dd/mm/yyyy HH24:MI:SS'), null, 'E3', null, 'G1H2I3', 0, 3, 3); --ANNA
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 13:45:45', 'dd/mm/yyyy HH24:MI:SS'), null, 'E1', null, 'J4K5L6', -1, 1, 1); --SERGIO
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 10:48:24', 'dd/mm/yyyy HH24:MI:SS'), null, 'E2', null, 'M7N8O9', -1, 1, 2); --LAURA
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 12:15:11', 'dd/mm/yyyy HH24:MI:SS'), null, 'E3', null, 'P0Q1R2', -1, 1, 3); --PAU
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES
    (to_date('11/12/2023 13:59:47', 'dd/mm/yyyy HH24:MI:SS'), null, 'E1', null, 'S3T4U5', -1, 2, 1); --NURIA
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 15:00:00', 'dd/mm/yyyy HH24:MI:SS'), null, 'E2', null, 'A5B6C7', -1, 2, 3); --EVA
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 14:59:21', 'dd/mm/yyyy HH24:MI:SS'), null, 'E3', null, 'O0P1Q2', -1, 2, 2); --ANTONIO
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 14:49:31', 'dd/mm/yyyy HH24:MI:SS'), null, 'E1', null, 'D8E9F0', -1, 3, 1); --MARC
INSERT INTO estada(hora_entrada, hora_sortida, porta_entrada, porta_sortida, cotxe_matricula, plaça_planta, plaça_numero, plaça_zona) VALUES 
    (to_date('11/12/2023 14:30:22', 'dd/mm/yyyy HH24:MI:SS'), null, 'E1', null, 'L7M8N9', -1, 3, 2); --ISABEL
 
    
    
-----------------------------------------ESTAND------------------------------------------

INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('S', 1, 5000, 525, 'T' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('A', 1, 100, 10, 'T' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('A', 2, 75, 7.5, 'F' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('A', 3, 200, 25, 'F' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('A', 4, 200, 30, 'T' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('A', 5, 200, 30, 'F' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('B', 1, 100, 10, 'F' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('B', 2, 50, 7.5, 'F' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('B', 3, 50, 7.5, 'T' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('B', 4, 100, 10, 'T');
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('C', 1, 1600, 475, 'T' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('C', 2, 200, 25, 'T' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('C', 3, 200, 25, 'T' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('C', 4, 200, 25, 'T' );
INSERT INTO estand(zona, numero, superficie, potencia_maxima, aigua) VALUES
    ('C', 5, 225, 250, 'T' );
    
    
-------------------ADOSSAT-------------------
INSERT INTO adossat(estand_zona1, estand_numero1, estand_zona2, estand_numero2) VALUES
    ('B', 3, 'B', 2);
INSERT INTO adossat(estand_zona1, estand_numero1, estand_zona2, estand_numero2) VALUES
    ('B', 3, 'B', 1);
INSERT INTO adossat(estand_zona1, estand_numero1, estand_zona2, estand_numero2) VALUES
    ('A', 1, 'A', 2);
    
------------------EMPRESA---------------------
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('12345678A', 'Supermercat', 'Mercadona', 'Calle Principal 123', 'Sant Cugat', 'Espanya', 1977);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('23456789B', 'Textil', 'Zara', 'Avenida Comercial 456', 'Madrid', 'Espanya', 2015);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('34567890C', 'Textil', 'Estilo Casual', 'Calle de la Moda 789', 'Madrid', 'Espanya', 2018);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('45678901D', 'Drogueria', 'Fragancias Exclusivas', 'Plaza del Aroma 101', 'Beijing', 'Xina', 2012);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('56789012E', 'Drogueria', 'Arômes du monde', 'Calle de los Perfumes 202', 'Paris', 'França', 2016);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('67890123F', 'Jardineria', 'Flores y Colores', 'Rincón Floral 303', 'Amsterdam', 'Holanda', 2005);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('78901234G', 'Serveis', 'CineMax', 'Calle de las Películas 404', 'Cancun', 'Mexic', 2010);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('89012345H', 'Restauracio', 'La Gourmet', 'Avenida de los Sabores 505', 'Roma', 'Italia', 2014);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('90123456I', 'Restauracio', 'Delicias del Mar', 'Calle de las Delicias 606', 'Barcelona', 'Espanya', 2017);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('01234567J', 'Restauracio', 'Sabor Casero', 'Plaza de la Tradición 707', 'Barcelona', 'Espanya', 2019);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('12345432A', 'Textil', 'Massimo Dutti', 'Calle del soberbio 58', 'Madrid', 'Espanya', 2000);
 
--EMPRESES QUE JA NO ESTAN--   
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('11115555A', 'Restauracio', 'Botiga Catalana 100%', 'Carrer de Puigdemont President', 'Barcelona', 'Espanya', 2017);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('22222333B', 'Drogueria', 'Productos para residencias', 'Calle Ayuso Corrupta', 'Madrid', 'Espanya', 2020);
INSERT INTO empresa(NIF, sector, nom, adreça, poblacio, pais, any_creacio) VALUES
    ('01442211C', 'Restauracio', 'Burguer King', 'Street from GTA', 'Los Angeles', 'EEUU', 1960);
    
    
    
-------------------------LLOGUER--------------------------
--NO ESTAN--
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('06/06/2023', 'dd/mm/yyyy'), to_date('08/12/2023', 'dd/mm/yyyy'), '01442211C', 'C', 4); --BURGUER KING
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('06/06/2023', 'dd/mm/yyyy'), to_date('8/12/2023', 'dd/mm/yyyy'), '22222333B', 'A', 4); --DROGUERIA AYUSO
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('06/07/2023', 'dd/mm/yyyy'), to_date('8/12/2023', 'dd/mm/yyyy'), '11115555A', 'A', 5); --MOBILIARI PUIGDE
    
    
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); --SUPERMERCAT
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '78901234G', 'C', 1); --CINE
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), '67890123F', 'B', 3); --JARDINERIA
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '23456789B', 'A', 1); --ZARA
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/6/2024', 'dd/mm/yyyy'), '34567890C', 'A', 3); --ESTILO CASUAL
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), '45678901D', 'A', 4); --FRAGANCIAS EXCLUSIVAS
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), '56789012E', 'A', 5); --DU MONDE
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), '89012345H', 'C', 2); --REST1
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/10/2024', 'dd/mm/yyyy'), '90123456I', 'C', 3);  --REST2
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/11/2024', 'dd/mm/yyyy'), '01234567J', 'C', 4); --REST3
INSERT INTO lloguer(data_inici, data_fi, empresa_nif, estand_zona, estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), '12345432A', 'B', 4); --MASSIMO
    
---------------EMPLEAT-----------------
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('0000000R', 'Iria', 'Boj Herrero', 'Terrasa', 'Espanya', 'Espanyola');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('1111111T', 'José', 'Furelos de Moral', 'Cerdanyola del Valles', 'Espanya', 'Espanyola');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('1234567M', 'Manuel', 'Torres Martínez', 'Terrasa', 'Espanya', 'Espanyola');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('1234567Z', 'Gerard', 'Fuertes', 'Sabadell', 'Espanya', 'Espanyola');
    
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('9876543A', 'Laura', 'Gómez Fernández', 'Barcelona', 'Espanya', 'Alemana');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('2345678B', 'Roberto', 'Martínez García', 'Sabadell', 'Espanya', 'Espanyola');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('3456789C', 'Marina', 'López Jiménez', 'Terrassa', 'Espanya', 'Brasilera');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('4567890D', 'Carlos', 'González Rodríguez', 'Sant Cugat', 'Espanya', 'Francesa');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('5678901E', 'Sara', 'Giménez Pérez', 'Barberà del Vallès', 'Espanya', 'Italiana');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('6789012F', 'Álvaro', 'Martín López', 'Cerdanyola del Vallès', 'Espanya', 'Americana');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('7890123G', 'Elena', 'Sánchez Ruiz', 'Sant Quirze del Vallès', 'Espanya', 'Espanyola');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('8901234H', 'Javier', 'Hernández Moreno', 'Badia del Vallès', 'Espanya', 'Espanyola');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('9012345J', 'Carmen', 'Díaz Navarro', 'Ripollet', 'Espanya', 'Espanyola');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('0123456K', 'Daniel', 'Ortiz Sánchez', 'Castellar del Vallès', 'Espanya', 'Italiana');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('4567890N', 'Isabel', 'Martínez Sánchez', 'Cerdanyola del Vallès', 'Espanya', 'Espanyola');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES 
    ('5678901P', 'Sergio', 'Gómez Jiménez', 'Barcelona', 'Espanya', 'Espanyola');
INSERT INTO empleat(DNI, nom, cognom, poblacio, pais, nacionalitat) VALUES
    ('1233369E', 'Eduardo', 'Bergillos Bigotuo', 'Sabadell', 'Espanya', 'Espanyola');

    
---------------CONTRACTE---------------

INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('06/06/2023', 'dd/mm/yyyy'), to_date('8/12/2023', 'dd/mm/yyyy') , '0000000R', to_date('06/06/2023', 'dd/mm/yyyy'), to_date('08/12/2023', 'dd/mm/yyyy'), '01442211C', 'C', 4); --REST vell
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('06/06/2023', 'dd/mm/yyyy'), to_date('8/12/2023', 'dd/mm/yyyy'), '1111111T', to_date('06/06/2023', 'dd/mm/yyyy'), to_date('08/12/2023', 'dd/mm/yyyy'), '01442211C', 'C', 4); --REST vell
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('06/06/2023', 'dd/mm/yyyy'), to_date('8/12/2023', 'dd/mm/yyyy'), '1234567Z',to_date('06/06/2023', 'dd/mm/yyyy'), to_date('8/12/2023', 'dd/mm/yyyy'), '22222333B', 'A', 4); --DROGUERIA AYUSO
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('06/06/2023', 'dd/mm/yyyy'), to_date('8/12/2023', 'dd/mm/yyyy'), '1234567M',to_date('06/07/2023', 'dd/mm/yyyy'), to_date('8/12/2023', 'dd/mm/yyyy'), '11115555A', 'A', 5); --MOBILIARI PUIGDE

--MERCADONA
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '9876543A',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1);
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '2345678B',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); 
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2024', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '5678901P',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); 

--CINEMAX
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '0000000R', to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '78901234G', 'C', 1);
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '1111111T', to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '78901234G', 'C', 1);

--FLORES Y COLORES
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), '3456789C',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), '67890123F', 'B', 3);
    
--ZARA
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '4567890D',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '23456789B', 'A', 1);
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2024', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '4567890N',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '23456789B', 'A', 1);

--ESTILO CASUAL
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/6/2024', 'dd/mm/yyyy'), '5678901E',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/6/2024', 'dd/mm/yyyy'), '34567890C', 'A', 3);
    
--FRAGANCIAS EXCLUSIVAS
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), '6789012F',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), '45678901D', 'A', 4);
    
--AROMES DU MONDE
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), '7890123G',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), '56789012E', 'A', 5);
    
--LA GOURMET
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), '8901234H',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), '89012345H', 'C', 2);
    
--DELICIAS DEL MAR
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/10/2024', 'dd/mm/yyyy'), '9012345J',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/10/2024', 'dd/mm/yyyy'), '90123456I', 'C', 3);
    
--SABOR CASERO
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/11/2024', 'dd/mm/yyyy'), '0123456K',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/11/2024', 'dd/mm/yyyy'), '01234567J', 'C', 4);
    
--MASSIMO DUTTI
INSERT INTO contracte(data_inici, data_fi, empleat_dni, lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), '1233369E',to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), '12345432A', 'B', 4);
    
    
    
-------------FABRICANT---------------

INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('11111111A', 'EmpresAgricultora', 1980, 'Espanya', 'Passeig hortalisses', 'Almeria');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('22222222B', 'FabricaExplotacioXinesa', 2000, 'Xina', 'Calle No Adultos', 'Zhengzhou');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('34567890C', 'Estilo Casual', 2018, 'Espanya', 'Calle de la Moda 789', 'Madrid');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('45678901D', 'Fragancias Exclusivas', 2012, 'Xina', 'Plaza del Aroma 101', 'Beijing');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('55555555Z', 'OloresPakistanis', 2000, 'Pakistan', 'Calle Pakistans', 'Karachi');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('67890123F', 'Flores y Colores', 2005, 'Holanda', 'Rincón Floral 303', 'Amsterdam');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('78901234G', 'CineMax', 2010, 'Mexic', 'Calle de las Películas 404', 'Cancun');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('89012345H', 'La Gourmet', 2014, 'Italia', 'Avenida de los Sabores 505', 'Roma');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('90123456I', 'Delicias del Mar', 2017, 'Espanya', 'Calle de las Delicias 606', 'Barcelona');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('01234567J', 'Sabor Casero', 2019, 'Espanya', 'Plaza de la Tradición 707', 'Barcelona');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('11115555A', 'Botiga Catalana 100%', 2017, 'Espanya', 'Carrer de Puigdemont President', 'Barcelona');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('77777777X', 'FabricaIllesCaiman', 2020, 'Regne Unit', 'Carrer Comisions', 'George Town');
INSERT INTO fabricant(nif, nom, any_establiment, pais, adreça, poblacio) VALUES
    ('9999999L', 'FakeBadFood', 1961, 'EEUU', 'JunkFood Street', 'New Jersey');
    
    
    
    
-------------PRODUCTE----------------

INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P001', 'Tomates Ecológicos', 'Hortalizas', 1.5, 2.5, 'Almeria', '11111111A');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P002', 'Pimientos Rojos', 'Hortalizas', 1.2, 3.0, 'Almeria', '11111111A');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P035', 'Pimientos y tomates', 'Hortalizas', 2.7, 5.0, 'Almeria', '11111111A');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P003', 'Aguacates Frescos', 'Frutas', 0.8, 4.0, 'Almeria', '11111111A');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P004', 'Suadera', 'Ropa', 0.4, 19.99, 'Zhengzhou', '22222222B');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P005', 'Calcetines', 'Ropa', 0.1, 4.99, 'Zhengzhou', '22222222B');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P006', 'Ropa Básica', 'Ropa', 0.8, 5.0, 'Zhengzhou', '22222222B');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P007', 'Camisa Informal', 'Ropa', 0.4, 15.0, 'Madrid', '34567890C');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P008', 'Pantalones Vaqueros', 'Ropa', 0.6, 20.0, 'Madrid', '34567890C');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P009', 'Zapatos de Moda', 'Calzado', 0.7, 30.0, 'Madrid', '34567890C');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P010', 'Perfume Elegante', 'Fragancias', 0.1, 50.0, 'Beijing', '45678901D');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P011', 'Aceites Esenciales', 'Fragancias', 0.2, 25.0, 'Beijing', '45678901D');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P012', 'Velas Aromáticas', 'Fragancias', 0.3, 15.0, 'Beijing', '45678901D');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P013', 'Eau du Mar', 'Fragancias', 0.5, 99.99, 'Karachi', '55555555Z');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P014', 'Prédateur', 'Fragancias', 0.6, 300.0, 'Karachi', '55555555Z');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P015', 'Baguette du matin', 'Fragancias', 0.4, 14.99, 'Karachi', '55555555Z');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P016', 'Ramo de Rosas', 'Flores', 0.3, 20.0, 'Amsterdam', '67890123F');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P017', 'Tulipanes Holandeses', 'Flores', 0.4, 18.0, 'Amsterdam', '67890123F');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P018', 'Arreglo Floral', 'Decoración', 0.6, 25.0, 'Amsterdam', '67890123F');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P019', 'Entradas de Cine', 'Entretenimiento', 0.01, 10.0, 'Cancun', '78901234G');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P020', 'Palomitas de Maíz', 'Snacks', 0.2, 5.0, 'Cancun', '78901234G');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P021', 'Refrescos Variados', 'Bebidas', 0.3, 4.0, 'Cancun', '78901234G');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P022', 'Pasta Artesanal', 'Comida', 0.5, 20.0, 'Roma', '89012345H');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P023', 'Pizza de caviar', 'Comida', 0.3, 109.99, 'Roma', '89012345H');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P024', 'Tabla de quesos', 'Comida', 0.3, 12.0, 'Roma', '89012345H');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P025', 'Salmón Ahumado', 'Comida', 0.4, 18.0, 'Barcelona', '90123456I');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P026', 'Langostinos Frescos', 'Comida', 0.3, 25.0, 'Barcelona', '90123456I');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P027', 'Calamares a la Romana', 'Comida', 0.6, 20.0, 'Barcelona', '90123456I');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P028', 'Tarta de Chocolate', 'Repostería', 0.8, 22.0, 'Barcelona', '01234567J');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P029', 'Galletas Caseras', 'Repostería', 0.2, 10.0, 'Barcelona', '01234567J');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P030', 'Sopa de Verduras', 'Cocina Preparada', 0.5, 8.0, 'Barcelona', '01234567J');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P036', 'Camisa de Moda', 'Ropa', 0.4, 25.0, 'Madrid', '34567890C');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P037', 'Americana Elegante', 'Ropa', 0.8, 60.0, 'Madrid', '34567890C');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P038', 'Pepinos Frescos', 'Hortalizas', 1.0, 1.99, 'Almeria', '11111111A');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P039', 'Pantalones Clásicos', 'Ropa', 0.5, 35.0, 'Madrid', '34567890C');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P040', 'Jersey de Lana', 'Ropa', 0.6, 45.0, 'Xina', '34567890C');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P041', 'Zapatos de Cuero', 'Calzado', 0.7, 50.0, 'Xina', '34567890C');
INSERT INTO producte(codi, nom, tipus, pes, preu, proximitat, fabricant_nif) VALUES
    ('P042', 'Traje', 'Ropa', 2, 130.0, 'Xina', '34567890C');
    


---------------PACK------------------
INSERT INTO pack(producte_codi1, producte_codi2, unitats) VALUES
    ('P035', 'P001', 1);
INSERT INTO pack(producte_codi1, producte_codi2, unitats) VALUES
    ('P035', 'P002', 1);

INSERT INTO pack(producte_codi1, producte_codi2, unitats) VALUES
    ('P042', 'P041', 1);
INSERT INTO pack(producte_codi1, producte_codi2, unitats) VALUES
    ('P042', 'P039', 1);
INSERT INTO pack(producte_codi1, producte_codi2, unitats) VALUES
    ('P042', 'P037', 1);

    

-------------PERTANY_A--------------
-- MERCADONA
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'S', 1, '12345678A', 'P001');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'S', 1, '12345678A', 'P002');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'S', 1, '12345678A', 'P003');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'S', 1, '12345678A', 'P038');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'S', 1, '12345678A', 'P035');

-- ZARA
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'A', 1, '23456789B', 'P004');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'A', 1, '23456789B', 'P005');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'A', 1, '23456789B', 'P006');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'A', 1, '23456789B', 'P036');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), 'A', 1, '23456789B', 'P037');

-- ESTILO CASUAL
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/6/2024', 'dd/mm/yyyy'), 'A', 3, '34567890C', 'P007');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/6/2024', 'dd/mm/yyyy'), 'A', 3, '34567890C', 'P008');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/6/2024', 'dd/mm/yyyy'), 'A', 3, '34567890C', 'P009');

-- FRAGANCIAS
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), 'A', 4, '45678901D', 'P010');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), 'A', 4, '45678901D', 'P011');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), 'A', 4, '45678901D', 'P012');

-- DU MONDE
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), 'A', 5, '56789012E', 'P013');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), 'A', 5, '56789012E', 'P014');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), 'A', 5, '56789012E', 'P015');

-- FLORES
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), 'B', 3, '67890123F', 'P016');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), 'B', 3, '67890123F', 'P017');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), 'B', 3, '67890123F', 'P018');

-- CINEMAX
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), 'C', 1, '78901234G', 'P019');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), 'C', 1, '78901234G', 'P020');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), 'C', 1, '78901234G', 'P021');

-- LA GOURMET
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), 'C', 2, '89012345H', 'P022');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), 'C', 2, '89012345H', 'P023');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), 'C', 2, '89012345H', 'P024');

-- DELICIAS DEL MAR
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/10/2024', 'dd/mm/yyyy'), 'C', 3, '90123456I', 'P025');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/10/2024', 'dd/mm/yyyy'), 'C', 3, '90123456I', 'P026');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/10/2024', 'dd/mm/yyyy'), 'C', 3, '90123456I', 'P027');

-- SABOR CASERO
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/11/2024', 'dd/mm/yyyy'), 'C', 4, '01234567J', 'P028');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/11/2024', 'dd/mm/yyyy'), 'C', 4, '01234567J', 'P029');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/11/2024', 'dd/mm/yyyy'), 'C', 4, '01234567J', 'P030');

-- MASSIMO DUTTI
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), 'B', 4, '12345432A', 'P036');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), 'B', 4, '12345432A', 'P037');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), 'B', 4, '12345432A', 'P039');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), 'B', 4, '12345432A', 'P040');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), 'B', 4, '12345432A', 'P041');
INSERT INTO pertany_a(lloguer_data_inici, lloguer_data_fi, lloguer_estand_zona, lloguer_estand_numero, lloguer_empresa_nif, producte_codi) VALUES
    (to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), 'B', 4, '12345432A', 'P042');
    
 
--------------TIQUET-----------------   
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('2222222X', 'REF00001', 2, 1.15, 5.5, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '9876543A',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); --SUPER CARLES
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('2222222X', 'REF00002', 2, 1.36, 6.5, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '2345678B',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); --SUPER CARLES
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('2222222X', 'REF00016', 1, 27.3, 130, to_date('10/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), '1233369E',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), '12345432A', 'B', 4); --MASSIMO CARLES
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('3333333Y', 'REF00003', 1, 4.2, 20.0, to_date('11/12/2023', 'dd/mm/yyyy'), 'Targeta', 'Visa', 000000000001, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), '3456789C',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), '67890123F', 'B', 3); --FLORES EVA
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('3333333Y', 'REF00004', 1, 4.19, 19.99, to_date('11/12/2023', 'dd/mm/yyyy'), 'Targeta', 'Visa', 000000000001, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '4567890D',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '23456789B', 'A', 1); --ZARA EVA
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('1111111T', 'REF00005', 3, 3.99, 19.0, to_date('10/12/2023', 'dd/mm/yyyy'), 'Targeta', 'Matercard', 000000000020, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '0000000R',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '78901234G', 'C', 1); --CINE JOSE
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('1111111T', 'REF00006', 3, 5.25, 25.0, to_date('11/12/2023', 'dd/mm/yyyy'), 'Targeta', 'Matercard', 000000000020, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '0000000R',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '78901234G', 'C', 1); --CINE JOSE
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('4444444U', 'REF00007', 2, 10.5, 45.0, to_date('11/12/2023', 'dd/mm/yyyy'), 'Targeta', 'CentreComercial', 123400000009, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), '1233369E',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('31/12/2024', 'dd/mm/yyyy'), '12345432A', 'B', 4); --MASSIMO MARC
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('4444444U', 'REF00008', 1, 0.52, 2.5, to_date('11/12/2023', 'dd/mm/yyyy'), 'Targeta', 'Visa', 122244442222, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '9876543A',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); --SUPER MARC
            
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('3456789E', 'REF00009', 2, 0.83, 3.98, to_date('11/12/2023', 'dd/mm/yyyy'), 'Targeta', 'Visa', 002200110033, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '9876543A',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); --SUPER JOAQUIN
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('1234567C', 'REF00010', 3, 1.04, 4.99, to_date('11/12/2023', 'dd/mm/yyyy'), 'Targeta', 'Visa', 002200110033, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '9876543A',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); --SUPER ALBERTO
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('5555555W', 'REF00011', 1, 3.14, 14.99, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), '7890123G',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), '56789012E', 'A', 5); --AROMES MOND ANNA
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('2345678D', 'REF00012', 1, 3.15, 15.0, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '1111111T', 
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '78901234G', 'C', 1); --CARMEN CINE
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('6666666V', 'REF00013', 1, 2.1, 10.0, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '0000000R', 
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2024', 'dd/mm/yyyy'), '78901234G', 'C', 1); --SERGIO CINE

INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('2345678D', 'REF00014', 2, 6.3, 30.0, to_date('10/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/11/2024', 'dd/mm/yyyy'), '0123456K',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/11/2024', 'dd/mm/yyyy'), '01234567J', 'C', 4); --SABOR CASERO CARMEN
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('7777777Z', 'REF00015', 1, 4.2, 20, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), '8901234H',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), '89012345H', 'C', 2); --LA GOURMET LAURA

INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('0000000R', 'REF00017', 1, 5.25, 25.0, to_date('10/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), '7890123G',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('25/10/2024', 'dd/mm/yyyy'), '56789012E', 'A', 5); --DU MONDE IRIA
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('0000000R', 'REF00018', 1, 3.14, 14.99, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), '6789012F',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), '45678901D', 'A', 4); --FRAGANCIAS IRIA

INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('3456789E', 'REF00019', 1, 63.0, 270.0, to_date('10/12/2023', 'dd/mm/yyyy'), 'Targeta', 'CentreComercial', 115522119922, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), '6789012F',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('11/5/2024', 'dd/mm/yyyy'), '45678901D', 'A', 4); --DU MONDE JOAQUIN
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('6789012H', 'REF00020', 2, 7.35, 35.0, to_date('10/12/2023', 'dd/mm/yyyy'), 'Targeta', 'Visa', 123123990000, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/6/2024', 'dd/mm/yyyy'), '5678901E',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/6/2024', 'dd/mm/yyyy'), '34567890C', 'A', 3); --MARIA ESTILO CASUAL
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('7890123I', 'REF00021', 1, 12.6, 60, to_date('10/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2024', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '4567890N',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '23456789B', 'A', 1);--FRANCISCO ZARA  
    
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('8901234J', 'REF00022', 1, 3.78, 18.0, to_date('10/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/10/2024', 'dd/mm/yyyy'), '9012345J',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/10/2024', 'dd/mm/yyyy'), '90123456I', 'C', 3); --ROSA DELICIAS 
            
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('9012345K', 'REF00023', 2, 2.1, 10.0, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '2345678B',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1);  --JAVIER SUPER  
            
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
   ('0123456L', 'REF00024', 4, 3.36, 14.4, to_date('11/12/2023', 'dd/mm/yyyy'), 'Targeta', 'CentreComercial', 198765432121, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '2345678B',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); --ISABEL SERRA  SUPER      
            
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('9999999B', 'REF00028', 4, 3.36, 16.0, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '2345678B',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); --NURIA SUPER    
            
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
     ('4444444U', 'REF00025', 2, 9.45, 45.0, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), '3456789C',
     to_date('09/12/2023', 'dd/mm/yyyy'), to_date('15/06/2024', 'dd/mm/yyyy'), '67890123F', 'B', 3); --MARC FLORES
            
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
    ('4567890F', 'REF00026', 4, 3.36, 16.0, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '2345678B',
    to_date('09/12/2023', 'dd/mm/yyyy'), to_date('09/12/2025', 'dd/mm/yyyy'), '12345678A', 'S', 1); --ISABEL MARTINEZ SUPER
            
INSERT INTO tiquet(client_dni, numero_referencia, unitats_totals, IVA, import_total, data, tipus_pagament, tipus_targeta, numero_targeta, contracte_data_inici, contracte_data_fi, contracte_empleat_dni,
            lloguer_data_inici, lloguer_data_fi, lloguer_empresa_nif, lloguer_estand_zona, lloguer_estand_numero) VALUES
     ('5678901G', 'REF00027', 1, 23.09, 109.99, to_date('11/12/2023', 'dd/mm/yyyy'), 'Efectiu', null, null, to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), '8901234H',
     to_date('09/12/2023', 'dd/mm/yyyy'), to_date('01/7/2024', 'dd/mm/yyyy'), '89012345H', 'C', 2); --ANTONIO GOURMET     
            
         
            
---------------VENTA----------------
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P001', 'REF00001');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P002', 'REF00001');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P001', 'REF00002');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P003', 'REF00002');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P042', 'REF00016');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P016', 'REF00003');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P004', 'REF00004');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P019', 'REF00005');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P020', 'REF00005');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P021', 'REF00005');
    

INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (2, 'P019', 'REF00006');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P020', 'REF00006');

INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (2, 'P036', 'REF00007');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P001', 'REF00008');

INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (2, 'P038', 'REF00009');

INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P002', 'REF00010');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P038', 'REF00010');

INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P015', 'REF00011');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P019', 'REF00012');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P019', 'REF00013');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P028', 'REF00014');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P030', 'REF00014');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P022', 'REF00015');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P011', 'REF00017');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P015', 'REF00018');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P014', 'REF00019');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P007', 'REF00020');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P008', 'REF00020');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P037', 'REF00021');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P025', 'REF00022');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (2, 'P035', 'REF00023');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (4, 'P003', 'REF00024');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (4, 'P003', 'REF00028');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P016', 'REF00025');
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P018', 'REF00025');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (4, 'P003', 'REF00026');
    
INSERT INTO venta(unitats, producte_codi, tiquet_numero_referencia) VALUES
    (1, 'P023', 'REF00027');