-- IMPORTS
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Cuenta;
with Banco;

use Ada.Text_IO;
use Ada.Strings.Unbounded;
use Cuenta;
use Banco;


-- MAIN
procedure Main is
   B : Banco_Tipo;
   C1, C2, C3, C4, C5, C6 : Cuenta_Bancaria;

begin
   -- crear banco
   B := Crear_Banco;

   -- crear cuentas iniciales
   C1 := Crear(To_Unbounded_String("Cuenta1"), 1000.0);
   C2 := Crear(To_Unbounded_String("Cuenta2"), 500.0);
   C3 := Crear(To_Unbounded_String("Cuenta3"), 300.0);
   C4 := Crear(To_Unbounded_String("Cuenta4"), 650.0);
   C5 := Crear(To_Unbounded_String("Cuenta5"), 10.0);
   C6 := Crear(To_Unbounded_String("Cuenta6"), 20000.0);

   -- agregar las cuentas al banco
   Agregar_Cuenta(B, C1);
   Agregar_Cuenta(B, C2);
   Agregar_Cuenta(B, C3);
   Agregar_Cuenta(B, C4);
   Agregar_Cuenta(B, C5);
   Agregar_Cuenta(B, C6);

   -- transferencias 
   Transferir(B, To_Unbounded_String("Cuenta1"), To_Unbounded_String("Cuenta2"), 200.0);
   Transferir(B, To_Unbounded_String("Cuenta4"), To_Unbounded_String("Cuenta5"), 100.0);

   -- consultar y mostrar saldos cuentas
   Put_Line("Saldo Cuenta1: " & Float'Image(Consultar_Saldo(Consultar_Cuenta(B, To_Unbounded_String("Cuenta1")))));
   Put_Line("Saldo Cuenta2: " & Float'Image(Consultar_Saldo(Consultar_Cuenta(B, To_Unbounded_String("Cuenta2")))));
   Put_Line("Saldo Cuenta3: " & Float'Image(Consultar_Saldo(Consultar_Cuenta(B, To_Unbounded_String("Cuenta3")))));
   Put_Line("Saldo Cuenta4: " & Float'Image(Consultar_Saldo(Consultar_Cuenta(B, To_Unbounded_String("Cuenta4")))));
   Put_Line("Saldo Cuenta5: " & Float'Image(Consultar_Saldo(Consultar_Cuenta(B, To_Unbounded_String("Cuenta5")))));
   Put_Line("Saldo Cuenta6: " & Float'Image(Consultar_Saldo(Consultar_Cuenta(B, To_Unbounded_String("Cuenta6")))));

   -- consultar y mostrar saldo banco
   Put_Line("Saldo total del banco: " & Float'Image(Consultar_Saldo_Banco(B)));
end Main;
