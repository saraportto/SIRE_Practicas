with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure MiniAgenda is

   type Contacto is record
      Nombre  : String(1..10);
      Telefono: String(1..12);
      Email   : String(1..15);
   end record;

   type Agenda is array (1..10) of Contacto;
   Lista_Contactos : Agenda;
   Total_Contactos : Integer := 0;

   procedure Anadir_Contacto is
      Nuevo_Contacto : Contacto;
   begin
      if Total_Contactos < 10 then
         Put_Line("Ingrese el nombre (10 caracteres): ");
         Get(Nuevo_Contacto.Nombre);
         Put_Line("Ingrese el teléfono (12 caracteres): ");
         Get(Nuevo_Contacto.Telefono);
         Put_Line("Ingrese el email (15 caracteres): ");
         Get(Nuevo_Contacto.Email);

         Total_Contactos := Total_Contactos + 1;
         Lista_Contactos(Total_Contactos) := Nuevo_Contacto;
         Put_Line("Contacto añadido");
      else
         Put_Line("Agenda llena. No se pueden añadir más contactos");
      end if;
   end Anadir_Contacto;

   procedure Buscar_Contacto is
      Nombre_Buscar : String(1..10);
      Encontrado    : Boolean := False;
   begin
      Put_Line("Ingrese el nombre a buscar (10 caracteres): ");
      Get(Nombre_Buscar);
      
      for I in 1 .. Total_Contactos loop
         if Lista_Contactos(I).Nombre = Nombre_Buscar then
            Put_Line("");
            Put_Line("Contacto encontrado:");
            Put_Line("Nombre: " & Lista_Contactos(I).Nombre);
            Put_Line("Teléfono: " & Lista_Contactos(I).Telefono);
            Put_Line("Email: " & Lista_Contactos(I).Email);
            Put_Line("");
            Encontrado := True;
         end if;
      end loop;
      
      if not Encontrado then
         Put_Line("Contacto no encontrado.");
      end if;
   end Buscar_Contacto;

   procedure Mostrar_Contactos is
   begin
      if Total_Contactos = 0 then
         Put_Line("La agenda está vacía.");
      else
         for I in 1 .. Total_Contactos loop
            Put_Line("----------------------------");
            Put_Line("Contacto " & Integer'Image(I));
            Put_Line("Nombre: " & Lista_Contactos(I).Nombre);
            Put_Line("Teléfono: " & Lista_Contactos(I).Telefono);
            Put_Line("Email: " & Lista_Contactos(I).Email);
            Put_Line("");
         end loop;
      end if;
   end Mostrar_Contactos;

   Opcion : Integer;
begin
   loop
      Put_Line("Mini Agenda - Opciones:");
      Put_Line("1. Añadir Contacto");
      Put_Line("2. Buscar Contacto");
      Put_Line("3. Mostrar Todos los Contactos");
      Put_Line("4. Salir");
      Put("Seleccione una opción: ");
      Get(Opcion);
      Skip_Line;
      
      case Opcion is
         when 1 => Anadir_Contacto;
         when 2 => Buscar_Contacto;
         when 3 => Mostrar_Contactos;
         when 4 => 
            Put_Line("Saliendo del programa...");
            exit;
         when others =>
            Put_Line("Opción no válida, intente nuevamente.");
      end case;
   end loop;
end MiniAgenda;
