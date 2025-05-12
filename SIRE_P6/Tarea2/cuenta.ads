-- IMPORTS
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;

-- CUENTA
package Cuenta is

   type Cuenta_Bancaria is record
      Titular : Unbounded_String;
      Saldo   : Float := 0.0;
   end record;

   function Crear(Titular : Unbounded_String; Saldo : Float) return Cuenta_Bancaria;
   --procedure Depositar(C : in out Cuenta_Bancaria; Valor : Float);
  -- procedure Retirar(C : in out Cuenta_Bancaria; Valor : Float);
   --function Consultar_Saldo(C : Cuenta_Bancaria) return Float;
   function Consultar_Titular(C : Cuenta_Bancaria) return Unbounded_String;
	   
 
   task type Tarea_Depositar is
      entry Realizar_Deposito (C : in out Cuenta_Bancaria; Monto : in Float);
   end Tarea_Depositar;

   task type Tarea_Retirar is
      entry Realizar_Retiro (C : in out Cuenta_Bancaria; Monto : in Float);
   end Tarea_Retirar;

   task type Tarea_Consultar_Saldo is
      entry Consultar_Saldo (C : in Cuenta_Bancaria);
   end Tarea_Consultar_Saldo;
   
end Cuenta;
