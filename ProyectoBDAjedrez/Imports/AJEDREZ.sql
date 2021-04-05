-- USER SQL
CREATE USER prueba IDENTIFIED BY "prueba"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

-- ROLES
GRANT "CONNECT" TO prueba WITH ADMIN OPTION;
GRANT "RESOURCE" TO prueba WITH ADMIN OPTION;
ALTER USER prueba DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES
GRANT UNLIMITED TABLESPACE TO prueba WITH ADMIN OPTION;
GRANT CREATE ANY PROCEDURE TO prueba WITH ADMIN OPTION;
GRANT CREATE ANY TRIGGER TO prueba WITH ADMIN OPTION;
GRANT CREATE ANY VIEW TO prueba WITH ADMIN OPTION;

ALTER SESSION SET NLS_LANGUAGE= 'ENGLISH';
--------------------------------------------------------
-- Archivo creado  - jueves-abril-25-2019   
--------------------------------------------------------
drop table ARBITROS cascade constraints;
drop table CLUBES cascade constraints;
drop table ELIMINATORIAS cascade constraints;
drop table JUGADORES cascade constraints;
drop table LIGAS cascade constraints;
drop table PARTICIPANTES cascade constraints;
drop table PARTIDAS cascade constraints;
drop table PATRO_TOR cascade constraints;
drop table PATROCINADORES cascade constraints;
drop table RANKINGS cascade constraints;
drop table SUIZOS cascade constraints;
drop table TORNEOS cascade constraints;

--------------------------------------------------------
--  DDL for Table ARBITROS
--------------------------------------------------------

  CREATE TABLE "ARBITROS" 
   (	"ID_ARBITRO" CHAR(4 BYTE), 
	"DNI" CHAR(9 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"TELEFONO" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table CLUBES
--------------------------------------------------------

  CREATE TABLE "CLUBES" 
   (	"ID_CLUB" CHAR(3 BYTE), 
	"ID_JUG_LIDER" CHAR(3 BYTE), 
	"NOM_CLUB" VARCHAR2(30 BYTE), 
	"N_INTEGRANTES" NUMBER(5,0), 
	"FECHA_CREAC" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table ELIMINATORIAS
--------------------------------------------------------

  CREATE TABLE "ELIMINATORIAS" 
   (	"ID_TORNEO" CHAR(4 BYTE), 
	"NUM_EMPAREJAMIENTOS" NUMBER(5,0), 
	"PLAY-OFFS" CHAR(1 BYTE), 
	"PRORROGA" CHAR(1 BYTE), 
	"REPETICION" CHAR(1 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table JUGADORES
--------------------------------------------------------

  CREATE TABLE "JUGADORES" 
   (	"ID_JUGADOR" CHAR(3 BYTE), 
	"ID_CLUB" CHAR(3 BYTE), 
	"ID_RANKING" CHAR(5 BYTE), 
	"NOMBRE" VARCHAR2(30 BYTE), 
	"APELLIDO" VARCHAR2(30 BYTE), 
	"CP" NUMBER(8,0), 
	"EMAIL" VARCHAR2(40 BYTE), 
	"FECH_NACI" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table LIGAS
--------------------------------------------------------

  CREATE TABLE "LIGAS" 
   (	"ID_TORNEO" CHAR(4 BYTE), 
	"PATRON_DESEMP" CHAR(1 BYTE), 
	"DIF__PIEZAS_RESTANTES" CHAR(1 BYTE), 
	"NUM__MOVIMIENTOS" CHAR(1 BYTE), 
	"DIF_PIEZAS_EMPAT" CHAR(1 BYTE), 
	"NUM._MOV._EMPAT" CHAR(1 BYTE), 
	"SORTEO" CHAR(1 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PARTICIPANTES
--------------------------------------------------------

  CREATE TABLE "PARTICIPANTES" 
   (	"ID_TORNEO" CHAR(4 BYTE), 
	"ID_JUGADOR" CHAR(3 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PARTIDAS
--------------------------------------------------------

  CREATE TABLE "PARTIDAS" 
   (	"ID_TORNEO" CHAR(4 BYTE), 
	"ID_JUGADOR_1" CHAR(3 BYTE), 
	"ID_JUGADOR_2" CHAR(3 BYTE), 
	"ID_ARBITRO" CHAR(4 BYTE), 
	"FECH_PART" DATE, 
	"RESULTADO" CHAR(15 BYTE)
   ) ;

   COMMENT ON COLUMN "PARTIDAS"."RESULTADO" IS 'Si es 1, gana jugador 1, si es 2 gana jugador dos, y si es 0 es empate.';
--------------------------------------------------------
--  DDL for Table PATROCINADORES
--------------------------------------------------------

  CREATE TABLE "PATROCINADORES" 
   (	"ID_PATRO" CHAR(4 BYTE), 
	"NOM_PATRO" VARCHAR2(30 BYTE), 
	"TELEFONO" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PATRO_TOR
--------------------------------------------------------

  CREATE TABLE "PATRO_TOR" 
   (	"ID_TORNEO" CHAR(4 BYTE), 
	"ID_PATRO" CHAR(4 BYTE), 
	"SUBVENCION" NUMBER(8,2)
   ) ;
--------------------------------------------------------
--  DDL for Table RANKINGS
--------------------------------------------------------

  CREATE TABLE "RANKINGS" 
   (	"ID_RANKING" CHAR(5 BYTE), 
	"DESCRIPCION" VARCHAR2(100 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table SUIZOS
--------------------------------------------------------

  CREATE TABLE "SUIZOS" 
   (	"ID_TORNEO" CHAR(4 BYTE), 
	"NUM_RONDAS" NUMBER(5,0), 
	"RELAMPAGO" CHAR(1 BYTE), 
	"DURACION" NUMBER(6,2)
   ) ;
--------------------------------------------------------
--  DDL for Table TORNEOS
--------------------------------------------------------

  CREATE TABLE "TORNEOS" 
   (	"ID_TORNEO" CHAR(4 BYTE), 
	"ID_RANK_TOUR" CHAR(5 BYTE), 
	"ID_CLUB_ORG" CHAR(3 BYTE), 
	"PRER_TORNEO" CHAR(4 BYTE), 
	"NOM_TORNEO" VARCHAR2(30 BYTE), 
	"TIPO_TORNEO" CHAR(1 BYTE), 
	"FECH_INICIO" DATE, 
	"FECH_FIN" DATE
   ) ;

--------------------------------------------------------
--  DDL for Index ARBITROS_DNI_UN
--------------------------------------------------------

  CREATE UNIQUE INDEX "ARBITROS_DNI_UN" ON "ARBITROS" ("DNI") 
  ;
--------------------------------------------------------
--  DDL for Index ARBITROS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ARBITROS_PK" ON "ARBITROS" ("ID_ARBITRO") 
  ;
--------------------------------------------------------
--  DDL for Index CLUBES__IDX
--------------------------------------------------------

  CREATE UNIQUE INDEX "CLUBES__IDX" ON "CLUBES" ("ID_JUG_LIDER") 
  ;
--------------------------------------------------------
--  DDL for Index CLUBES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CLUBES_PK" ON "CLUBES" ("ID_CLUB") 
  ;
--------------------------------------------------------
--  DDL for Index ELIMINATORIAS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ELIMINATORIAS_PK" ON "ELIMINATORIAS" ("ID_TORNEO") 
  ;
--------------------------------------------------------
--  DDL for Index JUGADORES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUGADORES_PK" ON "JUGADORES" ("ID_JUGADOR") 
  ;
--------------------------------------------------------
--  DDL for Index LIGAS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIGAS_PK" ON "LIGAS" ("ID_TORNEO") 
  ;
--------------------------------------------------------
--  DDL for Index PARTICIPANTES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PARTICIPANTES_PK" ON "PARTICIPANTES" ("ID_TORNEO", "ID_JUGADOR") 
  ;
--------------------------------------------------------
--  DDL for Index PARTIDAS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PARTIDAS_PK" ON "PARTIDAS" ("ID_TORNEO", "ID_JUGADOR_1", "ID_JUGADOR_2") 
  ;
--------------------------------------------------------
--  DDL for Index PATROCINADORES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PATROCINADORES_PK" ON "PATROCINADORES" ("ID_PATRO") 
  ;
--------------------------------------------------------
--  DDL for Index PATRO_TOR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PATRO_TOR_PK" ON "PATRO_TOR" ("ID_TORNEO", "ID_PATRO") 
  ;
--------------------------------------------------------
--  DDL for Index RANKINGS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "RANKINGS_PK" ON "RANKINGS" ("ID_RANKING") 
  ;
--------------------------------------------------------
--  DDL for Index SUIZOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SUIZOS_PK" ON "SUIZOS" ("ID_TORNEO") 
  ;
--------------------------------------------------------
--  DDL for Index TORNEOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "TORNEOS_PK" ON "TORNEOS" ("ID_TORNEO") 
  ;
--------------------------------------------------------
--  Constraints for Table ARBITROS
--------------------------------------------------------

  ALTER TABLE "ARBITROS" ADD CONSTRAINT "ARBITROS_DNI_UN" UNIQUE ("DNI") ENABLE;
  ALTER TABLE "ARBITROS" ADD CONSTRAINT "ARBITROS_PK" PRIMARY KEY ("ID_ARBITRO") ENABLE;
  ALTER TABLE "ARBITROS" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "ARBITROS" MODIFY ("ID_ARBITRO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CLUBES
--------------------------------------------------------

  ALTER TABLE "CLUBES" ADD CONSTRAINT "CLUBES_PK" PRIMARY KEY ("ID_CLUB") ENABLE;
  ALTER TABLE "CLUBES" MODIFY ("N_INTEGRANTES" NOT NULL ENABLE);
  ALTER TABLE "CLUBES" MODIFY ("ID_CLUB" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ELIMINATORIAS
--------------------------------------------------------

  ALTER TABLE "ELIMINATORIAS" ADD CONSTRAINT "ELIMINATORIAS_CHK1" CHECK (("PLAY-OFFS" = 'Y' OR "PLAY-OFFS" = 'N') AND
("PLAY-OFFS" = 'N' and PRORROGA is null AND REPETICION is null) or ("PLAY-OFFS"= 'Y' and PRORROGA is not null OR REPETICION is not null)
AND
(PRORROGA = 'V' OR PRORROGA = 'F') AND (REPETICION = 'V' OR REPETICION = 'F')) ENABLE;
  ALTER TABLE "ELIMINATORIAS" ADD CONSTRAINT "ELIMINATORIAS_PK" PRIMARY KEY ("ID_TORNEO") ENABLE;
  ALTER TABLE "ELIMINATORIAS" MODIFY ("PLAY-OFFS" NOT NULL ENABLE);
  ALTER TABLE "ELIMINATORIAS" MODIFY ("NUM_EMPAREJAMIENTOS" NOT NULL ENABLE);
  ALTER TABLE "ELIMINATORIAS" MODIFY ("ID_TORNEO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table JUGADORES
--------------------------------------------------------

  ALTER TABLE "JUGADORES" ADD CONSTRAINT "JUG_EMAIL_CHK" CHECK (EMAIL LIKE '%@%.__' OR
EMAIL LIKE '%@%.___') ENABLE;
  ALTER TABLE "JUGADORES" ADD CONSTRAINT "JUGADORES_PK" PRIMARY KEY ("ID_JUGADOR") ENABLE;
  ALTER TABLE "JUGADORES" MODIFY ("ID_RANKING" NOT NULL ENABLE);
  ALTER TABLE "JUGADORES" MODIFY ("ID_CLUB" NOT NULL ENABLE);
  ALTER TABLE "JUGADORES" MODIFY ("ID_JUGADOR" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LIGAS
--------------------------------------------------------

  ALTER TABLE "LIGAS" ADD CONSTRAINT "LIGA_CHECK" CHECK ((PATRON_DESEMP = 'Y' OR PATRON_DESEMP = 'N') AND
(PATRON_DESEMP = 'N' and DIF__PIEZAS_RESTANTES is null AND NUM__MOVIMIENTOS is null AND DIF_PIEZAS_EMPAT is null AND "NUM._MOV._EMPAT" is null AND SORTEO is null) 
or 
(PATRON_DESEMP= 'Y' and DIF__PIEZAS_RESTANTES is not null OR NUM__MOVIMIENTOS is not null OR DIF_PIEZAS_EMPAT is not null OR "NUM._MOV._EMPAT" is not null OR SORTEO is null)
AND
(DIF__PIEZAS_RESTANTES = 'V' OR DIF__PIEZAS_RESTANTES = 'F') AND (NUM__MOVIMIENTOS = 'V' OR NUM__MOVIMIENTOS = 'F')
AND (DIF_PIEZAS_EMPAT = 'V' OR DIF_PIEZAS_EMPAT = 'F')
AND ("NUM._MOV._EMPAT" = 'V' OR "NUM._MOV._EMPAT" = 'F')
AND (SORTEO = 'V' OR SORTEO = 'F')) ENABLE;
  ALTER TABLE "LIGAS" ADD CONSTRAINT "LIGAS_CHK1" CHECK ((PATRON_DESEMP = 'Y' OR PATRON_DESEMP = 'N') AND
(PATRON_DESEMP = 'N' and DIF__PIEZAS_RESTANTES is null AND NUM__MOVIMIENTOS is null AND DIF_PIEZAS_EMPAT is null AND "NUM._MOV._EMPAT" is null AND SORTEO is null)
 or
 (PATRON_DESEMP= 'Y' and DIF__PIEZAS_RESTANTES is not null OR NUM__MOVIMIENTOS is not null OR DIF_PIEZAS_EMPAT is not null OR "NUM._MOV._EMPAT" is not null OR SORTEO is not null)) ENABLE;
  ALTER TABLE "LIGAS" ADD CONSTRAINT "LIGAS_PK" PRIMARY KEY ("ID_TORNEO") ENABLE;
  ALTER TABLE "LIGAS" MODIFY ("PATRON_DESEMP" NOT NULL ENABLE);
  ALTER TABLE "LIGAS" MODIFY ("ID_TORNEO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PARTICIPANTES
--------------------------------------------------------

  ALTER TABLE "PARTICIPANTES" ADD CONSTRAINT "PARTICIPANTES_PK" PRIMARY KEY ("ID_TORNEO", "ID_JUGADOR") ENABLE;
  ALTER TABLE "PARTICIPANTES" MODIFY ("ID_JUGADOR" NOT NULL ENABLE);
  ALTER TABLE "PARTICIPANTES" MODIFY ("ID_TORNEO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PARTIDAS
--------------------------------------------------------

  ALTER TABLE "PARTIDAS" ADD CONSTRAINT "PAR_RES_CHK1" CHECK (RESULTADO = '1' OR RESULTADO = '2' OR RESULTADO = '0') ENABLE;
  ALTER TABLE "PARTIDAS" ADD CONSTRAINT "PARTIDAS_PK" PRIMARY KEY ("ID_TORNEO", "ID_JUGADOR_1", "ID_JUGADOR_2") ENABLE;
  ALTER TABLE "PARTIDAS" MODIFY ("ID_ARBITRO" NOT NULL ENABLE);
  ALTER TABLE "PARTIDAS" MODIFY ("ID_JUGADOR_2" NOT NULL ENABLE);
  ALTER TABLE "PARTIDAS" MODIFY ("ID_JUGADOR_1" NOT NULL ENABLE);
  ALTER TABLE "PARTIDAS" MODIFY ("ID_TORNEO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PATROCINADORES
--------------------------------------------------------

  ALTER TABLE "PATROCINADORES" ADD CONSTRAINT "PATROCINADORES_PK" PRIMARY KEY ("ID_PATRO") ENABLE;
  ALTER TABLE "PATROCINADORES" MODIFY ("ID_PATRO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PATRO_TOR
--------------------------------------------------------

  ALTER TABLE "PATRO_TOR" ADD CONSTRAINT "PATRO_TOR_PK" PRIMARY KEY ("ID_TORNEO", "ID_PATRO") ENABLE;
  ALTER TABLE "PATRO_TOR" MODIFY ("SUBVENCION" NOT NULL ENABLE);
  ALTER TABLE "PATRO_TOR" MODIFY ("ID_PATRO" NOT NULL ENABLE);
  ALTER TABLE "PATRO_TOR" MODIFY ("ID_TORNEO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table RANKINGS
--------------------------------------------------------

  ALTER TABLE "RANKINGS" ADD CONSTRAINT "RANKINGS_PK" PRIMARY KEY ("ID_RANKING") ENABLE;
  ALTER TABLE "RANKINGS" MODIFY ("ID_RANKING" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SUIZOS
--------------------------------------------------------

  ALTER TABLE "SUIZOS" ADD CONSTRAINT "SUIZOS_CHK1" CHECK ((RELAMPAGO = 'Y' OR RELAMPAGO = 'N') AND
(RELAMPAGO = 'N' and DURACION is null) or (RELAMPAGO= 'Y' and DURACION is not null) ) ENABLE;
  ALTER TABLE "SUIZOS" ADD CONSTRAINT "SUIZOS_PK" PRIMARY KEY ("ID_TORNEO") ENABLE;
  ALTER TABLE "SUIZOS" MODIFY ("RELAMPAGO" NOT NULL ENABLE);
  ALTER TABLE "SUIZOS" MODIFY ("NUM_RONDAS" NOT NULL ENABLE);
  ALTER TABLE "SUIZOS" MODIFY ("ID_TORNEO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TORNEOS
--------------------------------------------------------

  ALTER TABLE "TORNEOS" ADD CONSTRAINT "TOR_FECH_CHK" CHECK (FECH_INICIO < FECH_FIN) ENABLE;
  ALTER TABLE "TORNEOS" ADD CONSTRAINT "TORNEOS_PK" PRIMARY KEY ("ID_TORNEO") ENABLE;
  ALTER TABLE "TORNEOS" MODIFY ("TIPO_TORNEO" NOT NULL ENABLE);
  ALTER TABLE "TORNEOS" MODIFY ("ID_CLUB_ORG" NOT NULL ENABLE);
  ALTER TABLE "TORNEOS" MODIFY ("ID_RANK_TOUR" NOT NULL ENABLE);
  ALTER TABLE "TORNEOS" MODIFY ("ID_TORNEO" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table CLUBES
--------------------------------------------------------

  ALTER TABLE "CLUBES" ADD CONSTRAINT "CLUB_JUG_FK" FOREIGN KEY ("ID_JUG_LIDER")
	  REFERENCES "JUGADORES" ("ID_JUGADOR") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ELIMINATORIAS
--------------------------------------------------------

  ALTER TABLE "ELIMINATORIAS" ADD CONSTRAINT "ELIM_TOR_FK" FOREIGN KEY ("ID_TORNEO")
	  REFERENCES "TORNEOS" ("ID_TORNEO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table JUGADORES
--------------------------------------------------------

  ALTER TABLE "JUGADORES" ADD CONSTRAINT "JUG_CLUB_FK" FOREIGN KEY ("ID_CLUB")
	  REFERENCES "CLUBES" ("ID_CLUB") ENABLE;
  ALTER TABLE "JUGADORES" ADD CONSTRAINT "JUG_RANK_FK" FOREIGN KEY ("ID_RANKING")
	  REFERENCES "RANKINGS" ("ID_RANKING") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table LIGAS
--------------------------------------------------------

  ALTER TABLE "LIGAS" ADD CONSTRAINT "LIGAS_TOR_FK" FOREIGN KEY ("ID_TORNEO")
	  REFERENCES "TORNEOS" ("ID_TORNEO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PARTICIPANTES
--------------------------------------------------------

  ALTER TABLE "PARTICIPANTES" ADD CONSTRAINT "PARTI_JUG_FK" FOREIGN KEY ("ID_JUGADOR")
	  REFERENCES "JUGADORES" ("ID_JUGADOR") ENABLE;
  ALTER TABLE "PARTICIPANTES" ADD CONSTRAINT "PARTI_TORN_FK" FOREIGN KEY ("ID_TORNEO")
	  REFERENCES "TORNEOS" ("ID_TORNEO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PARTIDAS
--------------------------------------------------------

  ALTER TABLE "PARTIDAS" ADD CONSTRAINT "PARTI_ARBIT_FK" FOREIGN KEY ("ID_ARBITRO")
	  REFERENCES "ARBITROS" ("ID_ARBITRO") ENABLE;
  ALTER TABLE "PARTIDAS" ADD CONSTRAINT "PARTI_PARTIC_FK" FOREIGN KEY ("ID_TORNEO", "ID_JUGADOR_1")
	  REFERENCES "PARTICIPANTES" ("ID_TORNEO", "ID_JUGADOR") ENABLE;
  ALTER TABLE "PARTIDAS" ADD CONSTRAINT "PARTI_PARTIC_FKV2" FOREIGN KEY ("ID_TORNEO", "ID_JUGADOR_2")
	  REFERENCES "PARTICIPANTES" ("ID_TORNEO", "ID_JUGADOR") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PATRO_TOR
--------------------------------------------------------

  ALTER TABLE "PATRO_TOR" ADD CONSTRAINT "PATRO_TOR_PAT_FK" FOREIGN KEY ("ID_PATRO")
	  REFERENCES "PATROCINADORES" ("ID_PATRO") ENABLE;
  ALTER TABLE "PATRO_TOR" ADD CONSTRAINT "PATRO_TOR_TORN_FK" FOREIGN KEY ("ID_TORNEO")
	  REFERENCES "TORNEOS" ("ID_TORNEO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SUIZOS
--------------------------------------------------------

  ALTER TABLE "SUIZOS" ADD CONSTRAINT "SUIZOS_TORNEOS_FK" FOREIGN KEY ("ID_TORNEO")
	  REFERENCES "TORNEOS" ("ID_TORNEO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table TORNEOS
--------------------------------------------------------

  ALTER TABLE "TORNEOS" ADD CONSTRAINT "TORN_CLUB_FK" FOREIGN KEY ("ID_CLUB_ORG")
	  REFERENCES "CLUBES" ("ID_CLUB") ENABLE;
  ALTER TABLE "TORNEOS" ADD CONSTRAINT "TOR_RANK_FK" FOREIGN KEY ("ID_RANK_TOUR")
	  REFERENCES "RANKINGS" ("ID_RANKING") ENABLE;
  ALTER TABLE "TORNEOS" ADD CONSTRAINT "TOR_TORN_FK" FOREIGN KEY ("PRER_TORNEO")
	  REFERENCES "TORNEOS" ("ID_TORNEO") ENABLE;
