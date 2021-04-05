--------------------------------------------------------
-- Archivo creado  - lunes-noviembre-19-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table FAC_CABECERA
--------------------------------------------------------

  CREATE TABLE "FAC_CABECERA" 
   (	"ID_FACTURA" CHAR(3 BYTE), 
	"ID_CLIENTE" CHAR(3 BYTE), 
	"FECHA_FACTURA" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table FAC_CLIENTE
--------------------------------------------------------

  CREATE TABLE "FAC_CLIENTE" 
   (	"ID_CLIENTE" CHAR(3 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"FE_NACIMIENTO" DATE, 
	"CP" NUMBER(8,2)
   ) ;
--------------------------------------------------------
--  DDL for Table FAC_DETALLES
--------------------------------------------------------

  CREATE TABLE "FAC_DETALLES" 
   (	"CANTIDAD" NUMBER(10,2), 
	"ID_FACTURA" CHAR(3 BYTE), 
	"ID_PRODUCTO" CHAR(5 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table FAC_PRODUCTOS
--------------------------------------------------------

  CREATE TABLE "FAC_PRODUCTOS" 
   (	"ID_PRODUCTO" CHAR(5 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"FEC_CREACION" DATE, 
	"PRECIO" NUMBER(8,2)
   ) ;
REM INSERTING into FAC_CABECERA
SET DEFINE OFF;
REM INSERTING into FAC_CLIENTE
SET DEFINE OFF;
REM INSERTING into FAC_DETALLES
SET DEFINE OFF;
REM INSERTING into FAC_PRODUCTOS
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index FAC_CABECERA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FAC_CABECERA_PK" ON "FAC_CABECERA" ("ID_FACTURA") 
  ;
--------------------------------------------------------
--  DDL for Index FAC_CLIENTE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FAC_CLIENTE_PK" ON "FAC_CLIENTE" ("ID_CLIENTE") 
  ;
--------------------------------------------------------
--  DDL for Index FAC_PRODUCTOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FAC_PRODUCTOS_PK" ON "FAC_PRODUCTOS" ("ID_PRODUCTO") 
  ;
--------------------------------------------------------
--  Constraints for Table FAC_CABECERA
--------------------------------------------------------

  ALTER TABLE "FAC_CABECERA" ADD CONSTRAINT "FAC_CABECERA_PK" PRIMARY KEY ("ID_FACTURA") ENABLE;
  ALTER TABLE "FAC_CABECERA" MODIFY ("FECHA_FACTURA" NOT NULL ENABLE);
  ALTER TABLE "FAC_CABECERA" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "FAC_CABECERA" MODIFY ("ID_FACTURA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FAC_CLIENTE
--------------------------------------------------------

  ALTER TABLE "FAC_CLIENTE" ADD CONSTRAINT "FAC_CLIENTE_PK" PRIMARY KEY ("ID_CLIENTE") ENABLE;
  ALTER TABLE "FAC_CLIENTE" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FAC_DETALLES
--------------------------------------------------------

  ALTER TABLE "FAC_DETALLES" MODIFY ("ID_PRODUCTO" NOT NULL ENABLE);
  ALTER TABLE "FAC_DETALLES" MODIFY ("ID_FACTURA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FAC_PRODUCTOS
--------------------------------------------------------

  ALTER TABLE "FAC_PRODUCTOS" MODIFY ("ID_PRODUCTO" NOT NULL ENABLE);
  ALTER TABLE "FAC_PRODUCTOS" ADD CONSTRAINT "FAC_PRODUCTOS_PK" PRIMARY KEY ("ID_PRODUCTO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table FAC_CABECERA
--------------------------------------------------------

  ALTER TABLE "FAC_CABECERA" ADD CONSTRAINT "FAC_CAB_CLIEN_FK1" FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "FAC_CLIENTE" ("ID_CLIENTE") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table FAC_DETALLES
--------------------------------------------------------

  ALTER TABLE "FAC_DETALLES" ADD CONSTRAINT "FAC_DETALLES_CAB_FK1" FOREIGN KEY ("ID_FACTURA")
	  REFERENCES "FAC_CABECERA" ("ID_FACTURA") ENABLE;
  ALTER TABLE "FAC_DETALLES" ADD CONSTRAINT "FAC_DETALLES_PROD_FK1" FOREIGN KEY ("ID_PRODUCTO")
	  REFERENCES "FAC_PRODUCTOS" ("ID_PRODUCTO") ENABLE;
