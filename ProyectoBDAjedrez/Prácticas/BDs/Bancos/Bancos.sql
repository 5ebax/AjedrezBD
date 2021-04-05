--------------------------------------------------------
-- Archivo creado  - lunes-noviembre-19-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table BAN_CLIENTES
--------------------------------------------------------

  CREATE TABLE "BAN_CLIENTES" 
   (	"ID_CLIENTE" VARCHAR2(9 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"APELLIDOS" VARCHAR2(20 BYTE), 
	"FECHA_NACIMIENTO" DATE
   ) ;

   COMMENT ON COLUMN "BAN_CLIENTES"."ID_CLIENTE" IS 'DNI';
--------------------------------------------------------
--  DDL for Table BAN_CUENTA
--------------------------------------------------------

  CREATE TABLE "BAN_CUENTA" 
   (	"ID_ENTIDAD" NUMBER(4,0), 
	"ID_SUCURSAL" NUMBER(4,0), 
	"ID_N_CUENTA" NUMBER(10,0), 
	"ID_CLIENTE" VARCHAR2(9 BYTE), 
	"FECHA_APERTURA" DATE, 
	"SALDO" NUMBER(10,2)
   ) ;
--------------------------------------------------------
--  DDL for Table BAN_ENTIDAD
--------------------------------------------------------

  CREATE TABLE "BAN_ENTIDAD" 
   (	"ID_ENTIDAD" NUMBER(4,0), 
	"SEDE" VARCHAR2(20 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"FECHA_CREACION" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table BAN_SUCURSAL
--------------------------------------------------------

  CREATE TABLE "BAN_SUCURSAL" 
   (	"BAN_ENTIDAD_ID_ENTIDAD" NUMBER(4,0), 
	"ID_SUCURSAL" NUMBER(4,0), 
	"CIUDAD" VARCHAR2(20 BYTE), 
	"DIRECCION" VARCHAR2(20 BYTE), 
	"TELEFONO" NUMBER(9,0), 
	"FECHA_APERTURA" DATE, 
	"NUM_CAJEROS" NUMBER(2,0), 
	"DIRECTOR" VARCHAR2(20 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table BAN_TRANSFER
--------------------------------------------------------

  CREATE TABLE "BAN_TRANSFER" 
   (	"ID_TRANSFER" NUMBER(15,0), 
	"ID_ENT_ORIGI" NUMBER(4,0), 
	"ID_SUCL_ORIG" NUMBER(4,0), 
	"ID_N_CUENTA_ORIG" NUMBER(10,0), 
	"ID_ENTIDAD_DEST" NUMBER(4,0), 
	"ID_SUCURSAL_DEST" NUMBER(4,0), 
	"ID_N_CUENTA_DEST" NUMBER(10,0), 
	"FECHA" DATE, 
	"IMPORTE" NUMBER(10,2), 
	"CONCEPTO" VARCHAR2(20 BYTE), 
	"BENEFICIARIO" VARCHAR2(20 BYTE)
   ) ;
REM INSERTING into BAN_CLIENTES
SET DEFINE OFF;
REM INSERTING into BAN_CUENTA
SET DEFINE OFF;
REM INSERTING into BAN_ENTIDAD
SET DEFINE OFF;
REM INSERTING into BAN_SUCURSAL
SET DEFINE OFF;
REM INSERTING into BAN_TRANSFER
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index BAN_CLIENTES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BAN_CLIENTES_PK" ON "BAN_CLIENTES" ("ID_CLIENTE") 
  ;
--------------------------------------------------------
--  DDL for Index BAN_CUENTA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BAN_CUENTA_PK" ON "BAN_CUENTA" ("ID_ENTIDAD", "ID_SUCURSAL", "ID_N_CUENTA") 
  ;
--------------------------------------------------------
--  DDL for Index BAN_ENTIDAD_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BAN_ENTIDAD_PK" ON "BAN_ENTIDAD" ("ID_ENTIDAD") 
  ;
--------------------------------------------------------
--  DDL for Index BAN_SUCURSAL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BAN_SUCURSAL_PK" ON "BAN_SUCURSAL" ("BAN_ENTIDAD_ID_ENTIDAD", "ID_SUCURSAL") 
  ;
--------------------------------------------------------
--  DDL for Index BAN_TRANSFER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BAN_TRANSFER_PK" ON "BAN_TRANSFER" ("ID_TRANSFER") 
  ;
--------------------------------------------------------
--  Constraints for Table BAN_CLIENTES
--------------------------------------------------------

  ALTER TABLE "BAN_CLIENTES" ADD CONSTRAINT "BAN_CLIENTES_PK" PRIMARY KEY ("ID_CLIENTE") ENABLE;
  ALTER TABLE "BAN_CLIENTES" MODIFY ("FECHA_NACIMIENTO" NOT NULL ENABLE);
  ALTER TABLE "BAN_CLIENTES" MODIFY ("APELLIDOS" NOT NULL ENABLE);
  ALTER TABLE "BAN_CLIENTES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "BAN_CLIENTES" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BAN_CUENTA
--------------------------------------------------------

  ALTER TABLE "BAN_CUENTA" ADD CONSTRAINT "BAN_CUENTA_PK" PRIMARY KEY ("ID_ENTIDAD", "ID_SUCURSAL", "ID_N_CUENTA") ENABLE;
  ALTER TABLE "BAN_CUENTA" MODIFY ("SALDO" NOT NULL ENABLE);
  ALTER TABLE "BAN_CUENTA" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "BAN_CUENTA" MODIFY ("ID_N_CUENTA" NOT NULL ENABLE);
  ALTER TABLE "BAN_CUENTA" MODIFY ("ID_SUCURSAL" NOT NULL ENABLE);
  ALTER TABLE "BAN_CUENTA" MODIFY ("ID_ENTIDAD" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BAN_ENTIDAD
--------------------------------------------------------

  ALTER TABLE "BAN_ENTIDAD" ADD CONSTRAINT "BAN_ENTIDAD_PK" PRIMARY KEY ("ID_ENTIDAD") ENABLE;
  ALTER TABLE "BAN_ENTIDAD" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "BAN_ENTIDAD" MODIFY ("ID_ENTIDAD" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BAN_SUCURSAL
--------------------------------------------------------

  ALTER TABLE "BAN_SUCURSAL" ADD CONSTRAINT "BAN_SUCURSAL_PK" PRIMARY KEY ("BAN_ENTIDAD_ID_ENTIDAD", "ID_SUCURSAL") ENABLE;
  ALTER TABLE "BAN_SUCURSAL" MODIFY ("DIRECTOR" NOT NULL ENABLE);
  ALTER TABLE "BAN_SUCURSAL" MODIFY ("NUM_CAJEROS" NOT NULL ENABLE);
  ALTER TABLE "BAN_SUCURSAL" MODIFY ("DIRECCION" NOT NULL ENABLE);
  ALTER TABLE "BAN_SUCURSAL" MODIFY ("CIUDAD" NOT NULL ENABLE);
  ALTER TABLE "BAN_SUCURSAL" MODIFY ("ID_SUCURSAL" NOT NULL ENABLE);
  ALTER TABLE "BAN_SUCURSAL" MODIFY ("BAN_ENTIDAD_ID_ENTIDAD" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BAN_TRANSFER
--------------------------------------------------------

  ALTER TABLE "BAN_TRANSFER" ADD CONSTRAINT "BAN_TRANSFER_PK" PRIMARY KEY ("ID_TRANSFER") ENABLE;
  ALTER TABLE "BAN_TRANSFER" ADD CONSTRAINT "BAN_TRANSFER_IMPORTE_CHK" CHECK ( importe > 0 ) ENABLE;
  ALTER TABLE "BAN_TRANSFER" MODIFY ("IMPORTE" NOT NULL ENABLE);
  ALTER TABLE "BAN_TRANSFER" MODIFY ("ID_N_CUENTA_DEST" NOT NULL ENABLE);
  ALTER TABLE "BAN_TRANSFER" MODIFY ("ID_SUCURSAL_DEST" NOT NULL ENABLE);
  ALTER TABLE "BAN_TRANSFER" MODIFY ("ID_ENTIDAD_DEST" NOT NULL ENABLE);
  ALTER TABLE "BAN_TRANSFER" MODIFY ("ID_N_CUENTA_ORIG" NOT NULL ENABLE);
  ALTER TABLE "BAN_TRANSFER" MODIFY ("ID_SUCL_ORIG" NOT NULL ENABLE);
  ALTER TABLE "BAN_TRANSFER" MODIFY ("ID_ENT_ORIGI" NOT NULL ENABLE);
  ALTER TABLE "BAN_TRANSFER" MODIFY ("ID_TRANSFER" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table BAN_CUENTA
--------------------------------------------------------

  ALTER TABLE "BAN_CUENTA" ADD CONSTRAINT "BAN_CUEN_BAN_CLIEN_FK" FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "BAN_CLIENTES" ("ID_CLIENTE") ENABLE;
  ALTER TABLE "BAN_CUENTA" ADD CONSTRAINT "BAN_CUEN_BAN_SUC_FK" FOREIGN KEY ("ID_ENTIDAD", "ID_SUCURSAL")
	  REFERENCES "BAN_SUCURSAL" ("BAN_ENTIDAD_ID_ENTIDAD", "ID_SUCURSAL") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BAN_SUCURSAL
--------------------------------------------------------

  ALTER TABLE "BAN_SUCURSAL" ADD CONSTRAINT "BAN_SUC_BAN_ENT_FK" FOREIGN KEY ("BAN_ENTIDAD_ID_ENTIDAD")
	  REFERENCES "BAN_ENTIDAD" ("ID_ENTIDAD") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BAN_TRANSFER
--------------------------------------------------------

  ALTER TABLE "BAN_TRANSFER" ADD CONSTRAINT "BAN_TRANSFER_FKV2" FOREIGN KEY ("ID_ENT_ORIGI", "ID_SUCL_ORIG", "ID_N_CUENTA_ORIG")
	  REFERENCES "BAN_CUENTA" ("ID_ENTIDAD", "ID_SUCURSAL", "ID_N_CUENTA") ENABLE;
  ALTER TABLE "BAN_TRANSFER" ADD CONSTRAINT "BAN_TRANSF_FK" FOREIGN KEY ("ID_ENTIDAD_DEST", "ID_SUCURSAL_DEST", "ID_N_CUENTA_DEST")
	  REFERENCES "BAN_CUENTA" ("ID_ENTIDAD", "ID_SUCURSAL", "ID_N_CUENTA") ENABLE;
