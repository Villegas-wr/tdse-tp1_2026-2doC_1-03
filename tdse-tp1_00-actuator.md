Descripción del módulo "Actuator":
El módulo Actuator controla el estado de la barrera de acceso utilizando tres salidas digitales representadas por LEDs (Rojo, Amarillo y Verde). 
Se ejecuta de forma no bloqueante cada 1 ms (Update by Time Code) para gestionar la activación de los LEDs y el tiempo que toma la transición física de apertura o cierre.


Identificadores y Convenciones

Estados (ST_ACT_NAME)

- ST_ACT_DOWN: Barrera cerrada / baja. LED Rojo encendido, Amarillo y Verde apagados.  
- ST_ACT_RAISING: Barrera abriéndose (transición). LED Amarillo parpadeando, Rojo y Verde apagados.
- ST_ACT_UP: Barrera abierta / alta. LED Verde encendido, Rojo y Amarillo apagados.  
- ST_ACT_LOWERING: Barrera cerrándose (transición). LED Amarillo parpadeando, Rojo y Verde apagados.


Eventos de Entrada / Comandos de System (EV_ACT_NAME)

- EV_ACT_OPEN: Comando para iniciar la apertura de la barrera.  
- EV_ACT_CLOSE: Comando para iniciar el cierre de la barrera.


Acciones y Funciones de Hardware

- set_leds(RED, YELLOW, GREEN): Controla el estado lógico de los tres pines de salida.
- toggle_yellow_led(): Invierte el estado del LED Amarillo para generar el parpadeo durante transiciones.


Variables de Control y Tiempos (timer)  

- tick: Contador de tiempo incrementado cada 1 ms en el ciclo de ejecución.
- tick_blink: Contador secundario para la frecuencia de parpadeo del LED Amarillo.
- DEL_ACT_TRANSITION: Tiempo límite para completar el movimiento de la barrera (ej. 3000 ms).
- DEL_ACT_BLINK: Tiempo de alternancia para el parpadeo del LED Amarillo (ej. 250 ms).


Tabla de estados y excitaciones

### 3. Actuator Statechart - State Transition Table

| Current State | Event | [Guard] | Next State | Actions |
| :--- | :--- | :--- | :--- | :--- |
| `ST_ACT_DOWN` | `EV_ACT_OPEN` | - | `ST_ACT_RAISING` | `tick = 0,`<br>`tick_blink = 0,`<br>`set_leds(OFF, ON, OFF)` |
| `ST_ACT_DOWN` | `EV_ACT_CLOSE` | - | `ST_ACT_DOWN` | - |
| `ST_ACT_RAISING` | - | `[tick < DEL_ACT_TRANSITION]` | `ST_ACT_RAISING` | `[tick_blink >= DEL_ACT_BLINK]`<br>`-> toggle_yellow_led()` <br>`, tick_blink = 0` |
| `ST_ACT_RAISING` | - | `[tick >= DEL_ACT_TRANSITION]` | `ST_ACT_UP` | `set_leds(OFF, OFF, ON)` |
| `ST_ACT_UP` | `EV_ACT_CLOSE` | - | `ST_ACT_LOWERING` | `tick = 0,`<br>`tick_blink = 0,`<br>`set_leds(OFF, ON, OFF)` |
| `ST_ACT_UP` | `EV_ACT_OPEN` | - | `ST_ACT_UP` | - |
| `ST_ACT_LOWERING` | - | `[tick < DEL_ACT_TRANSITION]` | `ST_ACT_LOWERING` | `[tick_blink >= DEL_ACT_BLINK]`<br>`-> toggle_yellow_led()` <br>`, tick_blink = 0` |
| `ST_ACT_LOWERING` | - | `[tick >= DEL_ACT_TRANSITION]` | `ST_ACT_DOWN` | `set_leds(ON, OFF, OFF)` |

Descripciones
- ST_ACT_DOWN (Barrera Cerrada): Estado de reposo con el LED Rojo encendido (LEDs Amarillo y Verde apagados). Permanece en este estado hasta recibir el comando EV_ACT_OPEN emitido por el módulo System. Al recibirlo, reinicia los temporizadores (tick = 0, tick_blink = 0), apaga el LED Rojo y transiciona a ST_ACT_RAISING.
- ST_ACT_RAISING (Transición de Apertura): Simula el tiempo mecánico de elevación de la barrera. Mientras el temporizador no alcance el tiempo total de movimiento (tick < DEL_ACT_TRANSITION), el LED Amarillo parpadea a la frecuencia definida por DEL_ACT_BLINK mediante la función toggle_yellow_led(). Al cumplirse el tiempo (tick >= DEL_ACT_TRANSITION), transiciona a ST_ACT_UP y enciende el LED Verde.
- ST_ACT_UP (Barrera Abierta): Estado activo con el LED Verde encendido (LEDs Rojo y Amarillo apagados). Permanece aquí hasta recibir el comando EV_ACT_CLOSE desde System. Al recibirlo, reinicia los temporizadores, apaga el LED Verde y transiciona a ST_ACT_LOWERING.
- ST_ACT_LOWERING (Transición de Cierre): Simula el tiempo mecánico de descenso de la barrera. Mientras tick < DEL_ACT_TRANSITION, el LED Amarillo mantiene la secuencia de parpadeo. Una vez completado el tiempo de transición (tick >= DEL_ACT_TRANSITION), regresa a ST_ACT_DOWN y enciende el LED Rojo.  
