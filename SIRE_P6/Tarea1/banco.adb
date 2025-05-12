-- IMPORTS
with Ada.Strings.Unbounded;
with Cuenta;
use Ada.Strings.Unbounded;
use Cuenta;

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

   -- TRANSFERIR
   procedure Transferir(B : in out Banco_Tipo; Origen, Destino : Unbounded_String; Cant : Float) is
      I_origen, I_dest : Integer := 0;
   begin
      -- busca índice origen y destino 
      for I in 1 .. B.Total loop
         if To_String(Cuenta.Consultar_Titular(B.Cuentas(I))) = To_String(Origen) then
            I_origen := I;
         elsif To_String(Cuenta.Consultar_Titular(B.Cuentas(I))) = To_String(Destino) then
            I_dest := I;
         end if;
      end loop;

      -- si NO se encuentra la cuenta  
      if I_origen = 0 or I_dest = 0 then
         raise Program_Error with "ERROR: No se ha encontrado la cuenta para la transferencia";
      end if;

      -- si el origen NO tiene saldo suficiente
      if Cuenta.Consultar_Saldo(B.Cuentas(I_origen)) < Cant then
         raise Program_Error with "ERROR: Saldo insuficiente en la cuenta";
      end if; 

      -- realizar la transferencia
      Cuenta.Retirar(B.Cuentas(I_origen), Cant);
      Cuenta.Depositar(B.Cuentas(I_dest), Cant);
   end Transferir;

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
         Total := Total + Cuenta.Consultar_Saldo(B.Cuentas(I));
      end loop;
      return Total;
   end Consultar_Saldo_Banco;

end Banco;

