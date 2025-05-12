-- IMPORTS
with Ada.Strings.Unbounded;
with Cuenta;
use Ada.Strings.Unbounded;
use Cuenta;

-- BANCO
package Banco is
   type Banco_Tipo is private;

   function Crear_Banco return Banco_Tipo;
   procedure Agregar_Cuenta(B : in out Banco_Tipo; C : Cuenta_Bancaria);
   function Consultar_Cuenta(B : Banco_Tipo; Titular : Unbounded_String) return Cuenta_Bancaria;
   function Consultar_Saldo_Banco(B : Banco_Tipo) return Float;
   
   task type Tarea_Transferir is
      entry Realizar_Transferencia (Desde, Hasta : in out Cuenta_Bancaria; Monto : in Float);
   end Tarea_Transferir;
   
private
   Max_Cuentas : constant Integer := 10;
   subtype Indice_Cuenta is Integer range 1 .. Max_Cuentas;

   type Lista_Cuentas is array (Indice_Cuenta) of Cuenta_Bancaria;

   type Banco_Tipo is record
      Cuentas : Lista_Cuentas;
      Total   : Integer := 0;
   end record;
end Banco;

