with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

procedure adivinanza is
   Generador : Generator;
   Numero, Intento, Intentos : Integer;
   
begin
   --Números aleatorios
   Reset(Generador);
   --Genera un numero aleatorio entre 0 y 1
   Numero := Integer(Float(Random(Generador)) * 100.0) + 1;
   Intentos := 0;
   
   Put_Line("Juego de adivinanza!");
   Put_Line("Intenta adivinar un número del 1 al 100.");
   
   loop
      Put("Ingresa tu número: ");
      Get(Intento);
      Intentos := Intentos + 1;
      
      if Intento < Numero then
         Put_Line("El número es mayor.");
      elsif Intento > Numero then
         Put_Line("El número es menor.");
      else
         Put_Line("¡Correcto! Has adivinado el número en " & Integer'Image(Intentos) & " intentos.");
         exit;
      end if;
   end loop;
end adivinanza;
