--------------------------------------------------------
--  DDL for Sequence JUGADOR
--------------------------------------------------------

   CREATE SEQUENCE  "JUGADOR"  MINVALUE 1 MAXVALUE 9999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
   
 --------------------------------------------------------
--  DDL for View ARBITRO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ARBITRO" ("ARBITRO", "EMPATE", "GANA J1", "GANA J2") AS 
  select Arbitro, sum(Empate)Empate, sum("GANA J1")"GANA J1", sum("GANA J2")"GANA J2"
         from(
         select NVL(NVL(a.id_arbitro,c.id_arbitro), b.id_arbitro) Arbitro, 
                NVL(EmpateVig,0) Empate,
                NVL(Win1Vig,0) "GANA J1",
                NVL(Win2Vig,0) "GANA J2"
            from(
                select id_arbitro, count(*)EmpateVig
                    from partidas
                    where resultado = 0
                    group by id_arbitro
                ) a
                FULL JOIN
                (
                select id_arbitro, count(*)Win2Vig
                    from partidas
                    where resultado = 2
                    group by id_arbitro
                    ) b
                    on a.id_arbitro = b.id_arbitro
                    FULL JOIN
                (
                select id_arbitro, count(*)Win1Vig
                    from partidas
                    where resultado = 1
                    group by id_arbitro
                    ) c
                    on a.id_arbitro = c.id_arbitro and b.id_arbitro = c.id_arbitro)
                    group by Arbitro
;

--------------------------------------------------------
--  DDL for Trigger HERENCIA_ELIMINATORIAS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "HERENCIA_ELIMINATORIAS" BEFORE
    INSERT OR UPDATE OF id_torneo ON eliminatorias
    FOR EACH ROW
DECLARE
    c   CHAR(1);
BEGIN
    SELECT
        a.tipo_torneo
    INTO c
    FROM
        torneos a
    WHERE
        a.id_torneo =:new.id_torneo;

    IF ( c IS NULL OR c <> 'E' ) THEN
        raise_application_error(-20223,'El campo discriminador esta vacío o no es una ''E'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/
ALTER TRIGGER "HERENCIA_ELIMINATORIAS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger HERENCIA_LIGAS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "HERENCIA_LIGAS" BEFORE
    INSERT OR UPDATE OF id_torneo ON ligas
    FOR EACH ROW
DECLARE
    e   CHAR(1);
BEGIN
    SELECT
        a.tipo_torneo
    INTO e
    FROM
        torneos a
    WHERE
        a.id_torneo =:new.id_torneo;

    IF ( e IS NULL OR e <> 'L' ) THEN
        raise_application_error(-20223,'El campo discriminador esta vacío o no es una  ''L'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/
ALTER TRIGGER "HERENCIA_LIGAS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger HERENCIA_SUIZOS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "HERENCIA_SUIZOS" BEFORE
    INSERT OR UPDATE OF id_torneo ON suizos
    FOR EACH ROW
DECLARE
    d   CHAR(1);
BEGIN
    SELECT
        a.tipo_torneo
    INTO d
    FROM
        torneos a
    WHERE
        a.id_torneo =:new.id_torneo;

    IF ( d IS NULL OR d <> 'S' ) THEN
        raise_application_error(-20223,'El campo discriminador esta vacío o no es una ''S'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/
ALTER TRIGGER "HERENCIA_SUIZOS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger PARTICIPANTES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PARTICIPANTES" 
    BEFORE INSERT OR UPDATE OF ID_JUGADOR,ID_TORNEO ON PARTICIPANTES 
    FOR EACH ROW
DECLARE
 d CHAR(5);
 e CHAR(5);
BEGIN
    SELECT a.id_rank_tour
    INTO d
        FROM TORNEOS a
        WHERE a.id_torneo=:new.id_torneo;

    SELECT b.id_ranking
        INTO  e
        FROM JUGADORES b
        WHERE b.id_jugador=:new.id_jugador;

        IF (d != e) THEN 
        raise_application_error(-20223,'Error, el jugador no puede participar en un torneo que no sea de su ranking');
        END IF;
EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;

/
ALTER TRIGGER "PARTICIPANTES" ENABLE;
--------------------------------------------------------
--  DDL for Trigger RONDA_ELIMINATORIA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "RONDA_ELIMINATORIA" 
BEFORE INSERT OR UPDATE OF ID_JUGADOR,ID_TORNEO ON PARTICIPANTES 
    FOR EACH ROW
DECLARE
 v_num_rondas numeric(5);
 v_cont_jugadores numeric(5);
 v_partic_max numeric(5);
 
BEGIN
select num_Emparejamientos
    into v_num_rondas
    from eliminatorias
    where id_torneo = :new.id_torneo;
v_partic_max := v_num_rondas*2;
    
select count(id_jugador)
    into v_cont_jugadores
    from participantes
    where id_torneo = :new.id_torneo;
    
    IF (v_partic_max <= v_cont_jugadores) then
        raise_application_error(-20224,'Error, un torneo por Eliminatorias no puede pasar el numero de participantes según sus emparejamientos.');
        END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/
ALTER TRIGGER "RONDA_ELIMINATORIA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger RONDA_SUIZO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "RONDA_SUIZO" 
BEFORE INSERT OR UPDATE OF ID_JUGADOR,ID_TORNEO ON PARTICIPANTES 
    FOR EACH ROW
DECLARE
 v_num_rondas numeric(5);
 v_cont_jugadores numeric(5);
 v_partic_max numeric(5);
 
BEGIN
select num_rondas
    into v_num_rondas
    from suizos
    where id_torneo = :new.id_torneo;
v_partic_max := power(2,v_num_rondas);
    
select count(id_jugador)
    into v_cont_jugadores
    from participantes
    where id_torneo = :new.id_torneo;
    
    IF (v_partic_max <= v_cont_jugadores) then
        raise_application_error(-20225,'Error, un torneo Suizo no puede pasar el numero de participantes según sus rondas.');
        END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/
ALTER TRIGGER "RONDA_SUIZO" ENABLE;

--------------------------------------------------------
--  DDL for Procedure ADDPARTICIPANTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADDPARTICIPANTE" (
    p_id_torneo participantes.id_torneo%type,
    p_id_jugador participantes.id_jugador%type
    )
AS
    v_id_jugador participantes.id_jugador%type;
    v_id_torneo participantes.id_torneo%type;
    v_compJug boolean := false;
BEGIN
--Se comprueba que exista el torneo y el jugador.
select id_jugador
    into v_id_jugador
    from jugadores
    where id_jugador = p_id_jugador;
v_compJug := true;

select id_torneo
    into v_id_torneo
    from torneos
    where id_torneo = p_id_torneo;

    INSERT INTO PARTICIPANTES (
        id_torneo,
        id_jugador)
        VALUES (
        p_id_torneo,
        p_id_jugador);

EXCEPTION
when no_data_found then
    if not v_compJug then
        raise_application_error(-20100,'El jugador no existe.');
    else
        raise_application_error(-20101,'El torneo no existe.');
    end if;
END;

/
--------------------------------------------------------
--  DDL for Procedure SUBVENCION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SUBVENCION" (
    p_id_torneo patro_tor.id_torneo%type,
    p_id_patro patro_tor.id_patro%type,
    p_subvencion patro_tor.subvencion%type
    )
AS
    v_id_existtorneo patro_tor.id_torneo%type;
    v_id_existpatro patro_tor.id_patro%type;
    v_existtorneo boolean := false;
    v_existpatro boolean := false;
    v_existsubv boolean := false;
BEGIN
--Comprueba que el torneo existe en la tabla Torneos
-- y los patros en la tabla Patrocinadores, y si no, salta excepción.
select id_torneo
    into v_id_existtorneo
    from torneos
    where id_torneo = p_id_torneo;
v_existtorneo := true;

select id_patro
    into v_id_existpatro
    from patrocinadores
    where id_patro = p_id_patro;
v_existpatro := true;

    INSERT INTO PATRO_TOR (
        id_torneo, 
        id_patro, 
        subvencion) VALUES (
        p_id_torneo,
        p_id_patro,
        p_subvencion);
    v_existsubv := true;

EXCEPTION
    when no_data_found then
    if not v_existtorneo then
        raise_application_error(-20001,'El Torneo '||p_id_torneo||' no existe.');
    elsif not v_existpatro then
        raise_application_error(-20002,'El patrocinador '||p_id_patro||' no existe.');
        end if;

    when others then
    if not v_existsubv then
        UPDATE PATRO_TOR 
        SET subvencion = subvencion+p_subvencion
        where id_torneo = p_id_torneo and id_patro = p_id_patro;
    else
        raise_application_error(-20003,'ERROR!!');
    end if;
END;

/
--------------------------------------------------------
--  DDL for Function MAYOREDAD
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "MAYOREDAD" (
    p_id_jugador jugadores.id_jugador%type
    )
    return varchar
AS
    v_edad jugadores.fech_naci%type;
    v_id_jugador jugadores.id_jugador%type;
--Character large obect, usado para Strings largos.
    v_resultado clob;
BEGIN
--Comprobación de que existe el jugador.
select id_jugador
    into v_id_jugador
    from jugadores
    where id_jugador = p_id_jugador;

select fech_naci
        into v_edad
        from jugadores
        where id_jugador = p_id_jugador;

case 
    when trunc((sysdate - to_date(v_edad,'DD/MM/RR'))/365.25) > 18 
    then v_resultado := 'El jugador es mayor de edad.';
    when trunc((sysdate - to_date(v_edad,'DD/MM/RR'))/365.25) < 18 
    then v_resultado := 'El jugador es menor de edad.';
END CASE;
return v_resultado;

EXCEPTION
when no_data_found then
    raise_application_error(-20126,'El jugador ' || p_id_jugador||' no existe.');
END;

/
--------------------------------------------------------
--  DDL for Function MEDIAEDAD
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "MEDIAEDAD" (
    p_id_torneo participantes.id_torneo%type
    )
    return numeric
AS
CURSOR c_edad is
    select id_jugador
        from participantes
        join jugadores
        using (id_jugador)
        where trunc((sysdate - to_date(FECH_NACI,'DD/MM/RR'))/365.25) > 18
        and id_torneo = p_id_torneo;

    v_contador numeric := 0;
    v_id_jugador participantes.id_jugador%type;
    v_torneo participantes.id_torneo%type;
    v_compTorneo boolean := true;

BEGIN
--Comprueba que el torneo exista en la lista de torneos.
select id_torneo
    into v_torneo
    from torneos
    where id_torneo = p_id_torneo;   
v_compTorneo := false;

--Comprueba que el patrocinador esté en la tabla de las subvenciones. 
select id_torneo
    into v_torneo
    from participantes
    where id_torneo = p_id_torneo
    group by id_torneo;

open c_edad;
fetch c_edad into v_id_jugador;
while c_edad%FOUND loop
fetch c_edad into v_id_jugador;
end loop;
v_contador := c_edad%ROWCOUNT;
close c_edad;


return v_contador;

EXCEPTION
when no_data_found then
    if not v_compTorneo then
        raise_application_error(-20026,'El torneo ' || p_id_torneo||' no se empezó/tiene participantes aún.');
    else
        raise_application_error(-20027,'El torneo ' || p_id_torneo||' no existe.');
    end if;
END;

/
--------------------------------------------------------
--  DDL for Function SUBVTORNEOS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SUBVTORNEOS" (
    p_id_torneo patro_tor.id_torneo%type
    )
    return numeric
AS
    CURSOR c_torneos is
        select subvencion
            from patro_tor
            where id_torneo = p_id_torneo;

    v_cantidad numeric;
    v_cantTemp numeric;
    v_id_torneo patro_tor.id_torneo%type;
    v_compTorneo boolean := true;
BEGIN
    v_cantidad := 0;
--Comprueba que el torneo esté en la tabla de torneos. 
select id_torneo
    into v_id_torneo
    from torneos
    where id_torneo = p_id_torneo;
v_compTorneo := false;

open c_torneos;
    fetch c_torneos into v_cantTemp;
    while c_torneos%FOUND loop
        v_cantidad := v_cantTemp+v_cantidad;
    fetch c_torneos into v_cantTemp;
    end loop;
close c_torneos;

return v_cantidad;

EXCEPTION
when no_data_found then
    if not v_compTorneo then
        raise_application_error(-20116,'El torneo ' || p_id_torneo||' no se subvencionó nunca aún.');
    end if;
END;

/
--------------------------------------------------------
--  DDL for Function SUMSUBVENCION
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SUMSUBVENCION" (
    p_id_patro patro_tor.id_patro%type,
    p_fecha_desde torneos.fech_inicio%type,
    p_fecha_hasta torneos.fech_inicio%type
    )
    return numeric
AS
    CURSOR c_torneos is
        select subvencion
            from torneos
            join patro_tor
            using (id_torneo)
            where id_patro = p_id_patro
            and fech_inicio >= to_date(p_fecha_desde,'DD/MM/RR')
            and fech_fin <= to_date(p_fecha_hasta,'DD/MM/RR');

    v_cantidad numeric;
    v_cantTemp numeric;
    v_patro patro_tor.id_patro%type;
    v_compPatro boolean := true;
BEGIN
    v_cantidad := 0;
--Comprueba que el patrocinador exista en la lista de patrocinadores.
select id_patro
    into v_patro
    from patrocinadores
    where id_patro = p_id_patro;   
v_compPatro := false;

open c_torneos;
    fetch c_torneos into v_cantTemp;
    while c_torneos%FOUND loop
        v_cantidad := v_cantTemp+v_cantidad;
    fetch c_torneos into v_cantTemp;
    end loop;
close c_torneos;

    if v_cantidad = 0 then
        raise_application_error(-20015,'No hay subvenciones del patrocinador '|| p_id_patro ||'entre estas fechas.');
    end if;

return v_cantidad;

EXCEPTION
when no_data_found then
    if not v_compPatro then
        raise_application_error(-20016,'El patrocinador ' || p_id_patro||' no subvencionó nunca aún.');
    end if;
END;

/
--------------------------------------------------------
--  DDL for Trigger SUBVSUFICIENTE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SUBVSUFICIENTE" 
BEFORE INSERT OR UPDATE OF ID_JUGADOR,ID_TORNEO ON PARTICIPANTES 
    FOR EACH ROW
DECLARE
 v_id_torneo torneos.id_torneo%type;
 v_subvencion patro_tor.subvencion%type;
 v_tipo_torneo torneos.tipo_torneo%type;
 v_subvEliminatoria numeric;
 v_subvSuizo numeric;
 v_subvLiga numeric;
BEGIN
    v_subvSuizo := 20000;
    v_subvEliminatoria := 30000;
    v_subvLiga := 40000;

    SELECT tipo_torneo
    INTO  v_tipo_torneo
        FROM  TORNEOS
        WHERE id_torneo=:new.id_torneo;

    v_subvencion := subvTorneos(:new.id_torneo);

    CASE v_tipo_torneo
        WHEN 'S' THEN
            IF (v_subvencion < v_subvSuizo) THEN 
            raise_application_error(-20230,'Error, no se puede agregar participantes al torneo Suizo porque no tiene suficiente subvencion.');
            END IF;
        WHEN 'E' THEN
            IF (v_subvencion < v_subvEliminatoria) THEN 
            raise_application_error(-20231,'Error, no se puede agregar participantes al torneo Eliminatorio porque no tiene suficiente subvencion.');
            END IF;
        WHEN 'L' THEN
            IF (v_subvencion < v_subvLiga) THEN 
            raise_application_error(-20223,'Error, no se puede agregar participantes al torneo de Liga porque no tiene suficiente subvencion.');
            END IF;
    END CASE;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;

/
ALTER TRIGGER "SUBVSUFICIENTE" ENABLE;
