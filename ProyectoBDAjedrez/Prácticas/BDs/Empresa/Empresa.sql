--------------------------------------------------------
-- Archivo creado  - lunes-noviembre-19-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table DEPARTAMENTO
--------------------------------------------------------

  CREATE TABLE "DEPARTAMENTO" 
   (	"ID_DPTO" VARCHAR2(4 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"FECHA_CREACION" DATE, 
	"PRESUPUESTO" NUMBER(8,2)
   ) ;
--------------------------------------------------------
--  DDL for Table EMPLEADO
--------------------------------------------------------

  CREATE TABLE "EMPLEADO" 
   (	"DNI" VARCHAR2(9 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"FECHA_ALTA" DATE, 
	"SALARIO" NUMBER(6,2), 
	"ID_DPTO" VARCHAR2(4 BYTE)
   ) ;
REM INSERTING into DEPARTAMENTO
SET DEFINE OFF;
Insert into DEPARTAMENTO (ID_DPTO,NOMBRE,FECHA_CREACION,PRESUPUESTO) values ('A','COMPRAS',to_date('17/06/2017','DD/MM/YYYY'),'18000');
Insert into DEPARTAMENTO (ID_DPTO,NOMBRE,FECHA_CREACION,PRESUPUESTO) values ('B','VENTAS',to_date('02/10/2017','DD/MM/YYYY'),'16000');
Insert into DEPARTAMENTO (ID_DPTO,NOMBRE,FECHA_CREACION,PRESUPUESTO) values ('D','RRHH',to_date('01/10/2018','DD/MM/YYYY'),'35000');
REM INSERTING into EMPLEADO
SET DEFINE OFF;
Insert into EMPLEADO (DNI,NOMBRE,FECHA_ALTA,SALARIO,ID_DPTO) values ('1','PEPE',to_date('19/10/2017','DD/MM/YYYY'),'1000','A');
Insert into EMPLEADO (DNI,NOMBRE,FECHA_ALTA,SALARIO,ID_DPTO) values ('2','LOLO',to_date('18/10/2017','DD/MM/YYYY'),'1200','A');
Insert into EMPLEADO (DNI,NOMBRE,FECHA_ALTA,SALARIO,ID_DPTO) values ('3','TOMAS',to_date('24/10/2017','DD/MM/YYYY'),'1300','B');
Insert into EMPLEADO (DNI,NOMBRE,FECHA_ALTA,SALARIO,ID_DPTO) values ('4','JACINTO',to_date('13/10/2017','DD/MM/YYYY'),'1400','D');
--------------------------------------------------------
--  DDL for Index DEPARTAMENTO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEPARTAMENTO_PK" ON "DEPARTAMENTO" ("ID_DPTO") 
  ;
--------------------------------------------------------
--  DDL for Index EMPLEADO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "EMPLEADO_PK" ON "EMPLEADO" ("DNI") 
  ;
--------------------------------------------------------
--  Constraints for Table DEPARTAMENTO
--------------------------------------------------------

  ALTER TABLE "DEPARTAMENTO" ADD CONSTRAINT "DEPARTAMENTO_PRESUP_CHK" CHECK (PRESUPUESTO <= 900000) ENABLE;
  ALTER TABLE "DEPARTAMENTO" ADD CONSTRAINT "DEPARTAMENTO_PK" PRIMARY KEY ("ID_DPTO") ENABLE;
  ALTER TABLE "DEPARTAMENTO" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "DEPARTAMENTO" MODIFY ("ID_DPTO" NOT NULL ENABLE);
  ALTER TABLE "DEPARTAMENTO" ADD CONSTRAINT "DEPARTAMENTO_FECHA_CHK" CHECK (FECHA_CREACION <= TO_DATE('2018-10-12','YYYY-MM-DD')) ENABLE;
  ALTER TABLE "DEPARTAMENTO" MODIFY ("PRESUPUESTO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EMPLEADO
--------------------------------------------------------

  ALTER TABLE "EMPLEADO" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "EMPLEADO" ADD CONSTRAINT "EMPLEADO_PK" PRIMARY KEY ("DNI") ENABLE;
  ALTER TABLE "EMPLEADO" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "EMPLEADO" ADD CONSTRAINT "EMPLEADO_FECHA_CHK" CHECK (FECHA_ALTA <= TO_DATE('2018-10-12','YYYY-MM-DD')) ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table EMPLEADO
--------------------------------------------------------

  ALTER TABLE "EMPLEADO" ADD CONSTRAINT "EMPLEADO_DPTO_FK" FOREIGN KEY ("ID_DPTO")
	  REFERENCES "DEPARTAMENTO" ("ID_DPTO") ENABLE;
