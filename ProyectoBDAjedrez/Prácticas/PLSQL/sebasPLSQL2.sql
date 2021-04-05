SET SERVEROUTPUT ON SIZE UNLIMITED;

----------------------------------------------

--Recibir ID de alumno y devolver el last_name con la funcion.
CREATE OR REPLACE FUNCTION
    apellido(ID number)
    return varchar2
as
    v_apellido varchar2(25);
BEGIN
    select last_name
        into v_apellido
        from student
        where student_id = ID;
    return v_apellido;
    
EXCEPTION
 when no_data_found then
    raise_application_error(-20001,'El estudiante no existe.');--Levanta el error -20001 y en el PL/SQL, en exceptions levanta el mensaje de error si es el mismo.
END;
/
DECLARE
 v_ID student.last_name%type;
BEGIN
    v_ID := '&ID'; --Varchar y comillas para que entre la letra y pueda saltar el error.
    
        dbms_output.put_line('El apellido del estudiante ' || v_ID || ' es ' || apellido(v_ID));
EXCEPTION
    when value_error then
        dbms_output.put_line('La ID debe ser un numero.');
    when others then
        if sqlcode = -20001 then
            dbms_output.put_line(substr(sqlerrm,12));--Pinta el mensaje del error.
        end if;
END;
/

--20001 no 

--NOMBRE COMPLETO DEL ALUMNO Y SU SALUTATION, USANDO CURSORES
DECLARE
cursor c_nombreCompleto is
select salutation, first_name, last_name
    from student;
    saludo student.salutation%type;
    nombre varchar(25);
    apellido varchar(25);

BEGIN
    OPEN c_nombreCompleto;
    LOOP
    FETCH c_nombreCompleto into saludo, nombre, apellido;
    exit when c_nombreCompleto%NOTFOUND;
    dbms_output.put_line(saludo||nombre||' '||apellido);
    END LOOP;
    close c_nombreCompleto;
END;
/

--Mostrar mediante un cursor el curso, su descripcion, coste y nombre del
--profesor que lo imparte para los cursos número 10, 20 y 25, al igual que el
--importe total de la suma de estos cursos(MEJORADO).
DECLARE
CURSOR sumacoste1 is
select course_no, description,cost,instructor_id
    from course join section using(course_no)
    where course_no=10 or course_no=20 or course_no=25;
    
v_curso course.course_no%type;
v_description course.description%type;
v_cost course.cost%type;
v_instructor instructor.instructor_id%type;
v_nombreins instructor.first_name%type;
v_suma integer :=0;

BEGIN
open sumacoste1;
        loop
            fetch sumacoste1 into v_curso,v_description,v_cost,v_instructor;
            exit when sumacoste1%notfound;
            
            select first_name
                into v_nombreins
                from instructor
                where instructor_id=v_instructor;
            
                dbms_output.put_line(v_curso||' '||v_description||' '||v_cost|| ' impartido por '||v_nombreins);
                
            v_suma := v_suma+v_cost;
        end loop;
            
            dbms_output.put_line('El coste total es igual a '||v_suma);
        close sumacoste1;
end;
/


--SACAR EL NOMBRE DEL ESTUDIANTE CON MAS DE 2 SECCIONES MATRICULADAS Y LAS SECCIONES MATRICULADAS.

--Procedure que sacará la ID, Nombre, Apellido y Seccion de la ID Alumno que reciba.
CREATE OR REPLACE PROCEDURE matriculados(
    p_student_id student.student_id%type)
AS
    v_id_student student.student_id%type;
    v_first_name student.first_name%type;
    v_last_name student.last_name%type;
    v_section_id enrollment.section_id%type;
    v_comprobarID student.student_id%type;
    

    cursor c_estudiante is
        select student_id,first_name,last_name, section_id
            from enrollment
            join student
            using(student_id)
            where student_id=p_student_id;
BEGIN
--Comprobación si existe o no.
    select student_id
        into v_comprobarID
        from student
        where student_id = p_student_id;

open c_estudiante;
loop
    fetch c_estudiante into v_id_student,v_first_name, v_last_name, v_section_id;
        exit when c_estudiante%NOTFOUND;
        dbms_output.put_line('El estudiante '||v_first_name||' '||v_last_name||' está en las seccion '||v_section_id);
end loop;
close c_estudiante;    
        
EXCEPTION
    when no_data_found then
        dbms_output.put_line('El estudiante con ID: '||p_student_id||', no esta matriculado en ninguna seccion.');
    when value_error then
        dbms_output.put_line('La ID debe ser un numero.');
    when others then
        dbms_output.put_line('ERROR');
END;
/

--PLSQ sacando las IDs de los Alumnos con más de 2 secciones matriculadas.
--Usando el Procedure para sacar todos sus datos en el Loop.
DECLARE
cursor c_IDs is
    select student_id
        from enrollment
        join student
        using(student_id)
        group by student_id
        having count(last_name)>1;
        
    v_student_id student.student_id%type;

BEGIN
open c_IDs;
loop
    fetch c_IDs into v_student_id;
    exit when c_IDs%NOTFOUND;
        matriculados(v_student_id);
end loop;
close c_IDs;
END;
/


--SACAR NOTA MEDIA DE LOS ALUMNOS.

DECLARE
    v_media number;
BEGIN
select avg(numeric_grade)
    into v_media 
    from grade
    join student
    using (student_id)
    join zipcode
    using (zip)
    where state = 'NY';
    
    if v_media is null then
        dbms_output.put_line('No hay datos.');
    else
        dbms_output.put_line('La media es: '||v_media);
    end if;
    
END;
/

select numeric_grade
    from grade
    join student
    using (student_id)
    join zipcode
    using (zip)
    where state = 'NY';

select avg(cost), sum(cost), count(*), count(cost), sum(NVL(cost,1198.448))/count(*)
    from course;
    
DECLARE
CURSOR c_media is
    select numeric_grade
        from grade
        join student
        using (student_id)
        join zipcode
        using (zip)
        where state = 'NY';

    v_numeric_grade number;
    v_suma number;
    v_num_notas number;
BEGIN
v_suma :=0;
v_num_notas :=0;
open c_media;
        fetch c_media into v_numeric_grade;
    while c_media%FOUND loop
        v_suma := v_suma + v_numeric_grade;
        v_num_notas := v_num_notas+1;
        fetch c_media into v_numeric_grade;
    end loop;
close c_media;    
            dbms_output.put_line('La media es: '||v_suma/v_num_notas);
            dbms_output.put_line('La suma es: '||v_suma);
EXCEPTION
    when zero_divide then
        dbms_output.put_line('No hay datos.');

END;
/

--Nota media estudiante seccion, cursor.
--Funcion entra ID de seccion y de estudiante.
CREATE OR REPLACE FUNCTION
    media(p_section_id grade.section_id%type,p_student_id grade.student_id%type)
    return number
as
    v_compruebasection grade.section_id%type;
    v_compruebastudent grade.student_id%type;
    v_nota_media grade.numeric_grade%type;
    v_existstudent boolean := false;
    v_existsection boolean := false;
    v_contador number :=0;
    v_media number :=0;
    
    cursor c_media is
        select numeric_grade
            from grade
            where student_id = p_student_id 
            and section_id = p_section_id;

BEGIN
--Comprueban que exista un numeric_grade asociado a esa seccion o estudiante.
select student_id
    into v_compruebastudent
    from grade
    where student_id = p_student_id;
v_existstudent := true;

select section_id
    into v_compruebasection
    from grade
    where section_id = p_section_id;
v_existsection := true;
    
select section_id, student_id
    into v_compruebasection, v_compruebastudent
    from grade
    where section_id = p_section_id
    and student_id = p_student_id;

open c_media;
    fetch c_media into v_nota_media;
    while c_media%FOUND loop
    v_media:= v_media+v_nota_media;
    v_contador := v_contador+1;
    fetch c_media into v_nota_media;
end loop;
close c_media;

v_media := v_media/v_contador;
return v_media;

EXCEPTION
    when no_data_found then
    if not v_existstudent then
            raise_application_error(-20001,'El estudiante ' || p_student_id||' no existe.');
    elsif not v_existsection then
        raise_application_error(-20002,'La seccion '||p_section_id||' no existe.');
    else
        raise_application_error(-20003,'El alumno no esta matriculado en esa seccion.');
    end if;
END;
/

BEGIN
    dbms_output.put_line('Media es: '|| media(&IDSeccion,&IDStudent));
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
