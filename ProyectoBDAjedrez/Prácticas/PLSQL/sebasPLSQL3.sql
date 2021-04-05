SET SERVEROUTPUT ON SIZE UNLIMITED;

--procedure de transferencias

--traspaso de jugadores

--Equipo --<Jugador ---<Traspaso>-- >--Equipo
--NumTrans, Fecha traspaso, trigger validar que este o no, trigger actualizar y se quede en el equipo destino, transferencia procedure.

/*
    procedimiento para hacer transferencias de una cuenta a otra
    tabla cuenta - id_cuenta nombre_titular y saldo
    queremos hacer transferencias entre dos cuentas de una cantidad
    recibira el id_cuenta_origen. id_cuenta_destino y cantidad a transferir
*/
create or replace procedure transferencia (
    p_id_cuenta_origen cuentas.id_cuenta%type, 
    p_id_cuenta_dest cuentas.id_cuenta%type,
    p_cantidad number
    )
as
    v_id_cuenta_origen cuentas.id_cuenta%type;
    v_id_cuenta_dest cuentas.id_cuenta%type;
    v_saldo_origen cuentas.saldo%type;
    v_cuenta_origen_existe boolean;
    v_cuenta_dest_existe boolean;
begin
    v_cuenta_origen_existe := false;
    v_cuenta_dest_existe := false;
    
    select id_cuenta  into v_id_cuenta_origen
        from cuentas
        where id_cuenta = p_id_cuenta_origen
        ;
    v_cuenta_origen_existe:=true;
    
    select id_cuenta  into v_id_cuenta_dest
        from cuentas
        where id_cuenta = p_id_cuenta_dest
        ;
    v_cuenta_dest_existe:=true;
    
    select saldo into v_saldo_origen
        from cuentas 
        where id_cuenta = p_id_cuenta_origen
        ;
    if (v_saldo_origen < p_cantidad) then
        raise_application_error(-20001, 'Saldo insuficiente');
    end if;
    -- Hasta aqui ya estan controlados todos los posibles errores para no hacer la transferencia
    
    UPDATE CUENTAS
    SET SALDO = SALDO - p_cantidad 
    WHERE id_cuenta = p_id_cuenta_origen
    ;
    UPDATE CUENTAS
    SET SALDO = SALDO + p_cantidad 
    WHERE id_cuenta = p_id_cuenta_dest
    ;
exception
    when no_data_found then
        if (not v_cuenta_origen_existe) then
            raise_application_error(-20002, 'No existe la cuenta origen');
        elsif (not v_cuenta_dest_existe) then
            raise_application_error(-20003, 'No existe la cuenta destino');
        else
            raise_application_error(-20004, 'Error no esperado');
        end if;
end;
/

/*
    Bloque plsql para probar el funcionamiento del procedure transferencias
*/
declare
    v_id_cuenta_origen cuentas.id_cuenta%type;
    v_id_cuenta_dest cuentas.id_cuenta%type;
    v_cantidad number;
begin
    v_id_cuenta_origen := &origen;
    v_id_cuenta_dest := &dest;
    v_cantidad := &cant;
    
    transferencia(v_id_cuenta_origen, v_id_cuenta_dest, v_cantidad);
    DBMS_OUTPUT.PUT_LINE('Transferencia correcta');
exception
    when others then
        DBMS_OUTPUT.PUT_LINE(SUBSTR(sqlerrm, 12));
end;
/



/*
* PROCEDURE de transferencia
*/

set serveroutput on

create or replace procedure transferencia02 (
    p_id_cuenta_o cuentas.id_cuenta%type,
    p_id_cuenta_d cuentas.id_cuenta%type,
    p_cantidad number,
    p_empleado transfer.empleado%type
    )
as
begin
    UPDATE CUENTAS
    SET SALDO = SALDO - p_cantidad 
    WHERE id_cuenta = p_id_cuenta_o
    ;
    INSERT INTO TRANSFER (
        NUMERO, 
        ID_CUENTA_DEST, 
        ID_CUENTA_ORIGEN, 
        CANTIDAD, 
        EMPLEADO, 
        FECHA) VALUES (
        sequence_cuenta.nextval,
        p_id_cuenta_o,
        p_id_cuenta_d,
        p_cantidad, 
        p_empleado,
        sysdate);
    UPDATE CUENTAS
    SET SALDO = SALDO + p_cantidad 
    WHERE id_cuenta = p_id_cuenta_dest
    ;
end;
/

--TRASPASO DE JUGADORES Y SUS TRIGGERS
create or replace TRIGGER TRASPASO_JUGADOR 
BEFORE INSERT OR UPDATE OF ID_CLUB_LLEGADA,ID_CLUB_SALIDA,N_FEDERACION ON F_TRASPASOS 
    FOR EACH ROW
DECLARE
 v_id_jugador f_jugadores.n_federacion%type;
 v_id_equipo f_jugadores.id_club%type;
BEGIN
select n_federacion, id_club
    into v_id_jugador, v_id_equipo
    from f_jugadores
    where n_federacion = :new.n_federacion and id_club = :new.id_club_salida;

EXCEPTION
    WHEN no_data_found THEN
        raise_application_error(-20223,'Error, El jugador no está en el equipo origen.');
    WHEN OTHERS THEN
        RAISE;
END;
/

create or replace procedure traspaso (
    p_id_traspaso f_traspasos.id_traspaso%type,
    p,_n_federacion f_traspasos.n_federacion%type,
    p_id_club_salida f_traspasos.id_club_salida%type,
    p_id_club_llegada f_traspasos.id_club_llegada%type
    )
as
begin
    INSERT INTO F_TRASPASOS (
        id_traspaso, 
        n_federacion, 
        id_club_salida, 
        id_club_llegada, 
        FEC_TRASPASO) VALUES (
        p_id_traspaso,
        p_n_federacion,
        p_id_club_salida,
        p_id_club_llegada,
        sysdate);
end;
/
create or replace TRIGGER TRASPASO_JUGADOR 
AFTER INSERT OR UPDATE OF ID_CLUB_LLEGADA,ID_CLUB_SALIDA,N_FEDERACION ON F_TRASPASOS 
    FOR EACH ROW
BEGIN
Update f_jugadores
    set id_club = :new.id_club_llegada
    where n_federacion = :new.n_federacion;
END;
/


Begin
traspaso('2','10','Beti','Sevi');
End;
/
-------------------------------------------------------------

--Hacer tablas factura, factura,articulo,lineas de factura, sacar todas las lineas de la factura, sacar el total de la factura, hacer el total de ganancia
set serveroutput on
declare
    p_id_factura f_detalle.id_factura%type:='&idi';
    
  cursor c_factura is
        select linea,id_producto,descripcion,cantidad,precio_unitario,precio
            from f_detalle
            join f_producto
            using(id_producto)
            where id_factura=p_id_factura;
            
p_linea f_detalle.linea%type;
p_producto f_detalle.id_producto%type;
p_descrip f_producto.descripcion%type;
p_cant f_detalle.cantidad%type;
p_precio f_detalle.precio%type;
p_unit f_producto.precio_unitario%type;
            
p_nombre_cli f_cliente.nombre_o_cif%type;
p_fecha f_factura.fecha%type;

begin
    select nombre_o_cif,fecha
        into p_nombre_cli,p_fecha
        from f_factura
        join f_cliente
        using(id_cliente)
        where id_factura=p_id_factura;
        
    dbms_output.put_line('N? FACTURA: '||p_id_factura||' CLIENTE: '||p_nombre_cli||' FECHA: '||p_fecha);
    
open c_factura;

FETCH c_factura into p_linea,p_producto,p_descrip,p_cant,p_unit,p_precio;

while c_factura%found loop

     dbms_output.put_line('Linea: '||p_linea||' Cod.Producto: '||p_producto||' Descripcion: '||p_descrip||' Cantidad: '||p_cant||' P.Unitario: '||p_unit||' Total: '||p_precio);
     
FETCH c_factura into p_linea,p_producto,p_descrip,p_cant,p_unit,p_precio;

end loop;

close c_factura;

exception
    when no_data_found then
        dbms_output.put_line('No hay datos para esa factura');
    when others then
        dbms_output.put_line('Error de ejecucion');
end;
/

 /*       select linea,id_producto,descripcion,cantidad,precio
            from f_detalle
            join f_producto
            using(id_producto)
            where id_factura='F1';
*/
create or replace trigger validacion_factura
before insert on f_detalle
for each row
declare
v_factura f_factura.id_factura%type;
begin
    select id_factura
        into v_factura
        from f_factura
        where id_factura=:new.id_factura;
EXCEPTION
    when no_data_found then
        dbms_output.put_line('La factura asociada a esa lineano existe');
end;
/

------------------------------------------------------------------------

SET SERVEROUTPUT ON SIZE UNLIMITED;

--Herencia personal, clase personal = nacional y extranjero, 
--id, nombre
--el ext, el pa?s y el nac, especialidad
--a tres tablas, campo tipo char 1, N o E
--""Metodo"" funcion, calc sueldo del personal
--cursor recorra el sueldo total del personal
--metodo nacional, segun especialidad, es tecnico, 1500, administracion son 1000
--los extranjeros, depende del pa?s, canada UK, eeuu, inglaterra pues 2000, y otros 1800

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

--FUNCION DE CALCULO DE SUELDO A EXTRANJERO
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