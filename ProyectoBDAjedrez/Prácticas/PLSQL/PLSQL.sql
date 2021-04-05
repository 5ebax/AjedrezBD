SET SERVEROUTPUT ON SIZE UNLIMITED;

--PROCEDURE AGREGANDO PARTICIPANTES.
CREATE OR REPLACE PROCEDURE addParticipante (
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

--PLSQL llamando al procedimiento.
--USANDO LOS TRIGGERS DEL LIMITE DE PARTICIPANTES.
BEGIN
addParticipante('T1','J2');
EXCEPTION
when others then
    if sqlcode = -20100 then
        dbms_output.put_line(substr(sqlerrm,12));
    elsif sqlcode = -20101 then
        dbms_output.put_line(substr(sqlerrm,12));
    elsif sqlcode = -20223 then
        dbms_output.put_line(substr(sqlerrm,12));
    elsif sqlcode = -20224 then
        dbms_output.put_line(substr(sqlerrm,12));
    elsif sqlcode = -20225 then
        dbms_output.put_line(substr(sqlerrm,12));
    end if;
END;
/

--------------------------------------------------------------------

--FUNCION, DADO UN JUGADOR, DECIR SI ES O NO MAYOR DE EDAD.
CREATE OR REPLACE FUNCTION mayorEdad (
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

--PLSQL llamando a la función.
BEGIN
dbms_output.put_line(mayorEdad('&IDJugador'));
EXCEPTION
when others then
    if sqlcode = -20126 then
        dbms_output.put_line(substr(sqlerrm,12));
    end if;
END;
/

----------------------------------------------------------

--FUNCION DADO UN TORNEO, DEVOLVER EL NUMERO
--DE PARTICIPANTES MAYORES DE EDAD.
CREATE OR REPLACE FUNCTION mediaEdad (
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

--`PLSQL llamando a la función.
DECLARE
CURSOR c_torneos is
    select id_torneo
        from participantes
        group by id_torneo;
    v_id_torneo torneos.id_torneo%type;
BEGIN
open c_torneos;
fetch c_torneos into v_id_torneo;
while c_torneos%FOUND loop
    dbms_output.put_line('Numero de participantes mayores de edad '||mediaEdad(v_id_torneo)||', en torneo '||v_id_torneo);
fetch c_torneos into v_id_torneo;
end loop;
close c_torneos;

EXCEPTION
when others then
    if sqlcode = -20026 then
            dbms_output.put_line(substr(sqlerrm,12));
        elsif sqlcode = -20027 then
            dbms_output.put_line(substr(sqlerrm,12));
        end if;
END;
/


-----------------------------------------------------------------

--FUNCION PARA VER EN UNAS FECHAS COMPRENDIDAS DADAS
--LA SUMA TOTAL DE LAS SUBVENCIONES RECIBIDAS.
CREATE OR REPLACE FUNCTION sumSubvencion(
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

--PLSQL PARA LLAMAR A LA FUNCIÓN.
DECLARE
    v_id_patro patrocinadores.id_patro%type;
    v_fecha_desde date;
    v_fecha_hasta date;

BEGIN
v_id_patro := &IDPatrocinador;
v_fecha_desde := '&FechaDesde';
v_fecha_hasta := '&FechaHasta';
    
    dbms_output.put_line(sumSubvencion(v_id_patro,v_fecha_desde,v_fecha_hasta));

EXCEPTION
when others then
        if sqlcode = -20015 then
            dbms_output.put_line(substr(sqlerrm,12));
        elsif sqlcode = -20016 then
            dbms_output.put_line(substr(sqlerrm,12));
        end if;
END;
/

---------------------------------------------------------------------------

--PROCEDURE DE PATROCINADOR OFRECIENDO SUBVENCIONES.
CREATE OR REPLACE PROCEDURE subvencion (
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

--PLSQL para añadir más fondos a la subvencion.
DECLARE
    v_id_torneo patro_tor.id_torneo%type; 
    v_id_patro patro_tor.id_patro%type;
    v_subvencion patro_tor.subvencion%type;
BEGIN
    v_id_torneo := '&IDTorneo';
    v_id_patro := '&IDPatrocinador';
    v_subvencion := &SubvencionExtra;
    
    subvencion(v_id_torneo,v_id_patro,v_subvencion);
    
EXCEPTION
when others then
        if sqlcode = -20001 then
            dbms_output.put_line(substr(sqlerrm,12));--Pinta el mensaje del error.
        elsif sqlcode = -20002 then
            dbms_output.put_line(substr(sqlerrm,12));
        elsif sqlcode = -20003 then
            dbms_output.put_line(substr(sqlerrm,12));
        end if;
END;
/
---------------------------------------------------------------------

--DAR UN RANKING Y RECIBIR LOS JUGADORES DE ESE RANKING
DECLARE 
    v_id_ranking jugadores.id_ranking%type := '&Ranking';
    v_id_jugador jugadores.id_jugador%type;
    v_nombre jugadores.nombre%type;
    v_apellido jugadores.apellido%type;
    v_id_club jugadores.id_club%type;
    v_compRank rankings.id_ranking%type;
    v_existrank boolean := false;
    v_contador numeric;
    
    cursor c_jugador is
        select id_jugador,nombre,apellido,id_club
            from jugadores
            where id_ranking=v_id_ranking;
BEGIN
--Comprueban que exista el ranking.
select id_ranking
    into v_compRank
    from rankings
    where id_ranking = v_id_ranking;
v_existrank := true;

v_contador := 0;

open c_jugador;
    fetch c_jugador into v_id_jugador,v_nombre, v_apellido, v_id_club;
        while c_jugador%FOUND loop
        dbms_output.put_line('Ranking '||v_id_ranking||': '||v_id_jugador||' '||v_nombre||' '||v_apellido||' '||v_id_club);
        v_contador := v_contador+1;
    fetch c_jugador into v_id_jugador,v_nombre, v_apellido, v_id_club;
end loop;
close c_jugador;

    if v_contador = 0 then
        dbms_output.put_line('No hay jugadores en este ranking.');
    else
        dbms_output.put_line('Hay '||v_contador||' jugadores en este Ranking.');
    end if;

EXCEPTION
        when no_data_found then
        if not v_existrank then
            dbms_output.put_line('El ranking ' || v_id_ranking||' no existe.');
        end if;
END;
/


--------------------------------------------------------------------------------
--CURSOR DENTRO DE OTRO CURSOR, SACANDO CADA TORNEO Y SUS PARTICIPANTES.
DECLARE
    v_id_torneo torneos.id_torneo%type;
    
    CURSOR c_torneos is
        select id_torneo, nom_torneo
            from torneos
            order by id_torneo;
    
    CURSOR c_participantes is
        select id_jugador, nombre, apellido
            from jugadores
            join participantes
            using (id_jugador)
            where id_torneo = v_id_torneo;

    v_id_jugador jugadores.id_jugador%type := null;
    v_nombre jugadores.nombre%type;
    v_apellido jugadores.apellido%type;
    v_nom_torneo torneos.nom_torneo%type;
BEGIN
open c_torneos;
fetch c_torneos into v_id_torneo, v_nom_torneo;
while c_torneos%FOUND loop
    dbms_output.put_line('Torneo: '||v_nom_torneo||' ID: ' ||v_id_torneo);
    dbms_output.put_line('* * * * * * * * * * * * * * * * * * * * *');
    open c_participantes;
        fetch c_participantes into v_id_jugador, v_nombre, v_apellido;
        if c_participantes%NOTFOUND then
            dbms_output.put_line('Aún no hay participantes en el torneo.');
        else
            while c_participantes%FOUND loop
                dbms_output.put_line('Jugador: '||v_nombre ||' '|| v_apellido||'. ID: ' ||v_id_jugador);
            fetch c_participantes into v_id_jugador, v_nombre, v_apellido;
        end loop;
    end if;
    close c_participantes;
        dbms_output.put_line(CHR(10)||'----------------------------------------------');
fetch c_torneos into v_id_torneo,v_nom_torneo;
end loop;
close c_torneos;
END;
/

-------------------------------------------------------------------------

--NUMERO DE EMPATES, VICTORIAS Y DERROTAS DEL JUGADOR DADO.
DECLARE
v_id_jugador jugadores.id_jugador%type := '&IDJugador';

CURSOR c_empates is
    select Jugadores
        from(
            select id_jugador_1 Jugadores, resultado
                from partidas
                where resultado=0
                UNION ALL
            select id_jugador_2, resultado
                from partidas
                where resultado = 0)
                where Jugadores = v_id_jugador; 
                
CURSOR c_victorias is
    select Jugadores
        from(
            select id_jugador_1 Jugadores, resultado
                from partidas
                where resultado=1
                UNION ALL
            select id_jugador_2, resultado
                from partidas
                where resultado = 2)
                where Jugadores = v_id_jugador; 
                
CURSOR c_derrotas is
    select Jugadores
        from(
            select id_jugador_1 Jugadores, resultado
                from partidas
                where resultado=2
                UNION ALL
            select id_jugador_2, resultado
                from partidas
                where resultado = 1)
                where Jugadores = v_id_jugador; 
                
    v_contEmp numeric := 0;
    v_contVic numeric := 0;
    v_contDer numeric := 0;
    v_jugador partidas.id_jugador_1%type;
    v_empates partidas.resultado%type;
    v_victorias partidas.resultado%type;
    v_derrotas partidas.resultado%type;
    v_compJug boolean := false;
BEGIN
--Se comprueba que el jugador existe.
--Solo Jugador 1 porque un jugador 2 ha debido de estar antes
--en otra partida como Jugador 1.
select id_jugador
    into v_jugador
    from jugadores
    where id_jugador = v_id_jugador
    group by id_jugador;
v_compJug := true;

select id_jugador_1
    into v_jugador
    from partidas
    where id_jugador_1 = v_id_jugador
    group by id_jugador_1;

--Se abren los cursores y se cuenta la cantidad
--de derrotas,victorias y empates con ROWCOUNT.
open c_empates;
    fetch c_empates into v_empates;
    while c_empates%FOUND loop
    fetch c_empates into v_empates;
end loop;
v_contEmp := c_empates%ROWCOUNT;
close c_empates;

open c_victorias;
    fetch c_victorias into v_victorias;
    while c_victorias%FOUND loop
    fetch c_victorias into v_victorias;
end loop;
v_contVic := c_victorias%ROWCOUNT;
close c_victorias;

open c_derrotas;
    fetch c_derrotas into v_derrotas;
    while c_derrotas%FOUND loop
    fetch c_derrotas into v_derrotas;
end loop;
v_contDer := c_derrotas%ROWCOUNT;
close c_derrotas;

    dbms_output.put_line('El jugador '||v_id_jugador|| ' tiene '||v_contEmp||
    ' empates, '||v_contVic||' victorias y '||v_contDer||' derrotas.');

EXCEPTION
when no_data_found then
    if not v_compJug then
        dbms_output.put_line('El jugador '||v_id_jugador||' no existe.');
    else
        dbms_output.put_line('El jugador '||v_id_jugador||' no ha jugado partidas.');
    end if;
END;
/

------------------------------------------------------------------------------

SET SERVEROUTPUT ON SIZE UNLIMITED;

--FUNCION DEVUELVE LA SUMA TOTAL DE SUBVENCION DE UN TORNEO.
create or replace FUNCTION SubvTorneos(
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


--PLSQL MIRA SI LOS TORNEOS TIENEN SUBVENCION SUFICIENTE PARA PODER REALIZARSE.
DECLARE
    CURSOR c_torneos is 
        select id_torneo,tipo_torneo, nom_torneo
            from torneos;
            
    v_tipo_torneo torneos.tipo_torneo%type;
    v_id_torneo torneos.id_torneo%type;
    v_nom_torneo torneos.nom_torneo%type;
    v_subvencion numeric;
    v_subvFalta numeric;
    v_subvEliminatoria numeric;
    v_subvSuizo numeric;
    v_subvLiga numeric;
BEGIN
    v_subvFalta := 0;
    v_subvSuizo := 20000;
    v_subvEliminatoria := 30000;
    v_subvLiga := 40000;
    
open c_torneos;
    fetch c_torneos into v_id_torneo,v_tipo_torneo, v_nom_torneo;
    while c_torneos%FOUND loop
    
    v_subvencion := subvtorneos(v_id_torneo);
    
    case v_tipo_torneo
        when 'S' then
            if v_subvencion > v_subvSuizo then
                dbms_output.put_line(CHR(10)||'Torneo: '||v_id_torneo);
                dbms_output.put_line('Hay suficiente dinero subvencionado para realizar el torneo '||v_nom_torneo);
            elsif v_subvencion < v_subvSuizo then 
                v_subvFalta := v_subvSuizo-v_subvencion;
                dbms_output.put_line(CHR(10)||'Torneo: '||v_id_torneo);
                dbms_output.put_line('No hay suficiente dinero para realizar el torneo '||v_nom_torneo||' falta '||v_subvFalta||'€');
            end if;
        when 'E' then
            if v_subvencion > v_subvEliminatoria then
                dbms_output.put_line(CHR(10)||'Torneo: '||v_id_torneo);
                dbms_output.put_line('Hay suficiente dinero subvencionado para realizar el torneo '||v_nom_torneo);
            elsif v_subvencion < v_subvEliminatoria then 
                v_subvFalta := v_subvEliminatoria-v_subvencion;
                dbms_output.put_line(CHR(10)||'Torneo: '||v_id_torneo);
                dbms_output.put_line('No hay suficiente dinero para realizar el torneo '||v_nom_torneo||' falta '||v_subvFalta||'€');
            end if;
        when 'L' then
            if v_subvencion > v_subvLiga then
                dbms_output.put_line(CHR(10)||'Torneo: '||v_id_torneo);
                dbms_output.put_line('Hay suficiente dinero subvencionado para realizar el torneo '||v_nom_torneo);
            elsif v_subvencion < v_subvLiga then 
                v_subvFalta := v_subvLiga-v_subvencion;
                dbms_output.put_line(CHR(10)||'Torneo: '||v_id_torneo);
                dbms_output.put_line('No hay suficiente dinero para realizar el torneo '||v_nom_torneo||' falta '||v_subvFalta||'€');
            end if;
    end case;
    fetch c_torneos into v_id_torneo,v_tipo_torneo, v_nom_torneo;
    end loop;
close c_torneos;

EXCEPTION
when others then
        if sqlcode = -20116 then
            dbms_output.put_line(substr(sqlerrm,12));
        end if;
END;
/


-----------------------------------------------------------------

--PRUEBAS CON DISTINTOS ELEMENTOS.
--ARRAY USANDO CURSOR.
DECLARE
CURSOR c_club is
    select id_club, nom_club, n_integrantes
        from clubes;
        
   type a_id_club IS VARRAY(999) OF clubes.id_club%type;
   type a_nom_club IS VARRAY(999) OF clubes.nom_club%type;
   type a_n_integrantes IS VARRAY(999) OF clubes.n_integrantes%type;
   v_id_club a_id_club := a_id_club();
   v_nom_club a_nom_club := a_nom_club();
   v_integrantes a_n_integrantes := a_n_integrantes();
   contador integer := 0;
        
BEGIN
    FOR n IN c_club LOOP 
      contador := contador + 1; 
      v_nom_club.extend;
      v_nom_club(contador) := n.nom_club;
      v_id_club.extend; 
      v_id_club(contador)  := n.id_club; 
      v_integrantes.extend; 
      v_integrantes(contador) := n.n_integrantes;
      dbms_output.put_line('Club('||v_id_club(contador)||'): '||v_nom_club(contador)||', Num.Integrantes: '||v_integrantes(contador)); 
    END LOOP; 
END;
/


--PRUEBA CON ARRAY.
DECLARE 
   type nombresArray IS VARRAY(5) OF VARCHAR2(10); 
   type notasArray IS VARRAY(5) OF INTEGER; 
   nombres nombresarray; 
   notas notasArray; 
   total integer; 
BEGIN 
   nombres := nombresArray('Oswal', 'Yisus', 'Ayman', 'Giovanni', 'Aziz'); 
   notas:= notasArray(98, 97, 28, 87, 92); 
   total := nombres.count; 
   dbms_output.put_line('Numero de estudiantes :'|| total); 
   FOR i in 1 .. total LOOP 
      dbms_output.put_line('Estudiante: ' || nombres(i) || ', Nota: ' || notas(i)); 
   END LOOP; 
END; 
/

--PRUEBA CON LOOP.
DECLARE 
   i number(1); 
   j number(1); 
BEGIN 
   << loop_externo >> 
   FOR i IN 1..3 LOOP
      << loop_interno >> 
      FOR j IN 1..3 LOOP 
         dbms_output.put_line('i es: '|| i || ' y j es: ' || j); 
      END loop loop_interno; 
   END loop loop_externo; 
END; 
/

--PRUEBAS CON RECORDS
DECLARE 
   v_arbitro arbitros%ROWTYPE; 
BEGIN 
   SELECT * into v_arbitro 
   FROM arbitros 
   WHERE id_arbitro = 'A1';  
   dbms_output.put_line('Arbitro ID: ' || v_arbitro.id_arbitro); 
   dbms_output.put_line('DNI: ' || v_arbitro.dni); 
   dbms_output.put_line('Nombre: ' || v_arbitro.nombre); 
   dbms_output.put_line('Telefono: ' || v_arbitro.telefono); 
END; 
/

DECLARE 
   type libros is record 
      (titulo varchar(50), 
      autor varchar(50), 
      tema varchar(100), 
      id_libro number); 
   libro1 libros; 
   libro2 libros; 
BEGIN 
   -- Libro 1 especificación 
   libro1.titulo  := 'Programacíon'; 
   libro1.autor := 'Eduardo ';  
   libro1.tema := 'Tutorial de Programacion'; 
   libro1.id_libro := 6495407;  
   -- Libro 2 especificación 
   libro2.titulo := 'SQL y PL/SQL'; 
   libro2.autor := 'Adolfo'; 
   libro2.tema := 'Tutorial de SQL y PL/SQL'; 
   libro2.id_libro := 6495700;  
  
  -- Imprime record del Libro 1 
   dbms_output.put_line('Libro 1 titulo : '|| libro1.titulo); 
   dbms_output.put_line('Libro 1 autor : '|| libro1.autor); 
   dbms_output.put_line('Libro 1 tema : '|| libro1.tema); 
   dbms_output.put_line('Libro 1 id_libro : ' || libro1.id_libro); 
   
      dbms_output.put_line(''); 
   -- Imprime record del Libro 2 
   dbms_output.put_line('Libro 2 titulo : '|| libro2.titulo); 
   dbms_output.put_line('Libro 2 autor : '|| libro2.autor); 
   dbms_output.put_line('Libro 2 tema : '|| libro2.tema); 
   dbms_output.put_line('Libro 2 id_libro : '|| libro2.id_libro); 
END; 
/
