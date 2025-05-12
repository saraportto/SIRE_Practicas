# Tarea 1
Responder a las preguntas planteadas en la práctica.

---
---

## Ejercicio: Uso tareas sincronizadas simples

**¿Qué sucede si el bucle que se encuentra en el Productor es de 2 en vez de 3? Razonar la respuesta.**

No se haría el tercer extraer, ya que se quedaría esperando en la cola hasta que hubiese un elemento insertado (que no llegará nunca).

---
---

## Ejercicio: Uso tareas sincronizadas con selección

**¿Qué sucede si el bucle que se encuentra en el Productor es de 2 en vez de 3 o si el delay en el Productor aumenta a 2.0? Razonar la respuesta.**

Se extraería un 0 en la tercera iteración; lo cual no es correcto ya que el buffer está vacío y estaríamos extrayendo un valor. Pero en este caso se evitaría la cola.

---
---

## Ejercicio: Uso tareas sincronizadas con selección, guardas y temporización

**¿Qué sucede si el bucle que se encuentra en el Productor es de 2 en vez de 3? ¿Termina en algún momento?**

Cada segundo que pase sin que se haya insertado un elemento para poder extraer, se imprimiría el mensaje de `Esperando actividad...`. Por lo que al no recibir ningún a insertar, no se extraería ningún elemento y el mensaje se estaría mostrando indefinidamente cada segundo.

---
---

## Ejercicio: Uso tareas sincronizadas con selección, guardas, temporización y terminación

**¿Qué sucede si se añade a la tarea buffer lo siguiente?:**
```ada
or
    -- Si no hay actividad en el buffer, esperar 1 segundo
    delay 1.0;
    Put_Line("Esperando actividad...");
```

Se produciría un error de compilación, indicando que no pueden coexistir terminate y una opción con delay en la misma sentencia de select.

La salida del error es la siguiente:

```bash
$ gnatmake producer_consumer.adb 

aarch64-linux-gnu-gcc-10 -c producer_consumer.adb
producer_consumer.adb:14:13: at most one of terminate or delay alternative
gnatmake: "producer_consumer.adb" compilation error
```
---
---