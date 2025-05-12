#include <stdio.h>
#include <stdbool.h>
#include "abro_ABRO.h" // Incluir el archivo de cabecera generado
int main() {
	// Variables de entrada y salida
	_boolean A = false; // Se˜nal A
	_boolean B = false; // Se˜nal B
	_boolean R = false; // Reset
	_boolean O = false; // Salida O
	
	abro_ABRO_ctx_type abro_ctx; // Contexto del nodo ABRO
	abro_ABRO_ctx_reset(&abro_ctx); // Inicializar el contexto

	// Simulaci´on de interacci´on con el usuario
	while (true) {

	        // Solicitar al usuario qu´e se˜nal desea enviar
	        int a_op, b_op, r_op, s_op;
	        printf("¿Qu´e se˜nal desea enviar a A (0/1): ");
	        scanf(" %i", &a_op);
	        printf("¿Qu´e se˜nal desea enviar a B (0/1): ");
	        scanf(" %i", &b_op);
	        printf("¿Qu´e se˜nal desea enviar a R (0/1): ");
	        scanf(" %i", &r_op);
	        printf("¿Qu´e se˜nal desea enviar a S (0/1): ");
	        scanf(" %i", &s_op);

	        if (a_op == 0) { // Activar la se˜nal A
		        A = false;

	        } else {
	                A = true;
	        }

	        if (b_op == 0) { // Activar la se˜nal A
		        B = false;

	        } else {
	                B = true;
	        }
	        if (r_op == 0) { // Activar la se˜nal A
		        R = false;

	        } else {
	                R = true;
	        }
	        
	        if (s_op == 1) {
	              break;
	            }
	        abro_ABRO_step(A, B, R, &O, &abro_ctx);
	        // Mostrar el estado de la salida
	        if (O) {
		        printf("¡Salida O activada!\n");
	        } else {
		        printf("Salida O desactivada.\n");
	        }
	}
	return 0;
}
