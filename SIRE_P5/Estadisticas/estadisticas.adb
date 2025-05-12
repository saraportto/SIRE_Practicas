with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure estadisticas is

   type Array_Numeros is array (Integer range <>) of Float;
   N : Integer;

   -- Mínimo y Máximo del array
   procedure MinMax(N: Array_Numeros; Min, Max: out Float) is
   begin
      Min := N(N'First);
      Max := N(N'First);
      for I in N'Range loop
         if N(I) < Min then
            Min := N(I);
         end if;
         if N(I) > Max then
            Max := N(I);
         end if;
      end loop;
   end MinMax;

   -- Media
   function Media(N: Array_Numeros) return Float is
      Sum : Float := 0.0;
   begin
      for I in N'Range loop
         Sum := Sum + N(I);
      end loop;
      return Sum / Float(N'Length);
   end Media;

   -- Varianza
   function Varianza(N: Array_Numeros; Media : Float) return Float is
      Sum : Float := 0.0;
   begin
      for I in N'Range loop
         Sum := Sum + (N(I) - Media)**2;
      end loop;
      return Sum / Float(N'Length);
   end Varianza;

begin
   -- Leer N con manejo de errores
   loop
      Put("Ingrese la cantidad de números: ");
      begin
         Get(N);
         exit when N > 0;
         Put_Line("Por favor, ingrese un número entero positivo.");
      exception
         when Data_Error =>
            Put_Line("Error: debe ingresar un número entero válido.");
            Skip_Line;
      end;
   end loop;

   declare
      Numeros : Array_Numeros(1 .. N);
      Minimo, Maximo, Promedio, Var : Float;
   begin
      -- Leer los números con validación
      for I in Numeros'Range loop
         loop
            Put("Ingrese el número" & Integer'Image(I) & ": ");
            begin
               Get(Numeros(I));
               exit;
            exception
               when Data_Error =>
                  Put_Line("Error: debe ingresar un número real válido. Intente de nuevo.");
                  Skip_Line;
            end;
         end loop;
      end loop;

      -- Calcular estadísticas
      MinMax(Numeros, Minimo, Maximo);
      Promedio := Media(Numeros);
      Var := Varianza(Numeros, Promedio);

      -- Mostrar resultados
      New_Line;
      Put_Line("Resultados:");
      Put_Line("Mínimo: " & Float'Image(Minimo));
      Put_Line("Máximo: " & Float'Image(Maximo));
      Put_Line("Media:  " & Float'Image(Promedio));
      Put_Line("Varianza: " & Float'Image(Var));
   end;
end estadisticas;
