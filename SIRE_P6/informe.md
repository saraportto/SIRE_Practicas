# Informe de aportación de la Tarea 2 respecto a la Tarea 1 (concurrencia)

La tarea 2 incorpora concurrencia mediante tareas (tasks), permitiendo simular operaciones bancaria de forma simultánea (y no secuencialmente como ocurría en la tarea 1). A pesar de ello, se trata de un sistema muy simple y poco intensivo computacionalmente en el que es imposible observar correctamente el efecto de la concurrencia.

Par ello, se sustituyeron los procedimientos `Depositar`, `Retirar` y `Transferir` por `Tarea_Depositar`, `Tarea_Retirar` y `Tarea_Transferir`; y la función de `Consultar_Saldo` se sustituyó por la `Tarea_Consultar_Saldo`.

Además, para poder ver los efectos de la incorporación de las tareas, se introdujeron algunos `delay`en operaciones como depósiot o la transferencia.


## Cambios realizados en `Cuenta`
Primero, se cambió la estructura del tipo `Cuenta_Bancaria` a un tipo público para poder acceder directamente a los atributos de la clase sin necesidad de llamar a funciones. 


Aquí las funciones y procedimientos `Depositar`, `Retirar` y `Consultar_Saldo` se sustituyeron por tareas concurrentes. 

Por ejemplo, `Tarea_Depositar` pasa de definirse de la siguiente manera en la Tarea 1:
```ada
procedure Depositar(C : in out Cuenta_Bancaria; Valor : Float);
```

```ada
procedure Depositar(C : in out Cuenta_Bancaria; Valor : Float) is

begin
    C.Saldo := C.Saldo + Valor;
end Depositar;
```

A ser en la tarea 2 así:
```ada
task type Tarea_Depositar is
      entry Realizar_Deposito (C : in out Cuenta_Bancaria; Monto : in Float);
   end Tarea_Depositar;
```

```ada
task body Tarea_Depositar is
begin
    -- depósito
    accept Realizar_Deposito (C : in out Cuenta_Bancaria; Monto : in Float) do
        delay 2.0; --delay para simular retrasos
        C.Saldo := C.Saldo + Monto;
        Put_Line("Depósito realizado de " & Float'Image(Monto));
    end Realizar_Deposito;
end Tarea_Depositar;
```

El uso de sincronización mediante `entry` y `accecpt` introduce un procedimiento bloqueante, que evita que haya conflictos entre tareas concurrentes (como por ejemplo, que no se consulte un saldo hasta no haber terminado operaciones de retiro de dinero).


## Cambios realizados en `Banco`
Primero, se simplificó la estructura de transferencia bancaria entre cuentas, permitiendo introducir directamente las cuentas bancarias en vez de el nombre del titular. También se cambian algunas llamadas a consultas de saldo, sustituyéndolas por accesos al valor del saldo para evitar interbloqueos y poder acceder al saldo. 

Después, como ocurría en `Cuenta`, se cambia la estructura del procedimiento `Transferir` por una `Tarea_Transferir` que opera de forma concurrente con sincronización mediante `accept` y `entry`.


## Cambios realizados en el `Main`
En la Tarea 2 hay tareas independientes creadas al principio del Main (D1, D2 para depósitos, R1, R2 para retiros, T1, T2 para transferencias y S1, S2, ... para consultas de saldos). Estas tareas son lanzadas en el body mediante llamadas a sus `entry`, y operan en paralelo.