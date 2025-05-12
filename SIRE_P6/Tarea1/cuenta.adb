-- IMPORTS
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;


-- CUENTA
package body Cuenta is

   -- CREAR
   function Crear(Titular : Unbounded_String; Saldo : Float) return Cuenta_Bancaria is
      C : Cuenta_Bancaria;

   begin
      C.Titular := Titular;
      C.Saldo := Saldo;
      return C;
   end Crear;


   -- DEPOSITAR
   procedure Depositar(C : in out Cuenta_Bancaria; Valor : Float) is
   
   begin
      C.Saldo := C.Saldo + Valor;
   end Depositar;


   -- RETIRAR
   procedure Retirar(C : in out Cuenta_Bancaria; Valor : Float) is
   
   begin
      if C.Saldo >= Valor then
         C.Saldo := C.Saldo - Valor;
      else
         raise Program_Error with "Saldo insuficiente para retirar.";
      end if;
   end Retirar;


   -- CONSULTAR SALDO
   function Consultar_Saldo(C : Cuenta_Bancaria) return Float is
   
   begin
      return C.Saldo;
   end Consultar_Saldo;


   -- CONSULTAR TITULAR
   function Consultar_Titular(C : Cuenta_Bancaria) return Unbounded_String is
   
   begin
      return C.Titular;
   end Consultar_Titular;


end Cuenta;
