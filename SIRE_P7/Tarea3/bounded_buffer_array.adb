with Ada.Text_IO; use Ada.Text_IO;

procedure Bounded_Buffer_Array is
   
   Buffer_Size : constant := 5;

   task type Buffer is
      entry Insertar(D: in Integer);
      entry Extraer(D: out Integer);
   end Buffer;

   task body Buffer is
      Datos   : array (1 .. Buffer_Size) of Integer;
      N_etos  : Integer := 0;
   begin
      loop

         select  -- PASO 1. AÑADIMOS SELECT-OR
            when N_etos < Buffer_Size =>  -- PASO 2. CONDICIONES DE ENTRADA
               accept Insertar(D: in Integer) do
                  Datos(N_etos + 1) := D;
                  N_etos := N_etos + 1;
                  Put_Line("Insertado " & Integer'Image(D) &
                           ", N_etos=" & Integer'Image(N_etos));
               end Insertar;

         or  -- PASO 1. AÑADIMOS SELECT-OR
            when N_etos > 0 =>  -- PASO 2. CONDICIONES DE ENTRADA
               accept Extraer(D: out Integer) do
                  D := Datos(1);
                  for I in 1 .. N_etos - 1 loop
                     Datos(I) := Datos(I + 1);
                  end loop;
                  N_etos := N_etos - 1;
                  Put_Line("Extraído  " & Integer'Image(D) &
                           ", N_etos=" & Integer'Image(N_etos));
               end Extraer;

         --or  -- PASO 3. TEMPORIZACIÓN
         -- espera un segundo en este caso
            --delay 1.0;
            --Put_Line("Esperando actividad..."); -- PROBLEMA porque esta tarea sigue en escucha

         or  -- PASO 4. TERMINACIÓN
            terminate; -- se termina de inmediato cuando las otras hayan terminado
         
         end select;
      end loop;
   end Buffer;

   B : Buffer;

   task type Productor;
   task type Consumidor;

   -- PRODUCER
   task body Productor is
   begin
      for I in 1 .. 10 loop
         delay 0.5;
         B.Insertar(I);
      end loop;
   end Productor;

   -- CONSUMER
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

-- MAIN
begin
   Put_Line("=== PRODUCER-CONSUMER BUFFER LIMITADO (5) ===");
   delay 20.0;
end Bounded_Buffer_Array;
