--------------------------------------------------------
-- Archivo creado  - lunes-noviembre-19-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TR_OFICINA
--------------------------------------------------------

  CREATE TABLE "TR_OFICINA" 
   (	"ID_OFICINA" VARCHAR2(3 BYTE), 
	"DIRECCION" VARCHAR2(20 BYTE), 
	"TELEFONO" NUMBER(9,0), 
	"HORARIO" VARCHAR2(20 BYTE), 
	"F_INICIO_ACT" DATE, 
	"SUPERFICIE" NUMBER(5,1), 
	"PRESUPUESTO" NUMBER(7,0)
   ) ;
--------------------------------------------------------
--  DDL for Table TR_SOLICITUD
--------------------------------------------------------

  CREATE TABLE "TR_SOLICITUD" 
   (	"ID_SOLICITUD" VARCHAR2(20 BYTE), 
	"ID_OFI_ENTREG" VARCHAR2(3 BYTE), 
	"FECHA_SOLICITUD" DATE, 
	"ID_TRASNP_ENTREG" VARCHAR2(9 BYTE), 
	"ID_TRASNP_RECOG" VARCHAR2(9 BYTE), 
	"ID_OFI_RECOG" VARCHAR2(3 BYTE), 
	"TIPO" VARCHAR2(20 BYTE), 
	"DESTINATARIO" VARCHAR2(20 BYTE), 
	"PRODUCTO" VARCHAR2(20 BYTE), 
	"PRECIO" NUMBER(7,2)
   ) ;
--------------------------------------------------------
--  DDL for Table TR_TRANSPORTISTAS
--------------------------------------------------------

  CREATE TABLE "TR_TRANSPORTISTAS" 
   (	"ID_TRASNPORTISTA" VARCHAR2(9 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"PRECIO_MEDIO" NUMBER(7,2), 
	"PESO_MAX" NUMBER(6,1), 
	"ID_OFI_RECOG" VARCHAR2(3 BYTE), 
	"ID_OFI_ENTREG" VARCHAR2(3 BYTE)
   ) ;
REM INSERTING into TR_OFICINA
SET DEFINE OFF;
REM INSERTING into TR_SOLICITUD
SET DEFINE OFF;
REM INSERTING into TR_TRANSPORTISTAS
SET DEFINE OFF;
Insert into TR_TRANSPORTISTAS (ID_TRASNPORTISTA,NOMBRE,PRECIO_MEDIO,PESO_MAX,ID_OFI_RECOG,ID_OFI_ENTREG) values ('1D','JOSE',null,'300',null,null);
--------------------------------------------------------
--  DDL for Index TR_OFICINA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "TR_OFICINA_PK" ON "TR_OFICINA" ("ID_OFICINA") 
  ;
--------------------------------------------------------
--  DDL for Index TR_SOLICITUD_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "TR_SOLICITUD_PK" ON "TR_SOLICITUD" ("ID_SOLICITUD") 
  ;
--------------------------------------------------------
--  DDL for Index TR_TRANSPORTISTAS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "TR_TRANSPORTISTAS_PK" ON "TR_TRANSPORTISTAS" ("ID_TRASNPORTISTA") 
  ;
--------------------------------------------------------
--  Constraints for Table TR_OFICINA
--------------------------------------------------------

  ALTER TABLE "TR_OFICINA" ADD CONSTRAINT "TR_OFICINA_PK" PRIMARY KEY ("ID_OFICINA") ENABLE;
  ALTER TABLE "TR_OFICINA" MODIFY ("SUPERFICIE" NOT NULL ENABLE);
  ALTER TABLE "TR_OFICINA" MODIFY ("TELEFONO" NOT NULL ENABLE);
  ALTER TABLE "TR_OFICINA" MODIFY ("DIRECCION" NOT NULL ENABLE);
  ALTER TABLE "TR_OFICINA" MODIFY ("ID_OFICINA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TR_SOLICITUD
--------------------------------------------------------

  ALTER TABLE "TR_SOLICITUD" ADD CONSTRAINT "TR_SOLICITUD_PK" PRIMARY KEY ("ID_SOLICITUD") ENABLE;
  ALTER TABLE "TR_SOLICITUD" MODIFY ("DESTINATARIO" NOT NULL ENABLE);
  ALTER TABLE "TR_SOLICITUD" MODIFY ("ID_OFI_RECOG" NOT NULL ENABLE);
  ALTER TABLE "TR_SOLICITUD" MODIFY ("ID_TRASNP_RECOG" NOT NULL ENABLE);
  ALTER TABLE "TR_SOLICITUD" MODIFY ("ID_TRASNP_ENTREG" NOT NULL ENABLE);
  ALTER TABLE "TR_SOLICITUD" MODIFY ("FECHA_SOLICITUD" NOT NULL ENABLE);
  ALTER TABLE "TR_SOLICITUD" MODIFY ("ID_OFI_ENTREG" NOT NULL ENABLE);
  ALTER TABLE "TR_SOLICITUD" MODIFY ("ID_SOLICITUD" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TR_TRANSPORTISTAS
--------------------------------------------------------

  ALTER TABLE "TR_TRANSPORTISTAS" ADD CONSTRAINT "TR_TRANSPORTISTAS_PK" PRIMARY KEY ("ID_TRASNPORTISTA") ENABLE;
  ALTER TABLE "TR_TRANSPORTISTAS" MODIFY ("PESO_MAX" NOT NULL ENABLE);
  ALTER TABLE "TR_TRANSPORTISTAS" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "TR_TRANSPORTISTAS" MODIFY ("ID_TRASNPORTISTA" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table TR_SOLICITUD
--------------------------------------------------------

  ALTER TABLE "TR_SOLICITUD" ADD CONSTRAINT "TR_SOLI_TR_OFI_FK" FOREIGN KEY ("ID_OFI_ENTREG")
	  REFERENCES "TR_OFICINA" ("ID_OFICINA") ENABLE;
  ALTER TABLE "TR_SOLICITUD" ADD CONSTRAINT "TR_SOLI_TR_OFI_FKV2" FOREIGN KEY ("ID_OFI_RECOG")
	  REFERENCES "TR_OFICINA" ("ID_OFICINA") ENABLE;
  ALTER TABLE "TR_SOLICITUD" ADD CONSTRAINT "TR_SOLI_TR_TRANS_FK" FOREIGN KEY ("ID_TRASNP_RECOG")
	  REFERENCES "TR_TRANSPORTISTAS" ("ID_TRASNPORTISTA") ENABLE;
  ALTER TABLE "TR_SOLICITUD" ADD CONSTRAINT "TR_SOLI_TR_TRANS_FKV2" FOREIGN KEY ("ID_TRASNP_ENTREG")
	  REFERENCES "TR_TRANSPORTISTAS" ("ID_TRASNPORTISTA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table TR_TRANSPORTISTAS
--------------------------------------------------------

  ALTER TABLE "TR_TRANSPORTISTAS" ADD CONSTRAINT "TR_TRANS_TR_OFI_FK" FOREIGN KEY ("ID_OFI_RECOG")
	  REFERENCES "TR_OFICINA" ("ID_OFICINA") ENABLE;
  ALTER TABLE "TR_TRANSPORTISTAS" ADD CONSTRAINT "TR_TRANS_TR_OFI_FKV2" FOREIGN KEY ("ID_OFI_ENTREG")
	  REFERENCES "TR_OFICINA" ("ID_OFICINA") ENABLE;
