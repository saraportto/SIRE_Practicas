# Práctica 8: Planificación


El objetivo de esta práctica es el de simular el comportamiento de un robot inteligente que actúe de manera que se adapte al entorno gracias a un planificador estratégico y otro táctico, que gestionen los estados, metas y acciones del robot según su prioridad.

---

El robot podrá captar distintos **estados** (booleanos) de su entorno. Estos estados se traducirán en **metas** específicas gracias a la planificación con el `Planificador_Estrategico`, que ordenará las metas por orden prioritario dentro de un array. 

Después, las metas se convertirán en **acciones** que se ejecutarán gracias al `Planificador_Tactico`. 

---

Nosotros implementamos dos nuevos sensores: `Cargador_Vacio`y `Enemigo_Detectado`; asociados a las metas `Cargar_Arma` y `Eliminar`, respectivamente. Estas metas dispararán las nuevas acciones `Recargar`y `Disparar`, en cada caso. 

Con ello, también cambiamos las prioridades para dotar a `Disparar` con la mayor prioridad.

---

Por lo tanto, los sensores, metas y accioesn quedarían de la siguiente manera (ordenados de mayor a menor prioridad):

| Estado (`Estado_Tipo`)                                     | Meta (`Meta_Tipo`) | Acción (`Accion_Tupla.Nombre`) | Prioridad (`Accion_Tupla.Prioridad`) |
| ---------------------------------------------------------- | ------------------ | ------------------------------ | ------------------------------------ |
| `Estado.Enemigo_Detectado = True`                          | `Eliminar`         | `Disparar`                     | `10`                                 |
| `Estado.Cargador_Vacio = True`                             | `Cargar_Arma`      | `Recargar`                     | `9`                                  |
| `Estado.Bateria_Baja = True`                               | `Cargar_Bateria`   | `Cargar`                       | `5`                                  |
| `Estado.Hay_Obstaculo = True`                              | `Evitar_Obstaculo` | `Girar`                        | `3`                                  |
| `Estado.Camino_Libre = True` and `not Estado.Bateria_Baja` | `Moverse`          | `Avanzar`                      | `1`                                  |


Además, la acción de `Esperar`, tiene la mínima prioridad (0) tal y como ocurría en el ejemplo base. 

---

La otra novedad que implementamos fueron las descargas de dos recursos: la batería y las balas del arma.

* La **batería** se descarga en un 30% en cada iteración. Si el nivel de batería está por debajo del 20%, se activa el estado de `Batería_Baja`.

* El número de **balas** disminuye en una unidad por cada vez que se ejecuta la acción `Disparar`. Cuando el cargador se quede sin balas, el estado `Cargador_Vacio` se activa.

---