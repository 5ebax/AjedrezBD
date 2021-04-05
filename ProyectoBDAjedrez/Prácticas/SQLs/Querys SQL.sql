------------------------------------------------------------------------------------------------------------------

--INSERTS DE JUGADORES. SOLO DE OBLIGATORIOS Y TAMBIÉN DE TODOS LOS CAMPOS INCLUYENDO FECHA_NACIMIENTO.

INSERT INTO "AJEDREZ"."JUGADORES" 
    (ID_JUGADOR, ID_CLUB, ID_RANKING) VALUES 
        ('J'||JUGADOR.nextval, 
        '&CLUB_JUGADOR', 
         '&RANKJUGADOR');
         
INSERT INTO "AJEDREZ"."JUGADORES" 
    (ID_JUGADOR, ID_CLUB, ID_RANKING,NOMBRE, APELLIDO,CP,EMAIL,FECH_NACI) VALUES 
        ('J'||JUGADOR.nextval, 
        '&CLUB_JUGADOR', 
         '&RANKJUGADOR',
         '&NOMBRE',
         '&APELLIDO',
         '&CP',
         'EMAIL',
         TO_CHAR(to_date('&DIA/&MES/&AÑO', 'DD/MM/YYYY')));
         
         
--UPDATE EN LAS TABLAS
--Aumenta con un plus la subvención dada por un patrocinador en un torneo determinado.
UPDATE "PATRO_TOR"
    SET SUBVENCION = SUBVENCION+&PLUS
    WHERE ID_TORNEO = '&TORNEO' and ID_PATRO = '&PATROCINADOR';
 
 --Actualización de ranking de un jugador para cuando suba o baje de rank.
 UPDATE "JUGADORES"
    SET ID_RANKING = '&NUEVO_RANKING'
    WHERE ID_JUGADOR = '&JUGADORACAMBIAR';
    
    
--DELETE DE JUGADORES.
--Borra el jugador dandole la ID del que se desea eliminar.
DELETE FROM "AJEDREZ"."JUGADORES" 
    WHERE ID_JUGADOR=('J'||&IDJUGADOR);
    
------------------------------------------------------------------------------------------------------------------


--LISTA DE LIDERES QUE SEAN JUGADORES Y SABER EN QUE TORNEO PARTICIPA O SI NO PARTICIPA.
--(Uso del "NVL", "left join" para que aparezcan todos y el "where").
select id_club, id_jug_lider, NVL(id_torneo,'No participa') Torneo
    from clubes
    join jugadores
    using (id_club)
    left join participantes
    using (id_jugador)
    where id_jug_lider=id_jugador;


-- SUMA TOTAL DE SUBVENCIONES POR CADA UNO DE LOS PATROCINADORES 
-- POR ORDEN DESCENDIENTE Y CANTIDAD DE VECES QUE SUBVENCIONÓ.
--(Uso de "sum","on","group by","order by,desc" y "alias").
select nom_patro, sum(subvencion)"Subvenciones totales", count(subvencion) "Veces Subvencionando"
    from patro_tor pt
    join patrocinadores p
    on p.id_patro=pt.id_patro
    group by nom_patro
    order by "Subvenciones totales" desc;


--NUMERO DE JUGADORES MAYORES DE EDAD EN CADA RANKING.
--(Uso de "count","trunc" y transformacion de la fecha de nacimiento a edad con "sysdate" y "to_date").
select id_ranking,count(*) Num_jugadores
    from jugadores
    where trunc((sysdate - to_date(FECH_NACI,'DD/MM/RR'))/365.25) > 18
    group by id_ranking;
    
    

--LISTADO DE TORNEOS PREREQUISITOS Y LOS TORNEOS DEL QUE SON PREREQUISITOS.
--(Uso de "on","group by","order by" y las "alias").
select t1.prer_torneo, t1.nom_torneo
    from torneos t1
    join torneos t2
    on t1.prer_torneo = t2.id_torneo
    group by t1.prer_torneo, t1.nom_torneo
    order by t1.prer_torneo;
    

--JUGADORES POR ENCIMA DE LA MEDIA DE PARTICIPACIÓN DE TORNEOS
--LISTADOS POR ORDEN ALFABÉTICO.
--(Uso de "having", "subquerys", "avg" y "group y order by").
select id_jugador, nombre
    from jugadores
    join participantes
    using (id_jugador)
    group by id_jugador,nombre
    having count(id_jugador) >(
            select round(avg(count(*))) MediaParticipantes
                from participantes
                group by id_jugador
                )
    order by nombre;
                
    
--LISTA DE TORNEOS EN LOS QUE HAYAN PARTICIPADO UNA CANTIDAD
--DE PARTICIPANTES IGUAL A LA MÁXIMA PARTICIPACIÓN EN CADA TORNEO.
--(Uso de "having","count","group","subquerys" y "max").
select id_torneo,nom_torneo,count(*) NumPartTorneos
    from torneos
    join participantes
    using (id_torneo)
    group by id_torneo,nom_torneo
    having count(id_torneo) =(
        select max(count(*)) NumParTorneos
            from participantes
            group by id_torneo
            );


--CLUBES QUE SON IGUAL O MAYOR A LA MEDIA DE INTEGRANTES DE ESOS MISMOS CLUBES.
--(Uso de "sum","avg",">=","having", "where" y "group by").
select id_club, nom_club, n_integrantes
    from clubes
    group by id_club, nom_club,n_integrantes
    having sum(n_integrantes)>=( 
        select round(avg(sum(n_integrantes))) MediaIntegrantes
            from clubes
            group by id_club
            );


--LISTA DE TODOS LOS TORNEOS ORDENADOS POR ID
--CON LA CANTIDAD DE PARTICIPANTES EN CADA UNO
--Y LA SUBVENCION RECIBIDA PARA QUE FUESE POSIBLE.
--(Uso de "CAST","left join","subquerys","NVL","alias","count" y "group y order by").
select sub.id_torneo, NVL(CAST(Participantes as VARCHAR(15)),'Proximamente')Participantes, Subvencion
    from(
    select id_torneo, NVL(CAST(sum(subvencion) as VARCHAR(15)),'Aun sin subvencion')Subvencion
        from torneos
        left join patro_tor
        using (id_torneo)
        group by id_torneo
        ) sub
        LEFT JOIN
        (
        select id_torneo, count(*) Participantes
            from torneos
            join participantes
            using (id_torneo)
            group by id_torneo
            ) par
        on sub.id_torneo=par.id_torneo
        order by sub.id_torneo;


--LISTA DE LA CANTIDAD DE EMPATES, DERROTAS Y VICTORIAS
--DE LOS JUGADORES QUE JUEGAN PARTIDAS.
--"UNION ALL" PARA QUE APAREZCAN TODOS LOS CAMPOS Y SE PUEDA SUMAR BIEN.
--CUANDO UN JUGADOR TIENE MAS DE UN NULL NO SE AGRUPA
--ASÍ QUE "NVL" A 0 Y SE SUMA PARA DEJARLO EN UNA SOLA LÍNEA.
--(Uso de muchas cosas).
select Jugadores, sum(Empates) Empates, sum(Derrotas) Derrotas, sum(Victorias) Victorias
    from(
    select Jugadores, NVL(Empates,0)Empates, NVL(Derrotas,0)Derrotas, NVL(Victorias,0)Victorias
        from(
        select NVL(NVL(j.Jugadores,der.Jugadores),vic.Jugadores) Jugadores, sum(Empate) Empates, Derrotas, Victorias
            from(
            select id_jugador_1 Jugadores, count(*) Empate 
                from partidas
                where resultado=0
                group by id_jugador_1
        UNION ALL
            select id_jugador_2, count(*) Empate
                from partidas
                where resultado = 0
                group by id_jugador_2
                ) j
            FULL JOIN
            (
            select Jugadores, sum(Derrotas)Derrotas
            from(
                select id_jugador_1 Jugadores, count(*)Derrotas
                    from partidas
                    where resultado=2
                    group by id_jugador_1
        UNION ALL
                select id_jugador_2, count(*)Derrotas
                    from partidas
                    where resultado=1
                    group by id_jugador_2
                    ) 
                    group by Jugadores) der
            on der.Jugadores=j.Jugadores
            FULL JOIN
            (
                select Jugadores, sum(Victorias)Victorias
                from(
                    select id_jugador_1 Jugadores, count(*)Victorias
                        from partidas
                        where resultado=1
                        group by id_jugador_1
        UNION ALL
                    select id_jugador_2, count(*)Victorias
                        from partidas
                        where resultado=2
                        group by id_jugador_2
                        )
                        group by Jugadores) vic
            on der.Jugadores=vic.Jugadores and j.Jugadores=vic.Jugadores
            group by j.Jugadores,der.Jugadores,vic.Jugadores,Derrotas,Victorias))
            group by Jugadores
            order by Jugadores;
        
        

--CANTIDAD DE PARTIDAS EMPATADAS O GANADAS POR J1 O J2
--ARBITRADAS POR CADA ARBITRO, ORDENADO POR SU ID.
--(Uso de "to_char", "case when", etc).
select Arbitro, (case to_char(Empate) when '0' THEN 'No Arbitrado' else to_char(Empate) END) Empate,
        (case to_char("GANA J1") when '0' THEN 'No Arbitrado' else to_char("GANA J1") END) "GANA J1",
        (case to_char("GANA J2") when '0' THEN 'No Arbitrado' else to_char("GANA J2") END) "GANA J2"
    from(
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
                    group by Arbitro)
                    group by Arbitro,(case to_char(Empate) when '0' THEN 'No Arbitrado' else to_char(Empate) END),
                    (case to_char("GANA J1") when '0' THEN 'No Arbitrado' else to_char("GANA J1") END),
                    (case to_char("GANA J2") when '0' THEN 'No Arbitrado' else to_char("GANA J2") END)
                    order by Arbitro;
                    

                    
--PROBANDO LAS VISTAS.              
select Arbitro, (case to_char(Empate) when '0' THEN 'No Arbitrado' else to_char(Empate) END) Empate,
        (case to_char("GANA J1") when '0' THEN 'No Arbitrado' else to_char("GANA J1") END) "GANA J1",
        (case to_char("GANA J2") when '0' THEN 'No Arbitrado' else to_char("GANA J2") END) "GANA J2"
    from(
         Arbitro) --Vista
                group by Arbitro,(case to_char(Empate) when '0' THEN 'No Arbitrado' else to_char(Empate) END),
                (case to_char("GANA J1") when '0' THEN 'No Arbitrado' else to_char("GANA J1") END),
                (case to_char("GANA J2") when '0' THEN 'No Arbitrado' else to_char("GANA J2") END)
                order by Arbitro;



--NUMERO MAXIMO DE PARTICIMANTES EN TORNEO EN ELIMINATORIAS Y SUIZOS
--SEGUN EL NUMERO DE EMPAREJAMIENTOS O RONDAS.
select id_torneo, power(2,num_rondas) Num_Participantes_Maximo
    from suizos
    UNION
select id_torneo, (num_emparejamientos*2)
    from eliminatorias;
    
    
--TORNEOS DONDE SE JUGARÁ EL DESEMPATE.
select id_torneo, "PLAY-OFFS"
    from eliminatorias
    where "PLAY-OFFS" like 'Y'
    UNION
select id_torneo, patron_desemp
    from ligas
    where patron_desemp like 'Y';

