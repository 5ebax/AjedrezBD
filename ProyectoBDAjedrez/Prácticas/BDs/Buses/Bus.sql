--------------------------------------------------------
-- Archivo creado  - lunes-noviembre-19-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table BUS
--------------------------------------------------------

  CREATE TABLE "BUS" 
   (	"MATRICULA" VARCHAR2(7 BYTE), 
	"MARCA_BUS" VARCHAR2(20 BYTE), 
	"FECHA_COMPRA" DATE, 
	"DNI_COND" VARCHAR2(20 BYTE), 
	"PRECIO" NUMBER(6,0), 
	"KM_ULT_REV" NUMBER(7,0)
   ) ;
--------------------------------------------------------
--  DDL for Table BUS_CONDUCTOR
--------------------------------------------------------

  CREATE TABLE "BUS_CONDUCTOR" 
   (	"DNI_COND" VARCHAR2(20 BYTE), 
	"APELLIDOS" VARCHAR2(20 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"FECHA_NAC" DATE, 
	"FECHA_CARNET" DATE, 
	"NUM_SS" VARCHAR2(10 BYTE), 
	"NOMINA" NUMBER(4,0)
   ) ;
--------------------------------------------------------
--  DDL for Table BUS_MARCA
--------------------------------------------------------

  CREATE TABLE "BUS_MARCA" 
   (	"MARCA_BUS" VARCHAR2(20 BYTE), 
	"FECHA_CREACION" DATE, 
	"PAIS" VARCHAR2(20 BYTE), 
	"TELF" VARCHAR2(20 BYTE), 
	"FAX" VARCHAR2(20 BYTE)
   ) ;
REM INSERTING into BUS
SET DEFINE OFF;
REM INSERTING into BUS_CONDUCTOR
SET DEFINE OFF;
Insert into BUS_CONDUCTOR (DNI_COND,APELLIDOS,NOMBRE,FECHA_NAC,FECHA_CARNET,NUM_SS,NOMINA) values ('87264924D','GARCIA
GARCIA','MANUEL',to_date('20/06/1990','DD/MM/YYYY'),to_date('15/12/2008','DD/MM/YYYY'),'4868672842','1500');
Insert into BUS_CONDUCTOR (DNI_COND,APELLIDOS,NOMBRE,FECHA_NAC,FECHA_CARNET,NUM_SS,NOMINA) values ('34596384J','FERNANDEZ
PEREZ','GABRIEL',to_date('05/01/1985','DD/MM/YYYY'),to_date('05/04/2004','DD/MM/YYYY'),'7236987531','1700');
Insert into BUS_CONDUCTOR (DNI_COND,APELLIDOS,NOMBRE,FECHA_NAC,FECHA_CARNET,NUM_SS,NOMINA) values ('98974321T','EXPOSITO
GARCIA','ISABEL',to_date('09/04/1980','DD/MM/YYYY'),to_date('06/05/1999','DD/MM/YYYY'),'7894561230','1750');
REM INSERTING into BUS_MARCA
SET DEFINE OFF;
Insert into BUS_MARCA (MARCA_BUS,FECHA_CREACION,PAIS,TELF,FAX) values ('MERCEDES',to_date('05/07/1985','DD/MM/YYYY'),'ALEMANIA',null,null);
Insert into BUS_MARCA (MARCA_BUS,FECHA_CREACION,PAIS,TELF,FAX) values ('VOLVO',to_date('06/10/2000','DD/MM/YYYY'),'SUECIA',null,null);
Insert into BUS_MARCA (MARCA_BUS,FECHA_CREACION,PAIS,TELF,FAX) values ('BUS IBERIA',to_date('05/04/1990','DD/MM/YYYY'),'ESPAÑA',null,null);
Insert into BUS_MARCA (MARCA_BUS,FECHA_CREACION,PAIS,TELF,FAX) values ('VECTIA',to_date('10/10/2013','DD/MM/YYYY'),'ESPAÑA',null,null);
--------------------------------------------------------
--  DDL for Index BUS_CONDUCTOR_NUM_SS_UN
--------------------------------------------------------

  CREATE UNIQUE INDEX "BUS_CONDUCTOR_NUM_SS_UN" ON "BUS_CONDUCTOR" ("NUM_SS") 
  ;
--------------------------------------------------------
--  DDL for Index BUS_CONDUCTOR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BUS_CONDUCTOR_PK" ON "BUS_CONDUCTOR" ("DNI_COND") 
  ;
--------------------------------------------------------
--  DDL for Index BUS_MARCA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BUS_MARCA_PK" ON "BUS_MARCA" ("MARCA_BUS") 
  ;
--------------------------------------------------------
--  DDL for Index BUS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BUS_PK" ON "BUS" ("MATRICULA") 
  ;
--------------------------------------------------------
--  Constraints for Table BUS
--------------------------------------------------------

  ALTER TABLE "BUS" ADD CONSTRAINT "BUS_PK" PRIMARY KEY ("MATRICULA") ENABLE;
  ALTER TABLE "BUS" MODIFY ("PRECIO" NOT NULL ENABLE);
  ALTER TABLE "BUS" MODIFY ("DNI_COND" NOT NULL ENABLE);
  ALTER TABLE "BUS" MODIFY ("FECHA_COMPRA" NOT NULL ENABLE);
  ALTER TABLE "BUS" MODIFY ("MARCA_BUS" NOT NULL ENABLE);
  ALTER TABLE "BUS" MODIFY ("MATRICULA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BUS_CONDUCTOR
--------------------------------------------------------

  ALTER TABLE "BUS_CONDUCTOR" ADD CONSTRAINT "BUS_CONDUCTOR_NUM_SS_UN" UNIQUE ("NUM_SS") ENABLE;
  ALTER TABLE "BUS_CONDUCTOR" ADD CONSTRAINT "BUS_CONDUCTOR_PK" PRIMARY KEY ("DNI_COND") ENABLE;
  ALTER TABLE "BUS_CONDUCTOR" MODIFY ("NUM_SS" NOT NULL ENABLE);
  ALTER TABLE "BUS_CONDUCTOR" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "BUS_CONDUCTOR" MODIFY ("APELLIDOS" NOT NULL ENABLE);
  ALTER TABLE "BUS_CONDUCTOR" MODIFY ("DNI_COND" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BUS_MARCA
--------------------------------------------------------

  ALTER TABLE "BUS_MARCA" ADD CONSTRAINT "BUS_MARCA_PK" PRIMARY KEY ("MARCA_BUS") ENABLE;
  ALTER TABLE "BUS_MARCA" MODIFY ("MARCA_BUS" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table BUS
--------------------------------------------------------

  ALTER TABLE "BUS" ADD CONSTRAINT "BUS_BUS_COND_FK" FOREIGN KEY ("DNI_COND")
	  REFERENCES "BUS_CONDUCTOR" ("DNI_COND") ENABLE;
  ALTER TABLE "BUS" ADD CONSTRAINT "BUS_BUS_MARCA_FK" FOREIGN KEY ("MARCA_BUS")
	  REFERENCES "BUS_MARCA" ("MARCA_BUS") ENABLE;
