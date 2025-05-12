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
   D1, D2 : Tarea_Depositar;
   R1, R2 : Tarea_Retirar;
   T1, T2 : Tarea_Transferir;
   S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12 : Tarea_Consultar_Saldo;
   
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

	-- Consultar saldos
	S7.Consultar_Saldo(C1);
	S8.Consultar_Saldo(C2);
	S9.Consultar_Saldo(C3);
	S10.Consultar_Saldo(C4);
	S11.Consultar_Saldo(C5);
	S12.Consultar_Saldo(C6);
	
   -- Depositos
 	D1.Realizar_Deposito(C1, 200.0);
  	D2.Realizar_Deposito(C2, 150.0);
	 
   -- Retiros
   R1.Realizar_Retiro(C3, 50.0);
	R2.Realizar_Retiro(C4, 100.0);

   -- Transferencias
   T1.Realizar_Transferencia(C1, C6, 10.0);
	T2.Realizar_Transferencia(C2, C4, 150.0);
   
   -- Consultar saldos
   S1.Consultar_Saldo(C1);
	S2.Consultar_Saldo(C2);
   S3.Consultar_Saldo(C3);
   S4.Consultar_Saldo(C4);
   S5.Consultar_Saldo(C5);
   S6.Consultar_Saldo(C6);

end Main;
