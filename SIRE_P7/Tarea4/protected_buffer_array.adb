with Ada.Text_IO; use Ada.Text_IO;

procedure Protected_Buffer_Array is

   Buffer_Size : constant := 5;
   type Buffer_Array is array (1 .. Buffer_Size) of Integer;
   
   -- === OBJETO PROTEGIDO SIMPLE ===
   protected type Buffer is
      entry Insertar(D : in Integer);
      entry Extraer(D : out Integer);
   private
      Datos  : Buffer_Array;
      N_Etos : Integer := 0;
   end Buffer;

   protected body Buffer is

      entry Insertar(D : in Integer) when N_Etos < Buffer_Size is
      begin
         Datos(N_Etos + 1) := D;
         N_Etos := N_Etos + 1;
         Put_Line("Insertado " & Integer'Image(D) &
                  ", N_Etos=" & Integer'Image(N_Etos));
      end Insertar;

      entry Extraer(D : out Integer) when N_Etos > 0 is
      begin
         D := Datos(1);
         for I in 1 .. N_Etos - 1 loop
            Datos(I) := Datos(I + 1);
         end loop;
         N_Etos := N_Etos - 1;
         Put_Line("Extraído  " & Integer'Image(D) &
                  ", N_Etos=" & Integer'Image(N_Etos));
      end Extraer;

   end Buffer;

   -- Instancia del buffer protegido
   B : Buffer;

   -- === TAREAS ===
   task type Productor;
   task type Consumidor;

   task body Productor is
   begin
      for I in 1 .. 10 loop
         delay 0.5;
         B.Insertar(I);
      end loop;
   end Productor;

   task body Consumidor is
      V : Integer;
   begin
      for I in 1 .. 10 loop
         delay 1.5;
         B.Extraer(V);
      end loop;
   end Consumidor;

   P : Productor;
   C : Consumidor;

-- === MAIN ===
begin
   Put_Line("=== BUFFER LIMITADO CON OBJETO PROTEGIDO SIMPLE (5) ===");
   delay 20.0;
end Protected_Buffer_Array;

