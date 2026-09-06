v-----------------------------------------------------------(New)-------------------------------------------------------------v

Descripción del módulo "Sensor":
El módulo Sensor implementa una tarea no bloqueante ejecutada periódicamente cada 1 ms (Update by Time Code) para escrutar el estado de entrada de un botón. 
Su función principal es realizar el filtrado mecánico de rebotes (debouncing) antes de notificar un evento válido al módulo System.

IMPORTANTE!!!
Configuración Eléctrica y Lógica
Lógica física: Botón configurado activo en bajo con resistencia de pull-up (al presionar la entrada lee 0 / 0V).  
Lógica de software: Se invierte el estado leído para trabajar con lógica activa en alto (presionado = 1, liberado = 0).

Estados (ST_BTN_NAME):
ST_BTN_UP: Botón estabilizado en reposo (no presionado). 
ST_BTN_DOWN: Botón estabilizado en estado presionado.
ST_BTN_FALLING: Detección de flanco de bajada / inicio de presión; estado de espera para filtrado de rebotes.    
ST_BTN_RISING: Detección de flanco de subida / inicio de liberación; estado de espera para filtrado de rebotes.

Eventos de Entrada / Excitaciones (EV_BTN_NAME)
EV_BTN_UP: Entrada digital evaluada en estado bajo lógico (0).
EV_BTN_DOWN: Entrada digital evaluada en estado alto lógico (1).

Señales / Acciones hacia System (EV_SYS_NAME)
EV_SYS_ON: Acción emitida al confirmar que la pulsación es estable.  
EV_SYS_OFF: Acción emitida al confirmar que la liberación es estable.

Variables de Control y Tiempos (timer)  
tick: Contador incrementado en cada llamada temporizada de 1 ms.  
DEL_BTN_FALLING: Ventana temporal de retardo (ej. 20 ms) requerida para validar la transición a presionado.  
DEL_BTN_RISING: Ventana temporal de retardo (ej. 20 ms) requerida para validar la transición a no presionado.


Tabla de Estados y Excitaciones

|                                Sensor Statechart - State Transition Table                               |
|      Current     |   State Event   | 	         [Guard]	           |     Next State	    |    Actions    |
|     ST_BTN_UP	   |   EV_BTN_DOWN	 |              -	               |   ST_BTN_FALLING   |	   tick = 0   |
|     ST_BTN_UP	   |    EV_BTN_UP	   |              -	               |     ST_BTN_UP	    |       -       |
|  ST_BTN_FALLING	 |   EV_BTN_DOWN	 |   [tick >= DEL_BTN_FALLING]   |	  ST_BTN_DOWN	    |   EV_SYS_ON   |
|  ST_BTN_FALLING	 |    EV_BTN_UP	   |   [tick < DEL_BTN_FALLING]	   |     ST_BTN_UP	    |       -       |
|   ST_BTN_DOWN	   |    EV_BTN_UP	   |               -	             |   ST_BTN_RISING	  |   tick = 0    |
|   ST_BTN_DOWN	   |  EV_BTN_DOWN	   |               -	             |    ST_BTN_DOWN	    |       -       |
|  ST_BTN_RISING	 |    EV_BTN_UP	   |   [tick >= DEL_BTN_RISING]	   |     ST_BTN_UP	    |   EV_SYS_OFF  |
|  ST_BTN_RISING	 |   EV_BTN_DOWN	 |   [tick < DEL_BTN_RISING]	   |    ST_BTN_DOWN	    |       -       |

Descripciones:
ST_BTN_UP: En estado de reposo, si se detecta que el botón pasa a nivel presionado (EV_BTN_DOWN), se transiciona a ST_BTN_FALLING y se reinicia el contador tick = 0.  
ST_BTN_FALLING: Permanece evaluando la señal durante la ventana de tiempo. Si la señal se mantiene presionada y se alcanza el tiempo guardián DEL_BTN_FALLING (ej. 20 ms), 
se confirma la pulsación, transicionando a ST_BTN_DOWN y emitiendo la señal EV_SYS_ON al modelo System. Si la lectura vuelve a EV_BTN_UP antes de tiempo (un rebote o glitch), se descarta regresando a ST_BTN_UP.  
ST_BTN_DOWN: Estado estable presionado. Al detectar la liberación (EV_BTN_UP), pasa a ST_BTN_RISING y reinicia el contador tick = 0.  
ST_BTN_RISING: Si la liberación se mantiene hasta alcanzar DEL_BTN_RISING, transiciona a ST_BTN_UP y genera la acción EV_SYS_OFF.

v-----------------------------------------------------------(Old)-------------------------------------------------------------v


Un sensor (botón) del tipo binario genera 2 EVENTOS (EV) que reflejan el valor binario asociado a la posición y al menos 2 acciones. 
Las posiciones consisten en not pressed/pressed que funcionan como triggers (EV) para el modelo Sensor. 



EV_BTN_UP = not pressed
EV_BTN_FALLING = pressed
EV_BTN_DOWN = pressed
EV_BTN_RISING = not pressed


EV_SYS_ON = 1
EV_SYS_OFF = 0


ST_BTN_UP = not pressed 
ST_BTN_FALLING =  pressed
ST_BTN_DOWN = pressed
ST_BTN_RISING = not pressed


tick // 0 
DEL_BTN_UP = 1 ms
DEL_BTN_FALLING =  1 ms
DEL_BTN_DOWN = 1 ms
DEL_BTN_RISING = 1 ms

Pensando al botón activo a masa, es decir, activo en alto. Es decir, presionando el botón se cierra el circuito dando una señal 0 que la negamos para que sea un 1.
Tomamos un retardo de la verificación de datos de un 1ms para confirmar la acción de presionado y no presionado. 

| Sensor Statechart - State Transition Table |
| Current State | Event | [Guard] | Next State | Action |
| :----- | :------: | :------: | :-------: | :-------: |
| ST_BTN_UP  | not pressed |  | ST_BTN_FALLING | tick = 0 |
| ST_BTN_FALLING  | not pressed |  | ST_BTN_UP  | tick = 0 |
| ST_BTN_FALLING  | pressed | [tick >= DEL_BTN_FALLING ]| ST_BTN_DOWN | ST_BTN_DOWN  |
| ST_BTN_DOWN  | pressed |  | ST_BTN_RISING | tick = 0|
| ST_BTN_RISING  | pressed |  | ST_BTN_DOWN | tick = 0|
| ST_BTN_RISING | not pressed| [tick >= DEL_BTN_RISING ] | ST_BTN_UP  | ST_BTN_UP |

