-- IMPORTS
with Ada.Strings.Unbounded;
with Cuenta;
use Ada.Strings.Unbounded;
use Cuenta;
with Ada.Text_IO; use Ada.Text_IO;

-- BANCO
package body Banco is


   -- CREAR BANCO
   function Crear_Banco return Banco_Tipo is
      B : Banco_Tipo;
   begin
      return B;
   end Crear_Banco;


   -- AGREGAR CUENTA
   procedure Agregar_Cuenta(B : in out Banco_Tipo; C : Cuenta_Bancaria) is
   begin
      -- cuentas no superan el max (10) --> añade
      if B.Total < Max_Cuentas then
         B.Total := B.Total + 1;
         B.Cuentas(B.Total) := C;
      else
         -- error en caso contrario
         raise Program_Error with "ERROR: Banco lleno";
      end if;
   end Agregar_Cuenta;


   -- TAREA: TRANSFERIR
   task body Tarea_Transferir is
   begin
      accept Realizar_Transferencia (Desde, Hasta : in out Cuenta_Bancaria; Monto : in Float) do
         -- realizar la transferencia
         if Desde.Saldo >= Monto then
            Desde.Saldo := Desde.Saldo - Monto;
            delay 2.0;
            Hasta.Saldo := Hasta.Saldo + Monto;
            Put_Line("Transferencia realizada de " & Float'Image(Monto));
         else
            Put_Line("Saldo insuficiente para la transferencia");
         end if;
      end Realizar_Transferencia;
   end Tarea_Transferir;
   

   -- CONSULTAR CUENTA
   function Consultar_Cuenta(B : Banco_Tipo; Titular : Unbounded_String) return Cuenta_Bancaria is
   begin
      -- busca índice de la cuenta por titular
      for I in 1 .. B.Total loop
         if To_String(Cuenta.Consultar_Titular(B.Cuentas(I))) = To_String(Titular) then
            return B.Cuentas(I);
         end if;
      end loop;

      -- si no se encuentra cuenta por nombre
      raise Program_Error with "ERROR: Cuenta no encontrada";
   end Consultar_Cuenta;


   -- CONSULTAR SALDO BANCO
   function Consultar_Saldo_Banco(B : Banco_Tipo) return Float is
      Total : Float := 0.0;
   begin
      -- suma saldo de cada cuenta del banco
      for I in 1 .. B.Total loop
         Total := Total + B.Cuentas(I).Saldo;
      end loop;
      return Total;
   end Consultar_Saldo_Banco;


end Banco;

