--------------------------------------------------------
-- Archivo creado  - lunes-noviembre-19-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CICLO
--------------------------------------------------------

  CREATE TABLE "CICLO" 
   (	"ID_CICLO" CHAR(5 BYTE), 
	"DURACION" NUMBER(6,0), 
	"RAMA" VARCHAR2(20 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table CURSO
--------------------------------------------------------

  CREATE TABLE "CURSO" 
   (	"ID_CURSO" CHAR(1 BYTE), 
	"ID_CICLO" CHAR(5 BYTE), 
	"FECHA_INICIO" DATE, 
	"FECHA_FIN" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table ESTUDIANTE
--------------------------------------------------------

  CREATE TABLE "ESTUDIANTE" 
   (	"ID_ESTUD" CHAR(3 BYTE), 
	"DNI" CHAR(9 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"CP" VARCHAR2(6 BYTE), 
	"TELEFONO" NUMBER(10,0), 
	"FECH_NACI" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table FICHA_ALUMNO
--------------------------------------------------------

  CREATE TABLE "FICHA_ALUMNO" 
   (	"NOTAS_ID_NOTA" CHAR(5 BYTE), 
	"ID_MODULO" CHAR(5 BYTE), 
	"ID_CICLO" CHAR(5 BYTE), 
	"ID_CURSO" CHAR(1 BYTE), 
	"CALIFICACION" NUMBER(5,0)
   ) ;
--------------------------------------------------------
--  DDL for Table GRUPO
--------------------------------------------------------

  CREATE TABLE "GRUPO" 
   (	"ID_CURSO" CHAR(1 BYTE), 
	"ID_GRUPO" CHAR(1 BYTE), 
	"ID_CICLO" CHAR(5 BYTE), 
	"ID_PROF" CHAR(3 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table HORARIO_CLASES
--------------------------------------------------------

  CREATE TABLE "HORARIO_CLASES" 
   (	"ID_MODULO" CHAR(5 BYTE), 
	"ID_CICLO" CHAR(5 BYTE), 
	"ID_CURSO" CHAR(1 BYTE), 
	"ID_PROF" CHAR(3 BYTE), 
	"ID_GRUPO" CHAR(1 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table MOD_MATRICULA
--------------------------------------------------------

  CREATE TABLE "MOD_MATRICULA" 
   (	"ID_GRUPO" CHAR(1 BYTE), 
	"ID_CICLO" CHAR(5 BYTE), 
	"ID_CURSO" CHAR(1 BYTE), 
	"ID_MODULO" CHAR(5 BYTE), 
	"ID_ESTUD" CHAR(3 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table MODULO
--------------------------------------------------------

  CREATE TABLE "MODULO" 
   (	"ID_MODULO" CHAR(5 BYTE), 
	"CAPACIDAD" NUMBER(2,0), 
	"NOM_MOD" VARCHAR2(50 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table NOTAS
--------------------------------------------------------

  CREATE TABLE "NOTAS" 
   (	"ID_NOTA" CHAR(5 BYTE), 
	"TRIMESTRE" NUMBER(5,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PLAN_ESTUDIOS
--------------------------------------------------------

  CREATE TABLE "PLAN_ESTUDIOS" 
   (	"MODULO_ID_MODULO" CHAR(5 BYTE), 
	"CURSO_ID_CICLO" CHAR(5 BYTE), 
	"CURSO_ID_CURSO" CHAR(1 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PROFESOR
--------------------------------------------------------

  CREATE TABLE "PROFESOR" 
   (	"ID_PROF" CHAR(3 BYTE), 
	"DNI" CHAR(9 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"FEC_NACIM" DATE, 
	"TEL_PROF" NUMBER(10,0), 
	"SALARIO" NUMBER(8,2)
   ) ;
REM INSERTING into CICLO
SET DEFINE OFF;
REM INSERTING into CURSO
SET DEFINE OFF;
REM INSERTING into ESTUDIANTE
SET DEFINE OFF;
REM INSERTING into FICHA_ALUMNO
SET DEFINE OFF;
REM INSERTING into GRUPO
SET DEFINE OFF;
REM INSERTING into HORARIO_CLASES
SET DEFINE OFF;
REM INSERTING into MOD_MATRICULA
SET DEFINE OFF;
REM INSERTING into MODULO
SET DEFINE OFF;
REM INSERTING into NOTAS
SET DEFINE OFF;
REM INSERTING into PLAN_ESTUDIOS
SET DEFINE OFF;
REM INSERTING into PROFESOR
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index CICLO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CICLO_PK" ON "CICLO" ("ID_CICLO") 
  ;
--------------------------------------------------------
--  DDL for Index CURSO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CURSO_PK" ON "CURSO" ("ID_CICLO", "ID_CURSO") 
  ;
--------------------------------------------------------
--  DDL for Index ESTUDIANTE_DNI_UN
--------------------------------------------------------

  CREATE UNIQUE INDEX "ESTUDIANTE_DNI_UN" ON "ESTUDIANTE" ("DNI") 
  ;
--------------------------------------------------------
--  DDL for Index ESTUDIANTE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ESTUDIANTE_PK" ON "ESTUDIANTE" ("ID_ESTUD") 
  ;
--------------------------------------------------------
--  DDL for Index FICHA_ALUMNO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FICHA_ALUMNO_PK" ON "FICHA_ALUMNO" ("NOTAS_ID_NOTA", "ID_MODULO", "ID_CICLO", "ID_CURSO") 
  ;
--------------------------------------------------------
--  DDL for Index GRUPO__IDX
--------------------------------------------------------

  CREATE UNIQUE INDEX "GRUPO__IDX" ON "GRUPO" ("ID_PROF") 
  ;
--------------------------------------------------------
--  DDL for Index GRUPO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GRUPO_PK" ON "GRUPO" ("ID_GRUPO", "ID_CICLO", "ID_CURSO") 
  ;
--------------------------------------------------------
--  DDL for Index HORARIO_CLASES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HORARIO_CLASES_PK" ON "HORARIO_CLASES" ("ID_MODULO", "ID_CICLO", "ID_CURSO", "ID_PROF", "ID_GRUPO") 
  ;
--------------------------------------------------------
--  DDL for Index MOD_MATRICULA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MOD_MATRICULA_PK" ON "MOD_MATRICULA" ("ID_GRUPO", "ID_CICLO", "ID_CURSO", "ID_MODULO", "ID_ESTUD") 
  ;
--------------------------------------------------------
--  DDL for Index MODULO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MODULO_PK" ON "MODULO" ("ID_MODULO") 
  ;
--------------------------------------------------------
--  DDL for Index NOTAS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "NOTAS_PK" ON "NOTAS" ("ID_NOTA") 
  ;
--------------------------------------------------------
--  DDL for Index PLAN_ESTUDIOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PLAN_ESTUDIOS_PK" ON "PLAN_ESTUDIOS" ("MODULO_ID_MODULO", "CURSO_ID_CICLO", "CURSO_ID_CURSO") 
  ;
--------------------------------------------------------
--  DDL for Index PROFESOR_DNI_UN
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROFESOR_DNI_UN" ON "PROFESOR" ("DNI") 
  ;
--------------------------------------------------------
--  DDL for Index PROFESOR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROFESOR_PK" ON "PROFESOR" ("ID_PROF") 
  ;
--------------------------------------------------------
--  Constraints for Table CICLO
--------------------------------------------------------

  ALTER TABLE "CICLO" ADD CONSTRAINT "CICLO_PK" PRIMARY KEY ("ID_CICLO") ENABLE;
  ALTER TABLE "CICLO" MODIFY ("ID_CICLO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CURSO
--------------------------------------------------------

  ALTER TABLE "CURSO" ADD CONSTRAINT "CURSO_PK" PRIMARY KEY ("ID_CICLO", "ID_CURSO") ENABLE;
  ALTER TABLE "CURSO" MODIFY ("ID_CICLO" NOT NULL ENABLE);
  ALTER TABLE "CURSO" MODIFY ("ID_CURSO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ESTUDIANTE
--------------------------------------------------------

  ALTER TABLE "ESTUDIANTE" ADD CONSTRAINT "ESTUDIANTE_DNI_UN" UNIQUE ("DNI") ENABLE;
  ALTER TABLE "ESTUDIANTE" ADD CONSTRAINT "ESTUDIANTE_PK" PRIMARY KEY ("ID_ESTUD") ENABLE;
  ALTER TABLE "ESTUDIANTE" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "ESTUDIANTE" MODIFY ("ID_ESTUD" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FICHA_ALUMNO
--------------------------------------------------------

  ALTER TABLE "FICHA_ALUMNO" ADD CONSTRAINT "FICHA_ALUMNO_PK" PRIMARY KEY ("NOTAS_ID_NOTA", "ID_MODULO", "ID_CICLO", "ID_CURSO") ENABLE;
  ALTER TABLE "FICHA_ALUMNO" MODIFY ("CALIFICACION" NOT NULL ENABLE);
  ALTER TABLE "FICHA_ALUMNO" MODIFY ("ID_CURSO" NOT NULL ENABLE);
  ALTER TABLE "FICHA_ALUMNO" MODIFY ("ID_CICLO" NOT NULL ENABLE);
  ALTER TABLE "FICHA_ALUMNO" MODIFY ("ID_MODULO" NOT NULL ENABLE);
  ALTER TABLE "FICHA_ALUMNO" MODIFY ("NOTAS_ID_NOTA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table GRUPO
--------------------------------------------------------

  ALTER TABLE "GRUPO" ADD CONSTRAINT "GRUPO_PK" PRIMARY KEY ("ID_GRUPO", "ID_CICLO", "ID_CURSO") ENABLE;
  ALTER TABLE "GRUPO" MODIFY ("ID_PROF" NOT NULL ENABLE);
  ALTER TABLE "GRUPO" MODIFY ("ID_CICLO" NOT NULL ENABLE);
  ALTER TABLE "GRUPO" MODIFY ("ID_GRUPO" NOT NULL ENABLE);
  ALTER TABLE "GRUPO" MODIFY ("ID_CURSO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table HORARIO_CLASES
--------------------------------------------------------

  ALTER TABLE "HORARIO_CLASES" ADD CONSTRAINT "HORARIO_CLASES_PK" PRIMARY KEY ("ID_MODULO", "ID_CICLO", "ID_CURSO", "ID_PROF", "ID_GRUPO") ENABLE;
  ALTER TABLE "HORARIO_CLASES" MODIFY ("ID_GRUPO" NOT NULL ENABLE);
  ALTER TABLE "HORARIO_CLASES" MODIFY ("ID_PROF" NOT NULL ENABLE);
  ALTER TABLE "HORARIO_CLASES" MODIFY ("ID_CURSO" NOT NULL ENABLE);
  ALTER TABLE "HORARIO_CLASES" MODIFY ("ID_CICLO" NOT NULL ENABLE);
  ALTER TABLE "HORARIO_CLASES" MODIFY ("ID_MODULO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MOD_MATRICULA
--------------------------------------------------------

  ALTER TABLE "MOD_MATRICULA" ADD CONSTRAINT "MOD_MATRICULA_PK" PRIMARY KEY ("ID_GRUPO", "ID_CICLO", "ID_CURSO", "ID_MODULO", "ID_ESTUD") ENABLE;
  ALTER TABLE "MOD_MATRICULA" MODIFY ("ID_ESTUD" NOT NULL ENABLE);
  ALTER TABLE "MOD_MATRICULA" MODIFY ("ID_MODULO" NOT NULL ENABLE);
  ALTER TABLE "MOD_MATRICULA" MODIFY ("ID_CURSO" NOT NULL ENABLE);
  ALTER TABLE "MOD_MATRICULA" MODIFY ("ID_CICLO" NOT NULL ENABLE);
  ALTER TABLE "MOD_MATRICULA" MODIFY ("ID_GRUPO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MODULO
--------------------------------------------------------

  ALTER TABLE "MODULO" ADD CONSTRAINT "MODULO_PK" PRIMARY KEY ("ID_MODULO") ENABLE;
  ALTER TABLE "MODULO" MODIFY ("ID_MODULO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table NOTAS
--------------------------------------------------------

  ALTER TABLE "NOTAS" ADD CONSTRAINT "NOTAS_PK" PRIMARY KEY ("ID_NOTA") ENABLE;
  ALTER TABLE "NOTAS" MODIFY ("TRIMESTRE" NOT NULL ENABLE);
  ALTER TABLE "NOTAS" MODIFY ("ID_NOTA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PLAN_ESTUDIOS
--------------------------------------------------------

  ALTER TABLE "PLAN_ESTUDIOS" ADD CONSTRAINT "PLAN_ESTUDIOS_PK" PRIMARY KEY ("MODULO_ID_MODULO", "CURSO_ID_CICLO", "CURSO_ID_CURSO") ENABLE;
  ALTER TABLE "PLAN_ESTUDIOS" MODIFY ("CURSO_ID_CURSO" NOT NULL ENABLE);
  ALTER TABLE "PLAN_ESTUDIOS" MODIFY ("CURSO_ID_CICLO" NOT NULL ENABLE);
  ALTER TABLE "PLAN_ESTUDIOS" MODIFY ("MODULO_ID_MODULO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROFESOR
--------------------------------------------------------

  ALTER TABLE "PROFESOR" ADD CONSTRAINT "PROFESOR_DNI_UN" UNIQUE ("DNI") ENABLE;
  ALTER TABLE "PROFESOR" ADD CONSTRAINT "PROFESOR_PK" PRIMARY KEY ("ID_PROF") ENABLE;
  ALTER TABLE "PROFESOR" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "PROFESOR" MODIFY ("ID_PROF" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table CURSO
--------------------------------------------------------

  ALTER TABLE "CURSO" ADD CONSTRAINT "CURSO_CICLO_FK" FOREIGN KEY ("ID_CICLO")
	  REFERENCES "CICLO" ("ID_CICLO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table FICHA_ALUMNO
--------------------------------------------------------

  ALTER TABLE "FICHA_ALUMNO" ADD CONSTRAINT "FICHA_EST_FK" FOREIGN KEY ("ID_MODULO", "ID_CICLO", "ID_CURSO")
	  REFERENCES "PLAN_ESTUDIOS" ("MODULO_ID_MODULO", "CURSO_ID_CICLO", "CURSO_ID_CURSO") ENABLE;
  ALTER TABLE "FICHA_ALUMNO" ADD CONSTRAINT "FICHA_NOTAS_FK" FOREIGN KEY ("NOTAS_ID_NOTA")
	  REFERENCES "NOTAS" ("ID_NOTA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table GRUPO
--------------------------------------------------------

  ALTER TABLE "GRUPO" ADD CONSTRAINT "GRUPO_CURSO_FK" FOREIGN KEY ("ID_CICLO", "ID_CURSO")
	  REFERENCES "CURSO" ("ID_CICLO", "ID_CURSO") ENABLE;
  ALTER TABLE "GRUPO" ADD CONSTRAINT "GRUPO_PROF_FK" FOREIGN KEY ("ID_PROF")
	  REFERENCES "PROFESOR" ("ID_PROF") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table HORARIO_CLASES
--------------------------------------------------------

  ALTER TABLE "HORARIO_CLASES" ADD CONSTRAINT "HOR_CLAS_GRU_FK" FOREIGN KEY ("ID_GRUPO", "ID_CICLO", "ID_CURSO")
	  REFERENCES "GRUPO" ("ID_GRUPO", "ID_CICLO", "ID_CURSO") ENABLE;
  ALTER TABLE "HORARIO_CLASES" ADD CONSTRAINT "HOR_CLAS_PLAN_EST_FK" FOREIGN KEY ("ID_MODULO", "ID_CICLO", "ID_CURSO")
	  REFERENCES "PLAN_ESTUDIOS" ("MODULO_ID_MODULO", "CURSO_ID_CICLO", "CURSO_ID_CURSO") ENABLE;
  ALTER TABLE "HORARIO_CLASES" ADD CONSTRAINT "HOR_CLAS_PROF_FK" FOREIGN KEY ("ID_PROF")
	  REFERENCES "PROFESOR" ("ID_PROF") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MOD_MATRICULA
--------------------------------------------------------

  ALTER TABLE "MOD_MATRICULA" ADD CONSTRAINT "MOD_MAT_EST_FK" FOREIGN KEY ("ID_ESTUD")
	  REFERENCES "ESTUDIANTE" ("ID_ESTUD") ENABLE;
  ALTER TABLE "MOD_MATRICULA" ADD CONSTRAINT "MOD_MAT_GRUPO_FK" FOREIGN KEY ("ID_GRUPO", "ID_CICLO", "ID_CURSO")
	  REFERENCES "GRUPO" ("ID_GRUPO", "ID_CICLO", "ID_CURSO") ENABLE;
  ALTER TABLE "MOD_MATRICULA" ADD CONSTRAINT "MOD_MAT_PLAN_EST_FK" FOREIGN KEY ("ID_MODULO", "ID_CICLO", "ID_CURSO")
	  REFERENCES "PLAN_ESTUDIOS" ("MODULO_ID_MODULO", "CURSO_ID_CICLO", "CURSO_ID_CURSO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PLAN_ESTUDIOS
--------------------------------------------------------

  ALTER TABLE "PLAN_ESTUDIOS" ADD CONSTRAINT "PLAN_ESTUDIOS_CURSO_FK" FOREIGN KEY ("CURSO_ID_CICLO", "CURSO_ID_CURSO")
	  REFERENCES "CURSO" ("ID_CICLO", "ID_CURSO") ENABLE;
  ALTER TABLE "PLAN_ESTUDIOS" ADD CONSTRAINT "PLAN_ESTUDIOS_MODULO_FK" FOREIGN KEY ("MODULO_ID_MODULO")
	  REFERENCES "MODULO" ("ID_MODULO") ENABLE;
