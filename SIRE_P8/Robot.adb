with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

-- ROBOT
procedure Robot is

   -------- TIPOS --------

   -- TIPOS DE ESTADOS
   type Estado_Tipo is record
      Hay_Obstaculo     : Boolean := False;
      Camino_Libre      : Boolean := False;
      Bateria_Baja      : Boolean := False;
      Enemigo_Detectado : Boolean := False;
      Cargador_Vacio    : Boolean := False;  
   end record;

   -- METAS del ROBOT
   type Meta_Tipo is (Evitar_Obstaculo, Moverse, Cargar_Bateria, Eliminar, Cargar_Arma, Ninguna);
   type Metas_Array is array (1 .. 5) of Meta_Tipo;

   -- ACCIÓN (nombre + prioridad)
   type Accion_Tupla is record
      Nombre    : Unbounded_String;
      Prioridad : Integer;
   end record;

   -- ACCIONES priorizadas
   type Acciones_Array is array (1 .. 5) of Accion_Tupla;


   -------- PROTEGIDOS --------

   -- ACCIONES protegidas
   protected type Acciones_Protegidas is
      procedure Guardar(Acciones : in Acciones_Array);
      procedure Obtener(Acciones : out Acciones_Array);
      procedure Resetear;
   private
      Internas : Acciones_Array := (others => (To_Unbounded_String("Esperar"), 0));
   end Acciones_Protegidas;

   protected body Acciones_Protegidas is

      -- guardar (acciones en el array)
      procedure Guardar(Acciones : in Acciones_Array) is
      begin
         Internas := Acciones;
      end Guardar;

      -- obtener (acciones ordenadas por prioridad)
      procedure Obtener(Acciones : out Acciones_Array) is
         Temp : Acciones_Array := Internas;
         Tmp  : Accion_Tupla;
      begin
         for I in Temp'First .. Temp'Last - 1 loop
            for J in I + 1 .. Temp'Last loop
               if Temp(J).Prioridad > Temp(I).Prioridad then
                  Tmp := Temp(I);
                  Temp(I) := Temp(J);
                  Temp(J) := Tmp;
               end if;
            end loop;
         end loop;
         Acciones := Temp;
      end Obtener;

      -- resetear (todas las acciones a "Esperar")
      procedure Resetear is
      begin
         for I in Internas'Range loop
            Internas(I) := (To_Unbounded_String("Esperar"), 0);
         end loop;
      end Resetear;

   end Acciones_Protegidas;


   -- BATERÍA protegida
   protected type Bateria_Segura is
      procedure Descargar(Porcentaje : in Float);
      procedure Cargar(Porcentaje : in Float);
      function Obtener return Float;
   private
      Nivel : Float := 100.0;
   end Bateria_Segura;

   protected body Bateria_Segura is

      -- descargar bat
      procedure Descargar(Porcentaje : in Float) is
      begin
         Nivel := Nivel - Porcentaje;
         if Nivel < 0.0 then
            Nivel := 0.0;
         end if;
      end Descargar;

      -- cargar bat
      procedure Cargar(Porcentaje : in Float) is
      begin
         Nivel := Nivel + Porcentaje;
         if Nivel > 100.0 then
            Nivel := 100.0;
         end if;
      end Cargar;

      -- obtener bat
      function Obtener return Float is
      begin
         return Nivel;
      end Obtener;

   end Bateria_Segura;


   -- CARGARDOR protegido
   protected type Cargador_Arma is
      procedure Disparar;
      procedure Recargar;
      function Obtener return Integer;
   private
      Balas : Integer := 5;
   end Cargador_Arma;

   protected body Cargador_Arma is

      -- disparar balas
      procedure Disparar is
      begin
         if Balas > 0 then
            Balas := Balas - 1;
         end if;
      end Disparar;

      -- recargar balas
      procedure Recargar is
      begin
         Balas := 5;
      end Recargar;

      -- obtener balas
      function Obtener return Integer is
      begin
         return Balas;
      end Obtener;
   end Cargador_Arma;


   -------- TAREAS: PLANIFICADORES --------

   -- PLANIFICADOR ESTRATÉGICO: evalúa estado --> determina metas
   task type Planificador_Estrategico is
      entry Evaluar(Estado : in out Estado_Tipo; Metas : out Metas_Array);
   end Planificador_Estrategico;

   task body Planificador_Estrategico is
   begin
      loop
         select
            accept Evaluar(Estado : in out Estado_Tipo; Metas : out Metas_Array) do
               Metas := (Ninguna, Ninguna, Ninguna, Ninguna, Ninguna);
               if Estado.Bateria_Baja then
                  Metas(2) := Cargar_Bateria;
               end if;
               if Estado.Hay_Obstaculo then
                  Metas(3) := Evitar_Obstaculo;
               end if;
               if Estado.Camino_Libre then
                  Metas(4) := Moverse;
               end if;
               if Estado.Enemigo_Detectado then
                  Metas(1) := Eliminar;
               end if;
               if Estado.Cargador_Vacio then
                  Metas(5) := Cargar_Arma;
               end if;
            end Evaluar;
         or
            terminate;
         end select;
      end loop;
   end Planificador_Estrategico;


   -- PLANIFICADOR TÁCTICO: evalúa metas --> determina acciones
   task type Planificador_Tactico(Acc : access Acciones_Protegidas) is
      entry Planear(Metas : in Metas_Array; Estado : in Estado_Tipo);
   end Planificador_Tactico;

   task body Planificador_Tactico is
      Acciones : Acciones_Array := (others => (To_Unbounded_String("Esperar"), 0));
   begin
      loop
         select
            accept Planear(Metas : in Metas_Array; Estado : in Estado_Tipo) do
               Acciones := (others => (To_Unbounded_String("Esperar"), 0));
               for I in Metas'Range loop
                  case Metas(I) is
                     when Cargar_Bateria =>
                        if Estado.Bateria_Baja then
                           Acciones(1) := (To_Unbounded_String("Cargar"), 5);
                        end if;
                     when Evitar_Obstaculo =>
                        if Estado.Hay_Obstaculo then
                           Acciones(2) := (To_Unbounded_String("Girar"), 3);
                        end if;
                     when Moverse =>
                        if Estado.Camino_Libre and not Estado.Bateria_Baja then
                           Acciones(3) := (To_Unbounded_String("Avanzar"), 1);
                        end if;
                     when Eliminar =>
                        if Estado.Enemigo_Detectado then
                           Acciones(4) := (To_Unbounded_String("Disparar"), 10);
                        end if;
                     when Cargar_Arma =>
                        if Estado.Cargador_Vacio then
                           Acciones(5) := (To_Unbounded_String("Recargar"), 9);
                        end if;
                     when others =>
                        null;
                  end case;
               end loop;
               Acc.all.Guardar(Acciones);
            end Planear;
         or
            terminate;
         end select;
      end loop;
   end Planificador_Tactico;


   -------- DECLARACIONES --------
   Acc    : aliased Acciones_Protegidas;
   Bateria : aliased Bateria_Segura;
   Cargador : aliased Cargador_Arma;
   PE     : Planificador_Estrategico;
   PT     : Planificador_Tactico(Acc'Access);


   -------- TAREAS: ACCIONES --------

   -- AVANZAR
   task Avanzar is
      entry Ejecutar;
   end Avanzar;

   task body Avanzar is
   begin
      loop
         select
            accept Ejecutar do
               Put_Line("EJECUTANDO: Avanzar"); delay 1.0;
            end Ejecutar;
         or
            terminate;
         end select;
      end loop;
   end Avanzar;


   -- GIRAR
   task Girar is
      entry Ejecutar;
   end Girar;

   task body Girar is
   begin
      loop
         select
            accept Ejecutar do
               Put_Line("EJECUTANDO: Girar"); delay 1.0;
            end Ejecutar;
         or
            terminate;
         end select;
      end loop;
   end Girar;


   -- CARGAR BATERÍA
   task Cargar is
      entry Ejecutar;
   end Cargar;

   task body Cargar is
   begin
      loop
         select
            accept Ejecutar do
               Put_Line("EJECUTANDO: Cargar batería");
               delay 1.0;
               Bateria.Cargar(100.0);  
            end Ejecutar;
         or
            terminate;
         end select;
      end loop;
   end Cargar;


   -- RECARGAR BATERÍA
   task Recargar is
      entry Ejecutar;
   end Recargar;

   task body Recargar is
   begin
      loop
         select
            accept Ejecutar do
               Put_Line("EJECUTANDO: Recargar arma");
               delay 1.0;
               Cargador.Recargar; 
            end Ejecutar;
         or
            terminate;
         end select;
      end loop;
   end Recargar;


   -- DISPARAR
   task Disparar is
      entry Ejecutar;
   end Disparar;

   task body Disparar is
   begin
      loop
         select
            accept Ejecutar do
               Put_Line("EJECUTANDO: Disparar");
               delay 1.0;
               Cargador.Disparar;
            end Ejecutar;
         or
            terminate;
         end select;
      end loop;
   end Disparar;


   -------- TAREA PRINCIPAL --------

   -- ROBOT
   task Robot;
   task body Robot is
      Estado   : Estado_Tipo;
      Metas    : Metas_Array;
      Acciones : Acciones_Array;
   begin
      -- simulación de 10 iteraciones
      for I in 1 .. 10 loop
         declare
            V : Integer := I mod 6;
         begin
            case V is -- varias situaciones simuladas
               when 0 => Estado := (True, False, False, False, False);
               when 1 => Estado := (False, True, False, True, False);
               when 2 => Estado := (False, False, False, False, False);
               when others => Estado := (True, True, False, True, False);
            end case;
         end;
         
         -- batería baja --> activa estado de BATERÍA BAJA
         if Bateria.Obtener < 20.0 then
            Estado.Bateria_Baja := True;
         else
            Estado.Bateria_Baja := False;
         end if;

         -- cargador vacío --> activa estado de CARGADOR VACÍO
         if Cargador.Obtener = 0 then
            Estado.Cargador_Vacio := True;
         else
            Estado.Cargador_Vacio := False;
         end if;

         -- estado del robot
         Put_Line("");
         Put_Line("----------------------");
         Put_Line("DETECTANDO estado...");
         Put_Line("  Obstáculo: " & Boolean'Image(Estado.Hay_Obstaculo));
         Put_Line("  Camino libre: " & Boolean'Image(Estado.Camino_Libre));
         Put_Line("  Batería baja: " & Boolean'Image(Estado.Bateria_Baja));
         Put_Line("  Enemigo detectado: " & Boolean'Image(Estado.Enemigo_Detectado));
         Put_Line("  Cargador vacío: " & Boolean'Image(Estado.Cargador_Vacio));
         Put_Line("  Batería: " & Float'Image(Bateria.Obtener) & "%");
         Put_Line("  Balas: " & Integer'Image(Cargador.Obtener));

         -- planificador estratégico --> metas
         PE.Evaluar(Estado, Metas);
         Put_Line("METAS determinadas:");
         for I in Metas'Range loop
            Put_Line("  Meta " & Integer'Image(I) & ": " & Meta_Tipo'Image(Metas(I)));
         end loop;

         -- planificador táctico --> acciones
         PT.Planear(Metas, Estado);
         delay 0.2;

         -- acciones a ejecutat
         Acc.Obtener(Acciones);

         for I in Acciones'Range loop
            declare
               Nombre : constant String := To_String(Acciones(I).Nombre);
            begin
               exit when Nombre = "Esperar";
               if Nombre = "Avanzar" then
                  Avanzar.Ejecutar;
               elsif Nombre = "Girar" then
                  Girar.Ejecutar;
               elsif Nombre = "Cargar" then
                  Cargar.Ejecutar;
               elsif Nombre = "Disparar" then
                  Disparar.Ejecutar;
               elsif Nombre = "Recargar" then
                  Recargar.Ejecutar;
               end if;
            end;
         end loop;

         -- resetear accioness
         Acc.Resetear;

         -- simula descarga de batería
         Bateria.Descargar(30.0);
         delay 0.5;
      end loop;
   end Robot;

begin
   null;
end Robot;

