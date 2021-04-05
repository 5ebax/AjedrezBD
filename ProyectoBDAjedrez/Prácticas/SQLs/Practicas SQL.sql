-- Todas las columnas y todas las filas de la tabla course,
-- esto me lo da el *
-- sentencia select
select *
    from course;
    
-- precio es el alias (otro nombre para la salida del script) de la columna cost    
select cost "precio", description "nombre curso"
    from course;
    
-- La tabla dual sirve para hacer prueba sin comprometer los demas datos    
select *
    from dual;
    
select cost, 5+6
    from course;
    
select 5+NULL
    from DUAL;
    
 -- Funcion NVL para tratar a los null   

select NVL( cost, 1000 )+100, description
    from course;
 -- codigo postal, es el alias   
select LAST_NAME, NVL( ZIP, 'NOZIP' ) "codigo postal"
    from INSTRUCTOR;
    
select student_id, section_id, to_char(enroll_date, 'DD-MON-YYYY')
    from enrollment;
    
    -- where, para seleccionar filas
    /* 
    los cursoscon coste mayor de 1190, se excluye el nulo por que no es ni mayor, ni menor, ni igual
    */
    select course_no, description, cost
        from course
        where cost >= 1195;
 -- se pierde el nulo, para evitar que se pierda le agregamos una condicion or (o) para agregar la condicion null a la query, 
 -- nunca poner cost = null, si se deja conn = pasar� y no dar� error, pero no es correcto
    select course_no, description, cost
        from course
        where cost < 1195 or cost is null;
        
 -- otra opcion para el tratamiento de los null en las where, los podemos tratar como otro coste usando NVL  
 -- al otorgarle el valor, en la consulta no saldra el valor otorgado en el filtro, saldra con el valor que tiene en la tabla es decir null
 -- para que salga con el valor otorgado se le debe otorgar en el select con nvl (cost, 1295).
 -- puedes poner un alias pero no usarlo para la condicion, por que dar� error.
 
    select course_no, description, nvl (cost, 1295)
        from course
        where nvl (cost,1295) >= 1195;
        
        
        
-- Ejercicio

    select course_no, description, cost
        from course
        where prerequisite is null;
        
-- Operador LIKE
-- Lista de instructores.

    select first_name, last_name
        from instructor;

-- where con letras
-- 'T%' significa que comience con t pero que saque tambien los dem�scaracteres.
    select first_name, last_name
        from instructor
        where first_name like 'T%';
-- que tengan un caracter a con cualquier cosa delante y cualquier cosa detras.        
    select first_name, last_name
        from instructor
        where last_name like '%a%';
        
-- que tenga una W delante       
    select first_name, last_name
        from instructor
        where last_name like 'W%';
        
-- que tenga una o en segundo lugar y luego cualquier cosa, el _ sustituye un caracter cada _ es un caracter
    select first_name, last_name
        from instructor
        where last_name like '_o%';
        
--Substring(substr) obten un string de otro.
-- listado cursos de introduccion.

    select course_no, substr (description,1,8)
        from course
        where description like 'Intro to%';
        
        
--Sysdate (fecha del sistema)
    select *
        from enrollment
        where enroll_date < sysdate;

--Date consulta con fecha

select student_id,section_id, to_char(enroll_date, 'DD/MM/RR HH24:MI')
    from enrollment
    where enroll_date >= to_date('04-FEB-2007', 'DD-MON-YYYY');
    
    
--menor
-- salen las fechas menores del 04-feb-2007
-- se incluyen aquellos que tengan un tiempo de 03-feb-2007 23:59 ya que cumplen la condicion de ser menor de 04-feb-2007
select student_id,section_id, to_char(enroll_date, 'DD/MM/RR HH24:MI')
    from enrollment
    where enroll_date < to_date('04-FEB-2007', 'DD-MON-YYYY');



-- tabla dual y fecha

select to_char(to_date('04-02-2007 20:55', 'DD/MM/YYYY HH24:MI'), 'DD/MONTH/YYYY HH24:MI')
    from dual;

--sysdate

select to_char(sysdate,'DD/MONTH/YYYY HH24:MI')
    from dual;
-- Una query es una sola instruccion, el orden de la query no determina el orden de ejecucion
-- Where solo con nombres de tablas no se puede preguntar por el alias
-- apellido y nombre del estudiante con el estado y ciudad en la que viven.

-- Join cuando se hace un joint entre tablas es como si se creara una nueva tabla, la cual tiene los datos requeridos de una tabla y otra
-- Con un join enchufo lineas y se tiene a disposicion todas las columnas de las dos tablas
-- Si no se llaman igual se debe nombrar los campos primary key y foreign key
-- los campos de union de un join son su foreign key y la primary foreign

select LAST_NAME, FIRST_NAME, CITY, STATE
    from STUDENT
    join ZIPCODE
    using (ZIP);
    
--No sacara aquellos que tengan el campo null
    
select LAST_NAME, FIRST_NAME, CITY, STATE
    from INSTRUCTOR
    join ZIPCODE
    using (ZIP);
    
    
--sacar relacion de alumno matriculado y seccion en la que esta matriculado.

select student_id, section_id
    from ENROLLMENT;
    
-- otra forma

select student_id, last_name, section_id
    from ENROLLMENT
    join STUDENT
    using (STUDENT_ID);

-- Apellido del estudiante 102 y en que seccion se ha matriculado

select student_id, last_name, section_id
    from ENROLLMENT
    join STUDENT
    using (STUDENT_ID)
    where student_id = 102;
    
-- localizacion que tiene cada seccion

select student_id, section_id, location
    from ENROLLMENT
    join SECTION
    using(SECTION_ID);
    
-- no se saca de nuevo la location ya que se supone que las que salgan son de la seccion L210

select section_id
    from SECTION
    where location = 'L210';
    
-- con substring 

select section_id
    from SECTION
    where  SUBSTR(location,0,2) = 'L2';
    
-- notas

select first_name, numeric_grade
    from GRADE
    join STUDENT
    using (student_id)
    where student_id = 103;


-- el from reune a enrollment y a los datos siguientes

select student_id, last_name, section_id, location
    from ENROLLMENT
    join section
    using (section_id)
    join student
    using (section_id, student_id);
    
select first_name, numeric_grade, city
    from grade
    join student
    using (student_id)
    join zipcode 
    using (zip);


-- Alias tablas: las tablas se pueden bautizar con con alias.
-- se hace una union una tabla con ella misma, para ello se usa el on y no el using

select CF.course_no, CF.description, CF.prerequisite, CP.description
    from course CF
    join course CP
    on CF.prerequisite = CP.course_no;
    
    
select instructor_id, first_name,city
    from instructor
    join zipcode
    using (zip);
    
-- outer join fuerza los datos de la tabla a que salgan a unque no encuentren pareja
--  el outer join utiliza las palabras right y left para refereirse a las tablas que van antes right y despues left
-- el tratamiento NVL es importante!!

select instructor_id, first_name,NVL (city, 'desconocida')
    from instructor
    left join zipcode
    using (zip);

-- No saldran los datos que estan null 
-- El where va a lo ultimo siempre (Podria caer enexamen)
select course_no, description, location
    from section
    right join course
    using (course_no)
    where location is null;


   
select student_id, first_name
    from enrollment
    right join student
    using (student_id)
    where section_id is null;
    
-- Listado de cursos que se estan impartiendo

select course_no, description
    from section
    join course
    using (course_no);
    
 --  Listado de cursos que no se estan impartiendo
select course_no, description
    from section
    right join course
    using (course_no)
    where section_id is null;
    
--AGRUPACION!
-- distinct: crea grupos de lineas con aquellas que tienen la misma informacion que la informacion despues del select sea igual en su totalidad
--ej: que course_no y description sean informacion igual en varias lineas
-- order by: clausula que sepone al final de la query, asc: orden ascendente desc: orden descendente
select distinct course_no, description
    from course
    join section
    using(course_no)
    order by course_no;

--ALIAS
select c.course_no, c.description, p.course_no, p.description
    from course c
    left join course p
    on c.prerequisite = p.course_no;
    
select section_id, s.student_id, instructor_id, i.last_name "APE INSTRUCTOR", s.last_name "APE ESTUDIANTE"
    from enrollment e
    join section
    using (section_id)
    join instructor i
    using (instructor_id)
    join student s
    on s.student_id = e.student_id
    --using (student_id)
    order by s.last_name;
    
--Se forman tantos grupos como saludos hay.
-- Poner * sea cualquier campo distinto de nulo.
select salutation, count(*) numAlum
    from student
    group by salutation;
    
--lista de los estudiantes con el numero de asig en las que están matriculaos
select student_id,count(*)
    from enrollment
    group by student_id;
    
select student_id, last_name, city, count (*) NUMSEC
    from enrollment
    join student
    using (student_id)
    join zipcode
    using (zip)
    group by student_id, last_name, city;
    
--Num Secciones en las que se imparte cada curso(Con coste).
select course_no,cost, count(*) NumSec
    from section
    join course
    using (course_no)
    group by course_no, cost;
  
  --NUMERO DE CURSO, CON SU COSTE Y LA DESCRIPCION DEL CURSO PREREQUISITO, Y EL CONTADOR DE CUANTAS SECCIONES TIENE.
select c.course_no, c.cost, c2.description Nom_Prerequisito, count(*) NumSec
    from section s
    join course c
    on s.course_no = c.course_no
    join course c2
    on c.prerequisite = c2.course_no
    group by c.course_no, c.cost, c2.description; 
        
    --Listado de todos los instructores con el numero de secciones en las que imparten descartando el instructor 105
    
        select instructor_id, count(section_id)numSec
            from section
            right join instructor
            using (instructor_id)
            where instructor_id != 105
            group by instructor_id;
            
    -- Listado de instructores que imparten en menos de 10 secciones
    
        select instructor_id, last_name,count(section_id)numSec
            from section
            right join instructor
            using (instructor_id)
            where instructor_id != 105
            group by instructor_id, last_name
            having count(section_id) < 10;
            
    --subquery! y having
        select instructor_id, numSec
            from (
                 select instructor_id, last_name,count(section_id)numSec
                    from section
                    right join instructor
                    using (instructor_id)
                    where instructor_id != 105
                    group by instructor_id, last_name
                    having count(section_id) < 10
                    )
                where numSec = 9;
    
    -- &IDI permite insertar los valores que se desean en la busqueda.
    
    select *
    from instructor
    where instructor_id = &IDI;
    
    -- Otras funciones agregadas AVG (para la media), MAX(Sacar el valor maximo), MIN(Sacar el valor minimo), SUM(sumar valores)
    
    -- coste maximo de los cursos
    
        select max (cost) 
            from course;
    -- listado de cursos que son prerequisito y el numero de cursos de los que son prerequisitos, donde el prerequisito no es null
    
        select prerequisite, count(prerequisite)
            from course
            where prerequisite is not null
            group by prerequisite
            order by prerequisite;
            
    -- Listado del nombre del prerequisito, y numero de cursos del que es prerequisito
        
         select c1.prerequisite, c2.description, count(c1.prerequisite) NumCursos
            from course c1
            join course c2
            on c1.prerequisite = c2.course_no
            --where c1.prerequisite is not null
            group by c1.prerequisite, c2.description
            order by c1.prerequisite;
    
    -- coste minimo, maximo o medio de aquellos grupos que se agrupan
    
        select c1.prerequisite, c2.description, c2.cost, count(c1.course_no) NumCursos, min (c1.cost), max (c1.cost), avg(c1.cost), sum (c1.cost)
            from course c1
            join course c2
            on c1.prerequisite = c2.course_no
            group by c1.prerequisite, c2.description, c2.cost
            order by c1.prerequisite;
    
    --SUBQUERY
    
    -- listado de alumnos que se hayan matriculado en un numero de secciones mayor que el numero medio de secciones en los que se han matriculado los alumnos
  
select student_id, numSec
  from (  
    select student_id, count(*)numSec
    from enrollment
    group by student_id
    );
    
    --Alumnos que están matrículados en un número de secciones mayor
    --que el número medio de secciones en las que están matrículados los alumnos.
--Cuenta el número de secciones.
select student_id, count(section_id)
    from enrollment
    group by student_id
    having count(section_id)>1;
    
--Intermedio con round para redondear. trunq para truncar.
select round(avg(cursos),2)
    from (
        select count(section_id) cursos
            from enrollment
            group by student_id
         );
    
select round(avg(count(*)),2) MediaCursos
    from enrollment
    group by student_id;
    
--Where no vale porque debe estar en la tabla lo que se compare, así que filtrar con Having para grupos, etc
--Usable en mi proyecto, media de torneos por jugador.
--El calculo de la query y subquery es siempre lo mismo en cada línea.
select student_id,last_name --count(section_id)
    from enrollment
    join student using (student_id)
    group by student_id, last_name
    having count(section_id)>(
    --SUBQUERY
        select round(avg(count(*)),2) MediaCursos
            from enrollment
            group by student_id
            );

--Listado de las secciones en las que se haya matrículado un numero de alumnos 
--igual al máximo número de alumnos que se haya matrículado en alguna seccion
--Secciones en las que sea = el numero maximo de alumnos.(El que mas es FOL con 10, pues todas las secciones con 10).

select section_id,location,capacity, count(*) NumEstudiantes
    from enrollment
    join section using(section_id)
    group by section_id, location, capacity
    having count(section_id) = (
        select max(count(*)) NumEstudiantes
            from enrollment
            group by section_id);

--Secciones el n de matriculados es = o mayor que la capacity
            
 select section_id, capacity,(count(*)) NumMatric
        from enrollment
        join section using(section_id)
        group by section_id, capacity
        having count(student_id) >= capacity;

--VIVI MI AMOLSITO
select id_zona, id_habitat, capacidad, count(*)
    from z_subespecie
    join z_animal
    using(id_especie,id_subespecie)
    join z_recinto
    using(id_zona,id_habitat)
    group by id_zona, id_habitat, capacidad
    having count (id_especie) > capacidad;


--Plazas libres de la seccion
 select section_id, (capacity-(count(*))) NumPlazas
        from enrollment
        join section using(section_id)
        group by section_id, capacity
        order by section_id;
        
--Lista plazas libres de cada curso. Suma de plazas libres 
    
select description,(sum(capacity)-(count(*))) PlazasLibres
    from section
    join course
    using(course_no)
    group by description;

--Capacidad secciones mejorado, tirando de valores de la principal

select section_id
from enrollment e
group by (section_id)
having count (*) >= (
    select capacity
        from section
        where secition_id=e.section_id
        );
        
--Transformar fecha

select TRUNC((sysdate - to_date('&FN', 'DD/MM/YYYY'))/365.25) "Edad de Pepe"
    from dual;


--Lista de alumnos que tengan una nota = a alguna de las notas de los alumnos que viven en estado de NY.
--Los que no sean de NY claro men, y puede que tambien elegir el estudiante de que seccion tiene eso.
--También los distintos tipos de nota. El & pide datos en ese sitio.
 --distinct agrupa
 
 select student_id,grade_type_code, count (*) "Veces con misma nota"
    from grade
    join student using (student_id)
    join zipcode using (zip)
    where section_id = &SectionID and state != 'NY' and numeric_grade in (
        select numeric_grade
            from grade
            join student using (student_id)
            join zipcode using (zip)
            where state = 'NY'
            )
    group by student_id, grade_type_code
    order by student_id;
    --order by numeric_grade;
        
        
--Listado de alumnos que han sacado en una sección la máxima nota que se ha obtenido en esa sección.

 select distinct student_id, section_id, numeric_grade
    from grade e
    where section_id = &SectionID and numeric_grade in (
        select max(numeric_grade)
        from grade
        where section_id = e.section_id
        )
    order by student_id;   
    
select distinct student_id, section_id, numeric_grade
    from grade e
    where numeric_grade in (
        select max(numeric_grade)
        from grade
        where section_id = e.section_id
        )
    order by section_id;
    

--UPDATE, INSERT Y DELETE IGUAL QUE UPDATE.
    
INSERT INTO "USU1"."DEPARTAMENTO" 
    (ID_DPTO, NOMBRE, FECHA_CREACION, PRESUPUESTO) VALUES 
        ('&IdDPTO', 
        '&Nombre', 
         SYSDATE, 
         NULL);
         
INSERT INTO "USU1"."DEPARTAMENTO" 
    (ID_DPTO, NOMBRE, FECHA_CREACION) VALUES 
        (TO_CHAR(SYSDATE,'YYYY')||'/'||DPTO.nextval, 
        '&Nombre', 
         SYSDATE);

SELECT TO_CHAR(to_date('&DIA/&MES/&AÑO', 'DD/MM/YYYY')) FROM DUAL;
SELECT TO_CHAR(SYSDATE,'DD/YYYY') FROM DUAL;

SELECT TO_CHAR(FECHA_CREACION, 'HH24:MI') FROM departamento;


UPDATE "DEPARTAMENTO" 
    SET PRESUPUESTO = PRESUPUESTO+&PRTO --AUMENTAR EL SUELDO POR EJ
    WHERE ID_DPTO = '&IDD'; --UPDATES CON FILTRO O PUEDE LIARSE CAMBIANDO TODO
    
UPDATE "DEPARTAMENTO" 
    SET PRESUPUESTO = PRESUPUESTO+PRESUPUESTO*&PORC/100; --PORCENTAJE DE AUMETO DE SUELDO A TODOS.
    
    
--PONER NOTA FINAL DEL ALUMNO, LISTADO DE ESTUDIANTES CON NOTA FINAL EN CADA SECCION TENIENDO EN CUENTA EL PESO DE LA NOTA.
select student_id, section_id,  sum(round(media)) MEDIA
from (
    select student_id, section_id, AVG(numeric_grade)*percent_of_final_grade/100 media, grade_type_code
            from grade 
            join grade_type_weight
            using (section_id, grade_type_code)
            group by student_id,section_id,percent_of_final_grade,grade_type_code
        )
    group by student_id, section_id
    order by student_id;
    
--Clase del viernes
select distinct section_id, last_name
    from grade
    join section s
    using (section_id)
    join student
    using (student_id)
    where course_no = &CN
        and (numeric_grade) in
        (
        select max(numeric_grade)
            from grade
            join section
            using (section_id)
            where course_no = s.course_no
        )
        ;
--Número de alumnos que tienen una nota igual a la mínima nota.

select section_id, numeric_grade, count(student_id) NumAlum
    from student
    join grade
    using (student_id)
    where numeric_grade in (
        select distinct min(numeric_grade)
        from grade)
    group by section_id, numeric_grade, student_id
    order by section_id;
    
        --Correción   
        
        select count(*)
            from (
            select count (distinct student_id)
                from grade
                where numeric_grade = (select min(numeric_grade)
                from grade)
                group by student_id
                );
    
--Listado de la nota media de cada estudiante

select student_id, round(avg(numeric_grade), 2)
    from grade
    group by student_id;
    
--Listado de estudiantes con su nota final en cada section

select numeric_grade, grade_type_code
    from grade
    where student_id = &Student_id
        and section_id = &Section_id
        order by grade_type_code;
        
--HERENCIA
--DOS TABLA USANDO UNION

select num_serie, sum(memoria)
    from portatil2
    UNION
    select num_serie,sum(memoria)
    from sobremesa2;

      
--Derrotas totales
select Jugadores, sum(Derrotas)Derrotas
    from(
select id_jugador_1 Jugadores, count(*)Derrotas
    from partidas
    where resultado=1
    group by id_jugador_1
    UNION ALL
select id_jugador_2, count(*)Derrotas
    from partidas
    where resultado=2
    group by id_jugador_2)
    group by Jugadores;
    
