## Solución de COMA Electronics

El sistema de COMA Electronics  está compuesto por un servidor central (Parking System Server), máquinas de entrada (Entry Machine) y salida (Exit Machine), y computadoras de peaje y/o estaciones de pago automático (Toll Computer and/or Automatic Pay Station).

Plantea la siguiente secuencia de solución:
1. Auto llega a la terminal de entrada
2. El conductor presiona el botón, se le imprime un ticket y luego sube la barrera
3. Auto entra al estacionamiento
4. Baja la barrera
5. A la hora de la salida, el conductor se acerca a la Central Chasier Station para pagar el estacionamiento
6. Confirmado el pago, se le valida su ticket para salida con un tiempo de gracia
7. Auto se acerca a la terminal de salida con el ticket
8. Ticket leído por terminal y sube la barrera
9. Auto sale y baja la barrera


## Implementación de Parking Ticket Dispenser Machine (Entry)
Con este trabajo se busca realizar un prototipo o MVP de la máquina expendedora de tickets de entrada que consiste en:

  1.  El vehículo llega y su presencia es detectada por la cámara.
  2.  El usuario presiona un botón, lo que acciona la impresión del ticket y envía la señal para subir la barrera.
  3.  El vehículo ingresa y abandona el área del sensor, la barrera se cierra de manera automática.


## Módulos para implementar en código C (los mismos se ejecutarán cada 1ms)
  - **Sensor**: Encargado de la etapa de "escrutar" (Scrutinize), leyendo los digital inputs y los valida.  
  - **System**: Encargado de "procesar" (Process), procesa los eventos válidados por el módulo **Sensor** y toma decisiones sobre las acciones a tomar.    
  - **Actuator**: Encargado de "actuar" (Act), realiza los comandos en la salida de acuerdo a lo decidido por **System**.
 

## Analogías para el prototipo:
En la implementación del Parking Ticket Dispenser Machine (Entry) se reemplazarán los componentes industriales por electrónica básica de la forma indicada a continuación:

  - **Camera** : entrada digital como llaves ON/OFF, siendo ON ante la presencia y OFF en la ausencia del auto.
  - **Sensor Coil** : entrada digital como llaves ON/OFF, siendo ON ante la presencia y OFF en la ausencia del auto.
  - **Button** : entrada digital como botón indicando solicitud del conductor como presionado y la nula interacción como no presionado.

  - **Barrier** : salida digital en forma de LEDS.
  - **Display, printer y server** : salidas digitales en los actuadores. 
