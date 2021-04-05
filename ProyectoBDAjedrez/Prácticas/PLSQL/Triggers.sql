---------------------------------------------------------
/*
 * TRIGGERS
 */
 
CREATE OR REPLACE TRIGGER subvSuficiente
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

-----------------------------------------------------------------
create or replace TRIGGER PARTICIPANTES 
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
-----------------------------------------------------------------
create or replace TRIGGER RONDA_ELIMINATORIA
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
-------------------------------------------------------------------
create or replace TRIGGER RONDA_SUIZO 
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
