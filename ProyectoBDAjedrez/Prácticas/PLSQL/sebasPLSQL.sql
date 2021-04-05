-------------------------------------
-- Comprobar si un numero es primo --
-------------------------------------
SET SERVEROUTPUT ON SIZE UNLIMITED;
--ESTÁ MAL.
DECLARE
    numero number := &num;
    resto number;
    contador number := 2;
    correcto boolean := true;
BEGIN
    while (correcto = true and contador <= (numero/2)) loop
        resto := mod(numero,contador);
        if (resto != 0) then
            correcto := false;
        end if;
        contador := contador + 1;
    end loop;
    if (correcto != true) then
        dbms_output.put_line('El numero ' || numero || ' es primo');
    else
        dbms_output.put_line('El numero ' || numero || ' no es primo');
    end if;
END;
/

----------------------------------------------------
-- Sucesion de Fibonacci (Insertar numero maximo) --
----------------------------------------------------
DECLARE
    n_max number := &num;
    fibonacci number := 1;
    fibonacci_antes number := 0;
    listaNumero varchar2(9999) := '';
    i number := 0;
    
BEGIN
    loop
        listaNumero := listaNumero || fibonacci || ', '; 
        fibonacci := fibonacci + fibonacci_antes;
        fibonacci_antes := fibonacci - fibonacci_antes;
        i := i+1;
        exit when i>=n_max;
    end loop;
    dbms_output.put_line(listaNumero);
END;
/

---------------------------
-- Funcion cuenta letras --
---------------------------
CREATE OR REPLACE FUNCTION cuentaLetras(cadena IN varchar2)
RETURN number IS
    letras number;
BEGIN
    letras := length(cadena);
    return letras;
END cuentaLetras;

DECLARE
    palabra varchar2(20) := &word;
    nLetras number;
BEGIN
    nLetras := cuentaletras(palabra => cadena);
    dbms_output.put_line(nLetras);
END;
/

--PRACTICAS

--AREA DEL CIRCULO A PARTIR DEL RADIO.
DECLARE
    PI CONSTANT NUMBER := 3.141592654;
    radio float := &radio;
    area float;
BEGIN
    area := round((PI*(power(radio,2))),2);
    dbms_output.put_line('El area es: ' || area);
END;
/

--SABER LA CANIDAD DE ALUMNOS MATRICULADOS EN UNA SECCION.
DECLARE
 v_matriculado number;
 p_section_id number := &ID;

Begin
    select count(*)
    into v_matriculado
    from enrollment
    where section_id = p_section_id;
    
    if v_matriculado=0 then
        dbms_output.put_line('La seccion '||p_section_id|| ' no tiene a nadie matriculado.');
    else
        dbms_output.put_line('La seccion tiene '||v_matriculado||' alumnos matriculados.');
    end if;
END;
/
      SET SERVEROUTPUT ON SIZE UNLIMITED;
--ESTUDIANTE DE UNA SECCION DADA(NO ES BUENA UNA ASÍ) o si hay más, con exception.
DECLARE
 v_student_id student.student_id%type; --PARA QUE COJA EL TIPO DIRECTAMENTE.
 p_section_id enrollment.section_id%type := &ID;

Begin
    select student_id
    into v_student_id
    from enrollment
    where section_id = p_section_id;
    
        dbms_output.put_line('El estudiante es '||v_student_id|| '.');

EXCEPTION        
 when too_many_rows then dbms_output.put_line('Hay mas de un estudiante en la seccion.');
 when no_data_found then dbms_output.put_line('No hay alumnos en ese seccion.');
END;
/

--INSTRUCTOR Y EL NUM DE SECCIONES QUE IMPARTE.
DECLARE
     v_inst_id instructor.instructor_id%type;
     v_instructor_last_name instructor.last_name%type;
     v_instructor_id instructor.instructor_id%type;
     v_numSec number;

BEGIN

    v_instructor_id := &instructor;
    
    -- Se saca la id del instructor para poder comparar con la id pedida 
    -- y saber si existe para la excepcion.
    select instructor_id
        into v_inst_id
        from instructor
        where instructor_id = v_instructor_id;
            
    select last_name, count(section_id)
        into v_instructor_last_name, v_numSec
        from section
        join instructor
        using(instructor_id)
        where instructor_id = v_instructor_id
        group by instructor_id, last_name; 
    
    dbms_output.put_line('El instructor '|| v_instructor_last_name || ' imparte en ' || v_numSec || ' secciones');
    
    EXCEPTION
        when no_data_found then
            IF v_instructor_id = v_inst_id then
              dbms_output.put_line('El instructor id ' || v_instructor_id || ' no imparte en ninguna seccion ');
              else
            dbms_output.put_line('El instructor id ' || v_instructor_id || ' no existe ');
              end if;
end;
/


--FUNCIONES
select 'hola', power(5,2), 5*5, suma01(5,2)*2
    from dual;
begin
    dbms_output.put_line(power(5,2)|| ' ' || suma01(5,2));
end;
/
declare
    v_potencia numeric;
begin
    v_potencia := power(5,2);

    dbms_output.put_line(v_potencia);
end;
/

--crear una funcion propia
-- siempre nombre y tipo de las de los parametros que se van a utilizar
create or replace function
    suma01(p_num1 int, p_num2 int)
    return int
as
    v_resultado int;
    begin
        v_resultado := p_num1 + p_num2;
        return v_resultado;
end;
/

--Funcion con numeros y alfa numericos

CREATE OR REPLACE FUNCTION
    calculo(p_num2 number, p_num3 number,p_signo char)
    return number
as
    v_resultado number;
BEGIN
case p_signo
    when '*' then v_resultado := p_num2 * p_num3;
    when '/' then v_resultado := p_num2 / p_num3;
    when '+' then v_resultado := p_num2 + p_num3; 
    when '-' then v_resultado := p_num2 - p_num3;
    when '^' then v_resultado := power(p_num2, p_num3);
    END CASE;
    return v_resultado;
END;
/
--CALCULADORA
select 'Calculadora', calculo(6,2,'+') suma,calculo(6,2,'-') resta, round(calculo(2,3,'/'),2) division
    from dual;
begin
    dbms_output.put_line(round(calculo(2,3,'/'),2));
    dbms_output.put_line(calculo(6,2,'*'));
    dbms_output.put_line(calculo(6,2,'^'));
end;
/


--FUNCIONES CON EXCEPCIONES
DECLARE
    v_resultado number;
    v_op1 number := &OP1;
    v_op2 number := &OP2;
    v_operador char(1) := '&OPERADOR';
BEGIN
    v_resultado := calculo(v_op1,v_op2,v_operador);
    dbms_output.put_line(v_resultado);
EXCEPTION
    when zero_divide then
        dbms_output.put_line('No se puede dividir por cero.');
    when CASE_NOT_FOUND then
        dbms_output.put_line('No es un operador valido.');
END;
/

---------------------------------------------------------------------------------------
--FUNCIONES CON QUERYS
--Aumento de costes.
DECLARE
    v_coste course.cost%type;
    v_num_curso course.course_no%type := &num_curso;
BEGIN

select NVL(cost,1000)
    into v_coste
    from course
    where course_no = v_num_curso;
    
        dbms_output.put_line('Se ha aumentado el precio del curso ' || v_num_curso || ' a ' || costes(v_coste));

EXCEPTION
    when no_data_found then
        dbms_output.put_line('El curso no existe.');
END;
/
CREATE OR REPLACE FUNCTION
    costes(p_num number)
    return number
as
    v_resultado number;
BEGIN
case 
    when p_num = 1195 then v_resultado := p_num * 1.30;
    when p_num > 1195 then v_resultado := p_num * 1.10;
    when p_num < 1195 then v_resultado := p_num * 1.50;
    END CASE;
    return v_resultado;
END;
/
-----------------------------------------------------------------

