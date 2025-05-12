#include <stdio.h>
#include "reloj_reloj.h"
#include <stdbool.h>

int main() {
bool hora_signal = false, minuto_signal = false, segundo_signal = false;
int nueva_hora = 12, nuevo_minuto = 0, nuevo_segundo = 0;
int tiempo = 0;
char opcion;

reloj_reloj_ctx_type reloj_ctx; // Contexto del nodo ABRO
reloj_reloj_ctx_reset(&reloj_ctx); // Inicializar el contexto


while (true) {
printf("\n--- Reloj ---\n");
printf("1. Cambiar hora\n");
printf("2. Cambiar minutos\n");
printf("3. Cambiar segundos\n");
printf("4. Mostrar tiempo transcurrido desde mediodía\n");
printf("5. Salir\n");
printf("Seleccione una opción: ");
scanf(" %c", &opcion);

switch (opcion) {
case '1':
	printf("Introduzca la nueva hora (0-23): ");
	scanf("%d", &nueva_hora);
	while(nueva_hora > 23 || nueva_hora < 0){
		printf("Introduzca la nueva hora (0-23): ");
		scanf("%d", &nueva_hora);
	}
	hora_signal = true;
	break;
case '2':
	printf("Introduzca los nuevos minutos (0-59): ");
	scanf("%d", &nuevo_minuto);

	while(nuevo_minuto > 59 || nuevo_minuto < 0){
		printf("Introduzca los nuevos minutos (0-59): ");
		scanf("%d", &nuevo_minuto);
	}
	minuto_signal = true;
	break;
case '3':
	printf("Introduzca los nuevos segundos (0-59): ");
	scanf("%d", &nuevo_segundo);
	while(nuevo_segundo > 59 || nuevo_segundo < 0){
		printf("Introduzca los nuevos segundos (0-59): ");
		scanf("%d", &nuevo_segundo);
	}
	segundo_signal = true;
	break;
case '4':
	reloj_reloj_step(hora_signal, minuto_signal, segundo_signal, nueva_hora, nuevo_minuto, nuevo_segundo, &tiempo,  &reloj_ctx);
	printf("Tiempo transcurrido desde mediodía: %d segundos\n", tiempo);
	hora_signal = minuto_signal = segundo_signal = false;
	break;
case '5':
	printf("Saliendo...\n");
	exit(0);
default:
printf("Opción no válida. Intente de nuevo.\n");
}
}

return 0;
}
