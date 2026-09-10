
# Descripción del módulo "Actuator"

El módulo **Actuator** implementa el control de una salida digital representada usando un LED, por ejemplo: display, printer, barrier y server. Se ejecuta mediante una tarea temporizada <ins> no bloqueante </ins> (Update by Time Code) permitiendo la gestión de la actividad del LED.


## Estados (ST_LED_NAME):

- **ST_LED_OFF:** Led apagado.
- **ST_LED_ON:** Led encendido.
- **ST_LED_BLINKING:** Led alterna periódicamente entre encendido y apagado.


## Eventos de entrada (EV_LED_NAME)

- **EV_LED_OFF:** Solicitud para mantener el led apagado.
- **EV_LED_ON:** Solicitud para mantener el led encendido.
- **EV_LED_BLINK:** Solicitud para mantener el led alterna periódicamente entre encendido y apagado.


## Acciones 

**LED_OFF:** Desactiva la salida digital correspondiente al LED.
**LED_ON:** Activa la salida digital correspondiente al LED.


## Variables de Control y Tiempos (timer)
- **tick:** Contador de tiempo incrementado periódicamente cada 1 ms en el ciclo de ejecución, utilizado para controlar la temporización del LED.
- **DEL_ACT_BLINK:** Tiempo de alternancia para el parpadeo del LED.
- **led_state:** Variable que almacena el estado actual de la salida durante **ST_LED_BLINKING**.

# Tabla de Estados y Excitaciones del modelo Actuator

| Current State | Event | [Guard] | Next State | Actions |
| :--- | :--- | :--- | :--- | :--- |
| `ST_LED_OFF` | `EV_LED_OFF` | - | `ST_LED_OFF` | - |
| `ST_LED_OFF` | `EV_LED_ON` | - | `ST_LED_ON` | `LED_ON` |
| `ST_LED_OFF` | `EV_LED_BLINK` | - | `ST_LED_BLINKING` | `LED_ON`, tick = 0, led_state = ON  |
| `ST_LED_ON` | `EV_LED_OFF` | - | `ST_LED_OFF` | `LED_OFF` |
| `ST_LED_ON` | `EV_LED_ON` | - | `ST_LED_ON` | - |
| `ST_LED_ON` | `EV_LED_BLINK` | - | `ST_LED_BLINKING`  | tick = 0, led_state = ON |
| `ST_LED_BLINKING` | `EV_LED_OFF` | - | `ST_LED_OFF` | `LED_OFF` |
| `ST_LED_BLINKING` | `EV_LED_ON` | - | `ST_LED_ON`| `LED_ON` |
| `ST_LED_BLINKING` |  `EV_LED_BLINK` | - | `ST_LED_BLINKING` | - |
| `ST_LED_BLINKING` | - | [tick >= DEL_ACT_BLINK && led_state == ON] | `ST_LED_BLINKING` | `LED_OFF`, led_state = OFF, tick = 0 |
| `ST_LED_BLINKING` | - | [tick >= DEL_ACT_BLINK && led_state == OFF] | `ST_LED_BLINKING` | `LED_ON`, led_state = ON, tick = 0 |


`ST_LED_BLINKING` + `EV_LED_BLINK` → `ST_LED_BLINKING` significa que si mientras parpadea el LED y le llega el evento de seguir parpareando no necesita una acción de reiniciar el ciclo, ya que continuará la acción previa. 

`ST_LED_BLINKING` + [tick >= DEL_ACT_BLINK && led_state == ON] → `ST_LED_BLINKING`/ `LED_OFF`, led_state = OFF, tick = 0  significa que mientras parpadea llega al estado ON y el tiempo se cumplió cambia de estado OFF, entonces luego con `ST_LED_BLINKING` + [tick >= DEL_ACT_BLINK && led_state == OFF] → `ST_LED_BLINKING`/`LED_ON`, led_state = ON, tick = 0 realiza lo inverso produciendo un ciclo de parpadeo periódico. 


