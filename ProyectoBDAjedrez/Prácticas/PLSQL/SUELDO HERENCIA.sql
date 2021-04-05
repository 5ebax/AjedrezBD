SET SERVEROUTPUT ON SIZE UNLIMITED;

--Herencia personal, clase personal = nacional y extranjero, 
--id, nombre
--el ext, el país y el nac, especialidad
--a tres tablas, campo tipo char 1, N o E
--""Metodo"" funcion, calc sueldo del personal o no funcion, a saber, hay que sacar todos
--cursor recorra el sueldo total del personal
--metodo nacional, segun especialidad, es tecnico, 1500, administracion son 1000
--los extranjeros, depende del país, canada UK, eeuu, inglaterra pues 2000, y otros 1800

--SIN FUNCIONES
DECLARE
    cursor c_personal is 
        select id_personal,nombre, tipo
            from p_personal;
               
    v_tipo p_personal.tipo%type;
    v_id_personal p_personal.id_personal%type;
    v_especialidad p_nacional.especialidad%type;
    v_nombre p_personal.nombre%type;
    v_pais p_extranjero.pais%type;
    v_sueldo numeric;
    v_sueldoTotal numeric :=0;
BEGIN
open c_personal;
fetch c_personal into v_id_personal,v_nombre, v_tipo;
while c_personal%FOUND loop

if v_tipo = 'N' then
    select especialidad
        into v_especialidad
        from p_nacional
        where id_personal = v_id_personal;
    case 
        when v_especialidad='tecnico' then v_sueldo := 1500;
        when v_especialidad='administracion' then v_sueldo := 1500;
    end case;
    dbms_output.put_line('Personal: '||v_nombre||'  ID:'||v_id_personal||' Sueldo: '||v_sueldo);
    v_sueldoTotal := v_sueldoTotal+v_sueldo;
    
elsif v_tipo = 'E' then
    select pais
        into v_pais
        from p_extranjero
        where id_personal = v_id_personal;
    case 
        when v_pais='EEUU' or v_pais='CA' or v_pais='UK' then v_sueldo := 2000;
        else v_sueldo := 1800;
    end case;
    dbms_output.put_line('Personal: '||v_nombre||'  ID:'||v_id_personal||' Sueldo: '||v_sueldo);
    v_sueldoTotal := v_sueldoTotal+v_sueldo;
end if;
fetch c_personal into v_id_personal,v_nombre, v_tipo;
end loop;
close c_personal;

    dbms_output.put_line('Sueldo total: '||v_sueldoTotal);

EXCEPTION
when no_data_found then
    dbms_output.put_line('ERROR');
END;
/


--CON FUNCIONES
DECLARE
    cursor c_personal is 
        select id_personal,nombre, tipo
            from p_personal;
               
    v_tipo p_personal.tipo%type;
    v_id_personal p_personal.id_personal%type;
    v_especialidad p_nacional.especialidad%type;
    v_nombre p_personal.nombre%type;
    v_pais p_extranjero.pais%type;
    v_sueldo numeric;
    v_sueldoTotal numeric :=0;
BEGIN
open c_personal;
fetch c_personal into v_id_personal,v_nombre, v_tipo;
while c_personal%FOUND loop

if v_tipo = 'N' then
    dbms_output.put_line('Personal: '||v_nombre||'  ID:'||v_id_personal||' Sueldo: '||sueldo_nacional(v_id_personal));
    v_sueldo := sueldo_nacional(v_id_personal);
    v_sueldoTotal := v_sueldoTotal+v_sueldo;
    
elsif v_tipo = 'E' then
    dbms_output.put_line('Personal: '||v_nombre||'  ID:'||v_id_personal||' Sueldo: '||sueldo_extranjero(v_id_personal));
    v_sueldo := sueldo_extranjero(v_id_personal);
    v_sueldoTotal := v_sueldoTotal+v_sueldo;
end if;
fetch c_personal into v_id_personal,v_nombre, v_tipo;
end loop;
close c_personal;

    dbms_output.put_line('Sueldo total: '||v_sueldoTotal);

EXCEPTION
when no_data_found then
    dbms_output.put_line('ERROR');
END;
/

--FUNCION DE CALCULO DE SUELDO A NACIONAL
CREATE OR REPLACE FUNCTION SUELDO_NACIONAL (
    v_id_personal p_personal.id_personal%type
    ) return numeric
AS
cursor c_personal is 
        select tipo
            from p_personal;
               
    v_tipo p_personal.tipo%type;
    v_especialidad p_nacional.especialidad%type;
    v_sueldo numeric;
BEGIN
open c_personal;
fetch c_personal into v_tipo;
while c_personal%FOUND loop

if v_tipo = 'N' then
    select especialidad
        into v_especialidad
        from p_nacional
        where id_personal = v_id_personal;
    case 
        when v_especialidad='tecnico' then v_sueldo := 1500;
        when v_especialidad='administracion' then v_sueldo := 1000;
    end case;
    return v_sueldo;
end if;
fetch c_personal into v_tipo;
end loop;
close c_personal;
EXCEPTION
when no_data_found then
    raise_application_error(-20121,'NO EXISTE LA ID O ES EXTRANJERO.');
END;
/

--FUNCION DE CALCULO DE SUELDO A ETRANJERO
CREATE OR REPLACE FUNCTION SUELDO_EXTRANJERO(
    v_id_personal p_personal.id_personal%type
    ) return numeric
AS
cursor c_personal is 
        select tipo
            from p_personal;
               
    v_tipo p_personal.tipo%type;
    v_pais p_extranjero.pais%type;
    v_sueldo numeric;
BEGIN
open c_personal;
fetch c_personal into v_tipo;
while c_personal%FOUND loop

if v_tipo = 'E' then
    select pais
        into v_pais
        from p_extranjero
        where id_personal = v_id_personal;
    case 
        when v_pais='EEUU' or v_pais='CA' or v_pais='UK' then v_sueldo := 2000;
        else v_sueldo := 1800;
    end case;
    return v_sueldo;
end if;
fetch c_personal into v_tipo;
end loop;
close c_personal;
EXCEPTION
when no_data_found then
    raise_application_error(-20122,'NO EXISTE LA ID O NO ES EXTRANJERO.');
END;
/

--FUNCION DE CALCULO DE SUELDO A ETRANJERO
CREATE OR REPLACE FUNCTION SUELDO(
    v_id_personal p_personal.id_personal%type
    ) return numeric
AS
cursor c_personal is 
        select tipo
            from p_personal;
               
    v_tipo p_personal.tipo%type;
    v_especialidad p_nacional.especialidad%type;
    v_nombre p_personal.nombre%type;
    v_pais p_extranjero.pais%type;
    v_sueldo numeric;
BEGIN
open c_personal;
fetch c_personal into v_tipo;
while c_personal%FOUND loop

if v_tipo = 'N' then
    select especialidad
        into v_especialidad
        from p_nacional
        where id_personal = v_id_personal;
    case 
        when v_especialidad='tecnico' then v_sueldo := 1500;
        when v_especialidad='administracion' then v_sueldo := 1500;
    end case;
    return v_sueldo;
elsif v_tipo = 'E' then
    select pais
        into v_pais
        from p_extranjero
        where id_personal = v_id_personal;
    case 
        when v_pais='EEUU' or v_pais='CA' or v_pais='UK' then v_sueldo := 2000;
        else v_sueldo := 1800;
    end case;
    return v_sueldo;
end if;
fetch c_personal into v_tipo;
end loop;
close c_personal;
EXCEPTION
when no_data_found then
    raise_application_error(-20123,'NO EXISTE LA ID.');
END;
/

begin
dbms_output.put_line(sueldo_nacional('P2'));
dbms_output.put_line(sueldo_extranjero('P2'));
end;
/