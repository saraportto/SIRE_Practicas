with Ada.Text_IO; use Ada.Text_IO;

procedure Bounded_Buffer is

   protected type Buffer is
      procedure Insertar(D: in Integer);
      procedure Extraer(D: out Integer);
   private
      Dato : Integer := 0;
   end Buffer;

   protected body Buffer is
      --Dato: Integer := 0;
         --when Dato = 0 =>
         procedure Insertar(D: in Integer) is
         begin
            Dato:= D;
            Put_Line("Insertado " & Integer'Image(D));
         end Insertar;

         --when Dato /= 0 =>
         procedure Extraer(D : out Integer) is
         begin
            D := Dato;
            Dato:=0;
            Put_Line("Extraído " & Integer'Image(D));
         end Extraer;
    end Buffer;


   B : Buffer;

    task type Productor;
    task type Consumidor;
    
    task body Productor is
    begin
        for I in 1 .. 3 loop
            delay 2.0;
            B.Insertar(I);
        end loop;
    end Productor;

    task body Consumidor is
        V : Integer;
    begin
        for I in 1 .. 3 loop
            delay 1.5;
            B.Extraer(V);
        end loop;
    end Consumidor;
    
    P : Productor;
    C : Consumidor;

begin
    Put_Line("=== PRODUCER CONSUMER PROBLEM ===");
    delay 6.0;

end Bounded_Buffer;
