--------------------------------------------------------
-- Archivo creado  - lunes-noviembre-19-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table F_CLUBES
--------------------------------------------------------

  CREATE TABLE "F_CLUBES" 
   (	"ID_CLUB" CHAR(4 BYTE), 
	"NOM_CLUB" VARCHAR2(30 BYTE), 
	"F_CREACION" DATE, 
	"ESTADIO" VARCHAR2(20 BYTE), 
	"COSTE_CLUB" NUMBER(9,2)
   ) ;
--------------------------------------------------------
--  DDL for Table F_JUGADORES
--------------------------------------------------------

  CREATE TABLE "F_JUGADORES" 
   (	"N_FEDERACION" CHAR(10 BYTE), 
	"ID_CLUB" CHAR(4 BYTE), 
	"DNI" CHAR(9 BYTE), 
	"PRECIO_JUG" NUMBER(11,2), 
	"F_NACIMIENTO" DATE, 
	"N_CAMISETA" NUMBER(2,0)
   ) ;
--------------------------------------------------------
--  DDL for Table F_TRASPASOS
--------------------------------------------------------

  CREATE TABLE "F_TRASPASOS" 
   (	"ID_TRASPASO" VARCHAR2(20 BYTE), 
	"N_FEDERACION" CHAR(10 BYTE), 
	"ID_CLUB_SALIDA" CHAR(4 BYTE), 
	"ID_CLUB_LLEGADA" CHAR(4 BYTE), 
	"FEC_TRASPASO" DATE
   ) ;
REM INSERTING into F_CLUBES
SET DEFINE OFF;
REM INSERTING into F_JUGADORES
SET DEFINE OFF;
REM INSERTING into F_TRASPASOS
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index F_CLUBES_NOM_CLUB_UN
--------------------------------------------------------

  CREATE UNIQUE INDEX "F_CLUBES_NOM_CLUB_UN" ON "F_CLUBES" ("NOM_CLUB") 
  ;
--------------------------------------------------------
--  DDL for Index F_CLUBES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "F_CLUBES_PK" ON "F_CLUBES" ("ID_CLUB") 
  ;
--------------------------------------------------------
--  DDL for Index F_JUGADORES_NOMBRE_UN
--------------------------------------------------------

  CREATE UNIQUE INDEX "F_JUGADORES_NOMBRE_UN" ON "F_JUGADORES" ("DNI") 
  ;
--------------------------------------------------------
--  DDL for Index F_JUGADORES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "F_JUGADORES_PK" ON "F_JUGADORES" ("N_FEDERACION") 
  ;
--------------------------------------------------------
--  DDL for Index F_TRASPASOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "F_TRASPASOS_PK" ON "F_TRASPASOS" ("ID_TRASPASO") 
  ;
--------------------------------------------------------
--  Constraints for Table F_CLUBES
--------------------------------------------------------

  ALTER TABLE "F_CLUBES" ADD CONSTRAINT "F_CLUBES_NOM_CLUB_UN" UNIQUE ("NOM_CLUB") ENABLE;
  ALTER TABLE "F_CLUBES" ADD CONSTRAINT "F_CLUBES_PK" PRIMARY KEY ("ID_CLUB") ENABLE;
  ALTER TABLE "F_CLUBES" MODIFY ("NOM_CLUB" NOT NULL ENABLE);
  ALTER TABLE "F_CLUBES" MODIFY ("ID_CLUB" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table F_JUGADORES
--------------------------------------------------------

  ALTER TABLE "F_JUGADORES" ADD CONSTRAINT "F_JUGADORES_NOMBRE_UN" UNIQUE ("DNI") ENABLE;
  ALTER TABLE "F_JUGADORES" ADD CONSTRAINT "F_JUGADORES_PK" PRIMARY KEY ("N_FEDERACION") ENABLE;
  ALTER TABLE "F_JUGADORES" MODIFY ("PRECIO_JUG" NOT NULL ENABLE);
  ALTER TABLE "F_JUGADORES" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "F_JUGADORES" MODIFY ("ID_CLUB" NOT NULL ENABLE);
  ALTER TABLE "F_JUGADORES" MODIFY ("N_FEDERACION" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table F_TRASPASOS
--------------------------------------------------------

  ALTER TABLE "F_TRASPASOS" ADD CONSTRAINT "F_TRASPASOS_PK" PRIMARY KEY ("ID_TRASPASO") ENABLE;
  ALTER TABLE "F_TRASPASOS" MODIFY ("ID_CLUB_LLEGADA" NOT NULL ENABLE);
  ALTER TABLE "F_TRASPASOS" MODIFY ("ID_CLUB_SALIDA" NOT NULL ENABLE);
  ALTER TABLE "F_TRASPASOS" MODIFY ("N_FEDERACION" NOT NULL ENABLE);
  ALTER TABLE "F_TRASPASOS" MODIFY ("ID_TRASPASO" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table F_JUGADORES
--------------------------------------------------------

  ALTER TABLE "F_JUGADORES" ADD CONSTRAINT "F_JUGADORES_F_CLUBES_FK" FOREIGN KEY ("ID_CLUB")
	  REFERENCES "F_CLUBES" ("ID_CLUB") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table F_TRASPASOS
--------------------------------------------------------

  ALTER TABLE "F_TRASPASOS" ADD CONSTRAINT "F_TRAS_F_CLUBES_FK" FOREIGN KEY ("ID_CLUB_LLEGADA")
	  REFERENCES "F_CLUBES" ("ID_CLUB") ENABLE;
  ALTER TABLE "F_TRASPASOS" ADD CONSTRAINT "F_TRAS_F_CLUBES_FKV2" FOREIGN KEY ("ID_CLUB_SALIDA")
	  REFERENCES "F_CLUBES" ("ID_CLUB") ENABLE;
  ALTER TABLE "F_TRASPASOS" ADD CONSTRAINT "F_TRAS_F_JUGADORES_FK" FOREIGN KEY ("N_FEDERACION")
	  REFERENCES "F_JUGADORES" ("N_FEDERACION") ENABLE;
