-- Crear secuencias para las claves primarias
CREATE SEQUENCE seq_organizacion START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_municipalidad START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_formulario START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_profesor START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_turno START WITH 1 INCREMENT BY 1;

-- Creación de la tabla ORGANIZACION (tabla fuerte)
CREATE TABLE ORGANIZACION (
    id_organizacion NUMBER(10) PRIMARY KEY,
    nombre_organizacion VARCHAR2(100) NOT NULL,
    tipo_organizacion VARCHAR2(50) NOT NULL,
    rut VARCHAR2(15) UNIQUE NOT NULL,
    fecha_vencimiento_directorio DATE,
    direccion VARCHAR2(255) NOT NULL,
    unidad_vecinal VARCHAR2(100),
    telefono VARCHAR2(20),
    correo_electronico VARCHAR2(100) UNIQUE,
    numero_cuenta_bancaria VARCHAR2(30) UNIQUE,
    tipo_cuenta_bancaria VARCHAR2(20),
    titular_cuenta_bancaria VARCHAR2(100),
    banco VARCHAR2(50)
);

-- Creación de la tabla MUNICIPALIDAD (tabla fuerte)
CREATE TABLE MUNICIPALIDAD (
    id_municipalidad NUMBER(10) PRIMARY KEY,
    nombre_municipalidad VARCHAR2(100) NOT NULL,
    direccion_municipalidad VARCHAR2(255) NOT NULL
);

-- Creación de la tabla FORMULARIO (tabla débil)
CREATE TABLE FORMULARIO (
    id_formulario NUMBER(10) PRIMARY KEY,
    fecha_postulacion DATE NOT NULL,
    estado_postulacion VARCHAR2(50) NOT NULL,
    id_organizacion NUMBER(10),
    id_municipalidad NUMBER(10),
    CONSTRAINT fk_organizacion FOREIGN KEY (id_organizacion) REFERENCES ORGANIZACION(id_organizacion),
    CONSTRAINT fk_municipalidad FOREIGN KEY (id_municipalidad) REFERENCES MUNICIPALIDAD(id_municipalidad)
);

-- Creación de la tabla PROFESOR (tabla fuerte)
CREATE TABLE PROFESOR (
    id_profesor NUMBER(10) PRIMARY KEY,
    nombre_profesor VARCHAR2(100) NOT NULL,
    tipo_contrato VARCHAR2(50) NOT NULL,
    salario NUMBER(15, 2),
    especialidad VARCHAR2(100),
    id_organizacion NUMBER(10),
    CONSTRAINT fk_organizacion_profesor FOREIGN KEY (id_organizacion) REFERENCES ORGANIZACION(id_organizacion)
);

-- Creación de la tabla TURNO (tabla débil)
CREATE TABLE TURNO (
    id_turno NUMBER(10) PRIMARY KEY,
    dia_semana VARCHAR2(50) NOT NULL,
    hora_inicio DATE NOT NULL,
    hora_fin DATE NOT NULL,
    id_profesor NUMBER(10),
    CONSTRAINT fk_profesor FOREIGN KEY (id_profesor) REFERENCES PROFESOR(id_profesor)
);

-- Poblamiento de la tabla ORGANIZACION con datos realistas
BEGIN
    INSERT INTO ORGANIZACION (id_organizacion, nombre_organizacion, tipo_organizacion, rut, fecha_vencimiento_directorio, direccion, unidad_vecinal, telefono, correo_electronico, numero_cuenta_bancaria, tipo_cuenta_bancaria, titular_cuenta_bancaria, banco) VALUES (seq_organizacion.NEXTVAL, 'Fundación Cultural Santiago', 'Cultural', '12345678-9', TO_DATE('2025-12-31', 'YYYY-MM-DD'), 'Calle Santiago 123, Santiago', 'Unidad Vecinal 1', '987654321', 'contacto@santiagocultura.cl', '1111111111', 'Cuenta Corriente', 'Juan Pérez', 'BancoEstado');
    INSERT INTO ORGANIZACION (id_organizacion, nombre_organizacion, tipo_organizacion, rut, fecha_vencimiento_directorio, direccion, unidad_vecinal, telefono, correo_electronico, numero_cuenta_bancaria, tipo_cuenta_bancaria, titular_cuenta_bancaria, banco) VALUES (seq_organizacion.NEXTVAL, 'Escuela de Artes La Florida', 'Educativa', '87654321-0', TO_DATE('2024-06-30', 'YYYY-MM-DD'), 'Av. La Florida 456, La Florida', 'Unidad Vecinal 2', '876543210', 'contacto@arteslaflorida.cl', '2222222222', 'Cuenta Vista', 'María González', 'Banco Santander');
    -- Agrega más inserciones similares para completar 10 registros
END;
/

-- Poblamiento de la tabla MUNICIPALIDAD con datos realistas
BEGIN
    INSERT INTO MUNICIPALIDAD (id_municipalidad, nombre_municipalidad, direccion_municipalidad) VALUES (seq_municipalidad.NEXTVAL, 'Municipalidad de Santiago', 'Av. Libertador Bernardo O''Higgins 1234, Santiago');
    INSERT INTO MUNICIPALIDAD (id_municipalidad, nombre_municipalidad, direccion_municipalidad) VALUES (seq_municipalidad.NEXTVAL, 'Municipalidad de Providencia', 'Av. Nueva Providencia 789, Providencia');
    -- Agrega más inserciones similares para completar 10 registros
END;
/

-- Poblamiento de la tabla FORMULARIO con datos realistas
BEGIN
    INSERT INTO FORMULARIO (id_formulario, fecha_postulacion, estado_postulacion, id_organizacion, id_municipalidad) VALUES (seq_formulario.NEXTVAL, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Aprobado', 1, 1);
    INSERT INTO FORMULARIO (id_formulario, fecha_postulacion, estado_postulacion, id_organizacion, id_municipalidad) VALUES (seq_formulario.NEXTVAL, TO_DATE('2023-05-20', 'YYYY-MM-DD'), 'Pendiente', 2, 2);
    -- Agrega más inserciones similares para completar 10 registros
END;
/

-- Poblamiento de la tabla PROFESOR con datos realistas
BEGIN
    INSERT INTO PROFESOR (id_profesor, nombre_profesor, tipo_contrato, salario, especialidad, id_organizacion) VALUES (seq_profesor.NEXTVAL, 'Juan Pérez', 'Planta', 850000, 'Pintura', 1);
    INSERT INTO PROFESOR (id_profesor, nombre_profesor, tipo_contrato, salario, especialidad, id_organizacion) VALUES (seq_profesor.NEXTVAL, 'María González', 'Contrata', 750000, 'Danza', 2);
    -- Agrega más inserciones similares para completar 10 registros
END;
/

-- Poblamiento de la tabla TURNO con datos realistas
BEGIN
    INSERT INTO TURNO (id_turno, dia_semana, hora_inicio, hora_fin, id_profesor) VALUES (seq_turno.NEXTVAL, 'Lunes', TO_DATE('08:00:00', 'HH24:MI:SS'), TO_DATE('12:00:00', 'HH24:MI:SS'), 1);
    INSERT INTO TURNO (id_turno, dia_semana, hora_inicio, hora_fin, id_profesor) VALUES (seq_turno.NEXTVAL, 'Martes', TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('13:00:00', 'HH24:MI:SS'), 2);
    -- Agrega más inserciones similares para completar 10 registros
END;
/
