* Solución de COMA Electronics:

- Este sistema está compuesto por un servidor central (Parking System Server), máquinas de entrada (Entry Machine) y salida (Exit Machine), además de computadoras de peaje o estaciones de pago automático.


* Implementación de Parking Ticket Dispenser Machine (Entry)
(Se busca realizar un prototipo o MVP de la maquina expendedora de tickets de entrada)

  - El flujo de implementación comienza cuando el vehículo llega y es detectado.
  - Luego, el usuario presiona un botón, lo que acciona la impresión del ticket y envía la señal para abrir la barrera.
  - Finalmente, cuando el vehículo ingresa y abandona el área del sensor, la barrera se cierra de manera automática.


* Módulos para implementar en código C:
(los mismos se ejecutarán cada 1ms)
  - Sensor: Encargado de la etapa de "escrutar" (Scrutinize), leyendo el estado de las entradas.  
  - System: Encargado de "procesar" (Process) la lógica central de la máquina expendedora.    
  - Actuator: Encargado de "actuar" (Act), enviando los comandos a las salidas.
 

* Analogías para el prototipo:
(se reemplazarán los componentes industriales por electrónica básica)

  - Entradas Digitales (Sensores): Los sensores reales como la cámara (Camera), el botón (Button) y la bobina sensora (Sensor Coil) se reemplazarán por pulsadores o interruptores tipo dip switch (llaves On/Off).
  - Salidas Digitales (Actuadores): Los actuadores reales como el display, la impresora, la barrera (Barrier) y la comunicación con el servidor (Server)
