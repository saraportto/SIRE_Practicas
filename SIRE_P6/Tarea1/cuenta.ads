-- IMPORTS
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;


-- CUENTA
package Cuenta is

   type Cuenta_Bancaria is private;

   function Crear(Titular : Unbounded_String; Saldo : Float) return Cuenta_Bancaria;
   procedure Depositar(C : in out Cuenta_Bancaria; Valor : Float);
   procedure Retirar(C : in out Cuenta_Bancaria; Valor : Float);
   function Consultar_Saldo(C : Cuenta_Bancaria) return Float;
   function Consultar_Titular(C : Cuenta_Bancaria) return Unbounded_String;

private
   type Cuenta_Bancaria is record
      Titular : Unbounded_String;
      Saldo   : Float := 0.0;
   end record;

end Cuenta;
