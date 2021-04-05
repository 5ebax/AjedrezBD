--------------------------------------------------------
-- Archivo creado  - domingo-noviembre-18-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ARTICULO
--------------------------------------------------------

  CREATE TABLE "ARTICULO" 
   (	"ID_ARTICULO" CHAR(3 BYTE), 
	"ID_SECCION" CHAR(3 BYTE), 
	"NOM_ART" VARCHAR2(20 BYTE), 
	"DESC_ART" VARCHAR2(100 BYTE), 
	"STOCK" NUMBER(6,0)
   ) ;
--------------------------------------------------------
--  DDL for Table CLIENTE
--------------------------------------------------------

  CREATE TABLE "CLIENTE" 
   (	"ID_CLIENTE" CHAR(3 BYTE), 
	"DNI" CHAR(9 BYTE), 
	"REGISTRO" CHAR(1 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"FECH_NACI" DATE, 
	"TELEFONO" NUMBER(10,0), 
	"CP" VARCHAR2(10 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table COMPRA
--------------------------------------------------------

  CREATE TABLE "COMPRA" 
   (	"ID_COMPRA" CHAR(3 BYTE), 
	"ID_EMPLEADO" CHAR(3 BYTE), 
	"FECH_COMPRA" DATE, 
	"ID_PROV" CHAR(3 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table DEPARTAMENTO
--------------------------------------------------------

  CREATE TABLE "DEPARTAMENTO" 
   (	"ID_DEPART" CHAR(3 BYTE), 
	"ID_EMP_JEF" CHAR(3 BYTE), 
	"NOM_DEPART" VARCHAR2(20 BYTE), 
	"NUM_VEND" NUMBER(6,0)
   ) ;
--------------------------------------------------------
--  DDL for Table DET_COMPRA
--------------------------------------------------------

  CREATE TABLE "DET_COMPRA" 
   (	"ID_ARTICULO" CHAR(3 BYTE), 
	"ID_COMPRA" CHAR(3 BYTE), 
	"CANTIDAD" NUMBER(8,0), 
	"PRECIO" NUMBER(8,2)
   ) ;
--------------------------------------------------------
--  DDL for Table DET_VENTA
--------------------------------------------------------

  CREATE TABLE "DET_VENTA" 
   (	"ID_ARTICULO" CHAR(3 BYTE), 
	"ID_VENTA" CHAR(3 BYTE), 
	"CANTIDAD" NUMBER(3,0), 
	"PRECIO" NUMBER(8,2)
   ) ;
--------------------------------------------------------
--  DDL for Table EMPLEADO
--------------------------------------------------------

  CREATE TABLE "EMPLEADO" 
   (	"ID_EMPLEADO" CHAR(3 BYTE), 
	"ID_DEPART" CHAR(3 BYTE), 
	"DNI" CHAR(9 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"FECHA_CONT" DATE, 
	"SALARIO" NUMBER(8,2), 
	"EMAIL" VARCHAR2(20 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVEEDOR
--------------------------------------------------------

  CREATE TABLE "PROVEEDOR" 
   (	"ID_PROV" CHAR(3 BYTE), 
	"NOM_PROV" VARCHAR2(20 BYTE), 
	"TEL_PROV" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table SECCION
--------------------------------------------------------

  CREATE TABLE "SECCION" 
   (	"ID_SECCION" CHAR(3 BYTE), 
	"ID_DEPART" CHAR(3 BYTE), 
	"NOM_SECC" VARCHAR2(20 BYTE), 
	"AREA_SEC" NUMBER(6,2)
   ) ;
--------------------------------------------------------
--  DDL for Table VENTA
--------------------------------------------------------

  CREATE TABLE "VENTA" 
   (	"ID_VENTA" CHAR(3 BYTE), 
	"ID_EMPLEADO" CHAR(3 BYTE), 
	"ID_CLIENTE" CHAR(3 BYTE), 
	"FECH_VENTA" DATE
   ) ;
REM INSERTING into ARTICULO
SET DEFINE OFF;
Insert into ARTICULO (ID_ARTICULO,ID_SECCION,NOM_ART,DESC_ART,STOCK) values ('1  ','1  ','POLLO GOMA','Un pollo de goma','666');
Insert into ARTICULO (ID_ARTICULO,ID_SECCION,NOM_ART,DESC_ART,STOCK) values ('2  ','1  ','CAMISETA POLLO','Una camiseta de un pollo','777');
Insert into ARTICULO (ID_ARTICULO,ID_SECCION,NOM_ART,DESC_ART,STOCK) values ('3  ','2  ','PALA','Una pala','555');
REM INSERTING into CLIENTE
SET DEFINE OFF;
Insert into CLIENTE (ID_CLIENTE,DNI,REGISTRO,NOMBRE,FECH_NACI,TELEFONO,CP) values ('1  ','98234723E','V','SEBAS',to_date('24/08/1995','DD/MM/YYYY'),'888444222','41130');
Insert into CLIENTE (ID_CLIENTE,DNI,REGISTRO,NOMBRE,FECH_NACI,TELEFONO,CP) values ('2  ','84724802W','F',null,null,null,null);
Insert into CLIENTE (ID_CLIENTE,DNI,REGISTRO,NOMBRE,FECH_NACI,TELEFONO,CP) values ('3  ','23482352E','F',null,null,null,null);
REM INSERTING into COMPRA
SET DEFINE OFF;
Insert into COMPRA (ID_COMPRA,ID_EMPLEADO,FECH_COMPRA,ID_PROV) values ('1  ','1  ',to_date('15/11/2018','DD/MM/YYYY'),'1  ');
Insert into COMPRA (ID_COMPRA,ID_EMPLEADO,FECH_COMPRA,ID_PROV) values ('2  ','2  ',to_date('23/08/2018','DD/MM/YYYY'),'1  ');
REM INSERTING into DEPARTAMENTO
SET DEFINE OFF;
Insert into DEPARTAMENTO (ID_DEPART,ID_EMP_JEF,NOM_DEPART,NUM_VEND) values ('1  ','1  ','POLLOS','30');
Insert into DEPARTAMENTO (ID_DEPART,ID_EMP_JEF,NOM_DEPART,NUM_VEND) values ('2  ','3  ','JARDINERIA','50');
REM INSERTING into DET_COMPRA
SET DEFINE OFF;
Insert into DET_COMPRA (ID_ARTICULO,ID_COMPRA,CANTIDAD,PRECIO) values ('1  ','1  ','500','1000');
Insert into DET_COMPRA (ID_ARTICULO,ID_COMPRA,CANTIDAD,PRECIO) values ('2  ','2  ','200','600');
REM INSERTING into DET_VENTA
SET DEFINE OFF;
Insert into DET_VENTA (ID_ARTICULO,ID_VENTA,CANTIDAD,PRECIO) values ('1  ','1  ','25','50');
Insert into DET_VENTA (ID_ARTICULO,ID_VENTA,CANTIDAD,PRECIO) values ('2  ','1  ','10','50');
Insert into DET_VENTA (ID_ARTICULO,ID_VENTA,CANTIDAD,PRECIO) values ('3  ','2  ','3','15');
Insert into DET_VENTA (ID_ARTICULO,ID_VENTA,CANTIDAD,PRECIO) values ('2  ','3  ','11','55');
REM INSERTING into EMPLEADO
SET DEFINE OFF;
Insert into EMPLEADO (ID_EMPLEADO,ID_DEPART,DNI,NOMBRE,FECHA_CONT,SALARIO,EMAIL) values ('1  ','1  ','66778899E','DON POLLO',to_date('08/04/2000','DD/MM/YYYY'),'1500','POLLO@GMAIL.COM');
Insert into EMPLEADO (ID_EMPLEADO,ID_DEPART,DNI,NOMBRE,FECHA_CONT,SALARIO,EMAIL) values ('2  ','1  ','44556622W','JUANI',to_date('05/11/2014','DD/MM/YYYY'),'1000','JUANI@GMAIL.ES');
Insert into EMPLEADO (ID_EMPLEADO,ID_DEPART,DNI,NOMBRE,FECHA_CONT,SALARIO,EMAIL) values ('3  ','2  ','65778476G','GARDENIA',to_date('16/06/2011','DD/MM/YYYY'),'1450','GARDE@YAHOO.COM');
REM INSERTING into PROVEEDOR
SET DEFINE OFF;
Insert into PROVEEDOR (ID_PROV,NOM_PROV,TEL_PROV) values ('1  ','POLLOS.SL','901105544');
Insert into PROVEEDOR (ID_PROV,NOM_PROV,TEL_PROV) values ('2  ','JARDINCIN.SL','757868949');
REM INSERTING into SECCION
SET DEFINE OFF;
Insert into SECCION (ID_SECCION,ID_DEPART,NOM_SECC,AREA_SEC) values ('1  ','1  ','POLLOS','20');
Insert into SECCION (ID_SECCION,ID_DEPART,NOM_SECC,AREA_SEC) values ('2  ','1  ','ROPA POLLOS','30');
Insert into SECCION (ID_SECCION,ID_DEPART,NOM_SECC,AREA_SEC) values ('3  ','2  ','HERRAMIENTAS','40');
REM INSERTING into VENTA
SET DEFINE OFF;
Insert into VENTA (ID_VENTA,ID_EMPLEADO,ID_CLIENTE,FECH_VENTA) values ('1  ','2  ','1  ',to_date('09/11/2018','DD/MM/YYYY'));
Insert into VENTA (ID_VENTA,ID_EMPLEADO,ID_CLIENTE,FECH_VENTA) values ('2  ','3  ','2  ',to_date('16/08/2018','DD/MM/YYYY'));
Insert into VENTA (ID_VENTA,ID_EMPLEADO,ID_CLIENTE,FECH_VENTA) values ('3  ','1  ','3  ',to_date('02/11/2018','DD/MM/YYYY'));
--------------------------------------------------------
--  DDL for Index ARTICULO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ARTICULO_PK" ON "ARTICULO" ("ID_ARTICULO") 
  ;
--------------------------------------------------------
--  DDL for Index CLIENTE_DNI_UN
--------------------------------------------------------

  CREATE UNIQUE INDEX "CLIENTE_DNI_UN" ON "CLIENTE" ("DNI") 
  ;
--------------------------------------------------------
--  DDL for Index CLIENTE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CLIENTE_PK" ON "CLIENTE" ("ID_CLIENTE") 
  ;
--------------------------------------------------------
--  DDL for Index COMPRA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "COMPRA_PK" ON "COMPRA" ("ID_COMPRA") 
  ;
--------------------------------------------------------
--  DDL for Index DEPARTAMENTO__IDX
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEPARTAMENTO__IDX" ON "DEPARTAMENTO" ("ID_EMP_JEF") 
  ;
--------------------------------------------------------
--  DDL for Index DEPARTAMENTO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEPARTAMENTO_PK" ON "DEPARTAMENTO" ("ID_DEPART") 
  ;
--------------------------------------------------------
--  DDL for Index DET_COMPRA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DET_COMPRA_PK" ON "DET_COMPRA" ("ID_ARTICULO", "ID_COMPRA") 
  ;
--------------------------------------------------------
--  DDL for Index DET_VENTA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DET_VENTA_PK" ON "DET_VENTA" ("ID_ARTICULO", "ID_VENTA") 
  ;
--------------------------------------------------------
--  DDL for Index EMPLEADO_DNI_UN
--------------------------------------------------------

  CREATE UNIQUE INDEX "EMPLEADO_DNI_UN" ON "EMPLEADO" ("DNI") 
  ;
--------------------------------------------------------
--  DDL for Index EMPLEADO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "EMPLEADO_PK" ON "EMPLEADO" ("ID_EMPLEADO") 
  ;
--------------------------------------------------------
--  DDL for Index PROVEEDOR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROVEEDOR_PK" ON "PROVEEDOR" ("ID_PROV") 
  ;
--------------------------------------------------------
--  DDL for Index SECCION_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SECCION_PK" ON "SECCION" ("ID_SECCION") 
  ;
--------------------------------------------------------
--  DDL for Index VENTA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "VENTA_PK" ON "VENTA" ("ID_VENTA") 
  ;
--------------------------------------------------------
--  Constraints for Table ARTICULO
--------------------------------------------------------

  ALTER TABLE "ARTICULO" MODIFY ("ID_ARTICULO" NOT NULL ENABLE);
  ALTER TABLE "ARTICULO" MODIFY ("ID_SECCION" NOT NULL ENABLE);
  ALTER TABLE "ARTICULO" ADD CONSTRAINT "ARTICULO_PK" PRIMARY KEY ("ID_ARTICULO") ENABLE;
--------------------------------------------------------
--  Constraints for Table CLIENTE
--------------------------------------------------------

  ALTER TABLE "CLIENTE" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "CLIENTE" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "CLIENTE" MODIFY ("REGISTRO" NOT NULL ENABLE);
  ALTER TABLE "CLIENTE" ADD CONSTRAINT "CLIENTE_PK" PRIMARY KEY ("ID_CLIENTE") ENABLE;
  ALTER TABLE "CLIENTE" ADD CONSTRAINT "CLIENTE_DNI_UN" UNIQUE ("DNI") ENABLE;
--------------------------------------------------------
--  Constraints for Table COMPRA
--------------------------------------------------------

  ALTER TABLE "COMPRA" MODIFY ("ID_COMPRA" NOT NULL ENABLE);
  ALTER TABLE "COMPRA" MODIFY ("ID_EMPLEADO" NOT NULL ENABLE);
  ALTER TABLE "COMPRA" ADD CONSTRAINT "COMPRA_PK" PRIMARY KEY ("ID_COMPRA") ENABLE;
--------------------------------------------------------
--  Constraints for Table DEPARTAMENTO
--------------------------------------------------------

  ALTER TABLE "DEPARTAMENTO" MODIFY ("ID_DEPART" NOT NULL ENABLE);
  ALTER TABLE "DEPARTAMENTO" ADD CONSTRAINT "DEPARTAMENTO_PK" PRIMARY KEY ("ID_DEPART") ENABLE;
--------------------------------------------------------
--  Constraints for Table DET_COMPRA
--------------------------------------------------------

  ALTER TABLE "DET_COMPRA" MODIFY ("ID_ARTICULO" NOT NULL ENABLE);
  ALTER TABLE "DET_COMPRA" MODIFY ("ID_COMPRA" NOT NULL ENABLE);
  ALTER TABLE "DET_COMPRA" ADD CONSTRAINT "DET_COMPRA_PK" PRIMARY KEY ("ID_ARTICULO", "ID_COMPRA") ENABLE;
--------------------------------------------------------
--  Constraints for Table DET_VENTA
--------------------------------------------------------

  ALTER TABLE "DET_VENTA" MODIFY ("ID_ARTICULO" NOT NULL ENABLE);
  ALTER TABLE "DET_VENTA" MODIFY ("ID_VENTA" NOT NULL ENABLE);
  ALTER TABLE "DET_VENTA" ADD CONSTRAINT "DET_VENTA_PK" PRIMARY KEY ("ID_ARTICULO", "ID_VENTA") ENABLE;
--------------------------------------------------------
--  Constraints for Table EMPLEADO
--------------------------------------------------------

  ALTER TABLE "EMPLEADO" MODIFY ("ID_EMPLEADO" NOT NULL ENABLE);
  ALTER TABLE "EMPLEADO" MODIFY ("ID_DEPART" NOT NULL ENABLE);
  ALTER TABLE "EMPLEADO" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "EMPLEADO" ADD CONSTRAINT "EMPLEADO_PK" PRIMARY KEY ("ID_EMPLEADO") ENABLE;
  ALTER TABLE "EMPLEADO" ADD CONSTRAINT "EMPLEADO_DNI_UN" UNIQUE ("DNI") ENABLE;
--------------------------------------------------------
--  Constraints for Table PROVEEDOR
--------------------------------------------------------

  ALTER TABLE "PROVEEDOR" MODIFY ("ID_PROV" NOT NULL ENABLE);
  ALTER TABLE "PROVEEDOR" ADD CONSTRAINT "PROVEEDOR_PK" PRIMARY KEY ("ID_PROV") ENABLE;
--------------------------------------------------------
--  Constraints for Table SECCION
--------------------------------------------------------

  ALTER TABLE "SECCION" MODIFY ("ID_SECCION" NOT NULL ENABLE);
  ALTER TABLE "SECCION" MODIFY ("ID_DEPART" NOT NULL ENABLE);
  ALTER TABLE "SECCION" ADD CONSTRAINT "SECCION_PK" PRIMARY KEY ("ID_SECCION") ENABLE;
--------------------------------------------------------
--  Constraints for Table VENTA
--------------------------------------------------------

  ALTER TABLE "VENTA" MODIFY ("ID_VENTA" NOT NULL ENABLE);
  ALTER TABLE "VENTA" MODIFY ("ID_EMPLEADO" NOT NULL ENABLE);
  ALTER TABLE "VENTA" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "VENTA" ADD CONSTRAINT "VENTA_PK" PRIMARY KEY ("ID_VENTA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ARTICULO
--------------------------------------------------------

  ALTER TABLE "ARTICULO" ADD CONSTRAINT "ART_SEC_FK" FOREIGN KEY ("ID_SECCION")
	  REFERENCES "SECCION" ("ID_SECCION") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COMPRA
--------------------------------------------------------

  ALTER TABLE "COMPRA" ADD CONSTRAINT "COMPRA_EMP_FK" FOREIGN KEY ("ID_EMPLEADO")
	  REFERENCES "EMPLEADO" ("ID_EMPLEADO") ENABLE;
  ALTER TABLE "COMPRA" ADD CONSTRAINT "COMPRA_PROV_FK" FOREIGN KEY ("ID_PROV")
	  REFERENCES "PROVEEDOR" ("ID_PROV") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DEPARTAMENTO
--------------------------------------------------------

  ALTER TABLE "DEPARTAMENTO" ADD CONSTRAINT "DEPAR_EMP_FK" FOREIGN KEY ("ID_EMP_JEF")
	  REFERENCES "EMPLEADO" ("ID_EMPLEADO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DET_COMPRA
--------------------------------------------------------

  ALTER TABLE "DET_COMPRA" ADD CONSTRAINT "DET_COMP_ART_FK" FOREIGN KEY ("ID_ARTICULO")
	  REFERENCES "ARTICULO" ("ID_ARTICULO") ENABLE;
  ALTER TABLE "DET_COMPRA" ADD CONSTRAINT "DET_COMP_COM_FK" FOREIGN KEY ("ID_COMPRA")
	  REFERENCES "COMPRA" ("ID_COMPRA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DET_VENTA
--------------------------------------------------------

  ALTER TABLE "DET_VENTA" ADD CONSTRAINT "DET_VENTA_ART_FK" FOREIGN KEY ("ID_ARTICULO")
	  REFERENCES "ARTICULO" ("ID_ARTICULO") ENABLE;
  ALTER TABLE "DET_VENTA" ADD CONSTRAINT "DET_VENT_VENT_FK" FOREIGN KEY ("ID_VENTA")
	  REFERENCES "VENTA" ("ID_VENTA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table EMPLEADO
--------------------------------------------------------

  ALTER TABLE "EMPLEADO" ADD CONSTRAINT "EMP_DEPAR_FK" FOREIGN KEY ("ID_DEPART")
	  REFERENCES "DEPARTAMENTO" ("ID_DEPART") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SECCION
--------------------------------------------------------

  ALTER TABLE "SECCION" ADD CONSTRAINT "SEC_DEPAR_FK" FOREIGN KEY ("ID_DEPART")
	  REFERENCES "DEPARTAMENTO" ("ID_DEPART") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table VENTA
--------------------------------------------------------

  ALTER TABLE "VENTA" ADD CONSTRAINT "VENTA_CLIEN_FK" FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "CLIENTE" ("ID_CLIENTE") ENABLE;
  ALTER TABLE "VENTA" ADD CONSTRAINT "VENTA_EMP_FK" FOREIGN KEY ("ID_EMPLEADO")
	  REFERENCES "EMPLEADO" ("ID_EMPLEADO") ENABLE;
