# Documentación sobre la Mini Agenda

### Tipos de datos
El programa contiene los siguientes tipos de datos:


* `Contacto`:
  * De tipo `record`
  * Contiene: un **nombre** (string de 10 caracteres), un **teléfono** (string de 12 caracteres), y un **email** (string de 15 caracteres)

* `Lista_Contactos`:
  * De tipo `Agenda`, que es un array de 10 contactos


* `Total_Contactos`:
  * Indica el número de contactos en `Lista_Contactos`

---

### Procedimientos

* Prodecimiento `Añadir_Contactos` 
  * Crea un nuevo contacto a partir del nombre, teléfono y email que lee por teclado, y lo añade a `Lista_Contactos`

* Procedimiento `Buscar_Contacto`: 
  * Lee por teclado un nombre
  * Luego, recorre secuencialmente el array `Lista_Contactos`, comparando los nombres de los contactos existentes con el nombre que leyó
  *  Si el nombre coincide, muestra los datos sobre ese contacto

* Procedimiento `Mostrar_Contactos`: 
  * Este procedimiento simplemente recorre `Lista_Contactos` y para cada contacto, muestra su información


---

### `Main`
* Muestra un menú de 4 opciones por pantalla, y lee la opción que introduce el usuario. 

* Luego, con un `case`, llama al procedimiento correspondiente a dicha opción. 

* El bucle se repite hasta que se introduce la opción 4 (Salir).