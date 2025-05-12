-- IMPORTS
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;


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


-- CONCURRENTES ---------------------------------------------------------
   
   -- TAREA: DEPÓSITO
   task body Tarea_Depositar is
   begin
      -- depósito
      accept Realizar_Deposito (C : in out Cuenta_Bancaria; Monto : in Float) do
         delay 2.0;
         C.Saldo := C.Saldo + Monto;
         Put_Line("Depósito realizado de " & Float'Image(Monto));
      end Realizar_Deposito;
   end Tarea_Depositar;


   -- TAREA: RETIRAR
   task body Tarea_Retirar is
   begin
      -- retiro
      accept Realizar_Retiro (C : in out Cuenta_Bancaria; Monto : in Float) do
         -- comprobar que el saldo es suficiente
         if C.Saldo >= Monto then
            C.Saldo := C.Saldo - Monto;
            Put_Line("Retiro realizado de " & Float'Image(Monto));
         else
            Put_Line("Saldo insuficiente para el retiro");
         end if;
      end Realizar_Retiro;

   end Tarea_Retirar;


   -- TAREA: CONSULTAR SALDO
   task body Tarea_Consultar_Saldo is
   begin
      -- consulta saldo
      accept Consultar_Saldo (C : in Cuenta_Bancaria) do
		   Put_Line("Saldo de " & To_String(C.Titular) & ": " & Float'Image(C.Saldo));
      end Consultar_Saldo;

   end Tarea_Consultar_Saldo;

-- CONCURRENTES ---------------------------------------------------------
  

   -- CONSULTAR TITULAR
   function Consultar_Titular(C : Cuenta_Bancaria) return Unbounded_String is
   
   begin
      return C.Titular;
   end Consultar_Titular;


end Cuenta;
