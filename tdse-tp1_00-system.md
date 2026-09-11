
# Descripción del módulo System
El módulo **System** implementa la lógica de procesamiento del sistema de estacionamiento. Se ejecuta mediante una tarea temporizada no bloqueante cada 1 ms (Update by Time Code). Su objetivo principal es interpretar las señales (eventos) emitidas por el módulo **Sensor** y generar las acciones o señales dirigidas hacia el módulo **Actuator**.


## Estados (ST_SYS_NAME)
- **ST_SYS_IDLE:** Estado de reposo o espera del sistema, no hay auto al cuál procesar.
- **ST_SYS_WAITING_BUTTON:** Auto detectado y el sistema en espera de que el botón sea presionado.
- **ST_SYS_BARRIER_OPENING:** Auto esperando a que la barrera abra por completo para poder pasar.
- **ST_SYS_WAITING_CAR:** El auto atraviesa la barrera
- **ST_SYS_BARRIER_CLOSING:** La barrera se cierra y el sistema retorna a reposo.

## Eventos de entrada (EV_SYS_NAME)

### Button
- **EV_SYS_BUTTON_PRESSED:** Señal del botón indicando que ha sido presionado.
- **EV_SYS_BUTTON_RELEASED:** Señal del botón indicando que ha sido liberado o no presionado.

### Camera
- **EV_SYS_CAMERA_DETECTED:** Señal de la cámara indicando que ha detectado el auto en la entrada.
- **EV_SYS_CAMERA_CLEARED:** Señal de la cámara indicando que ha dejado de detectar el auto (ausencia de presencia) en la entrada.

### Sensor coil
- **EV_SYS_COIL_DETECTED:** Señal del sensor indicando que ha detectado el auto en la zona de paso de la barrera.
- **EV_SYS_COIL_CLEARED:** Señal del sensor indicando que el auto ha abandonado la zona de detección.

## Señales/Acciones hacia Actuator (EV_ACT_NAME)

### Barrier
- **EV_ACT_OPEN_BARRIER:** Acción de apertura de la barrera.
- **EV_ACT_CLOSE_BARRIER:** Acción de cierre de la barrera.
- **EV_ACT_STOP_BARRIER:** Acción de cierre de la barrera.
  
## Variables de Control y Tiempos (timer)
 - **tick:** Tiempo dado por el sistema.
 - **DEL_BARRIER:** Tiempo de transición de barrera


# Tabla de estado y excitaciones

| Current State | Event | [Guard] | Next State | Actions |
| :--- | :--- | :--- | :--- | :--- |
| `ST_SYS_IDLE`            | `EV_SYS_BUTTON_PRESSED`  | -           | `ST_SYS_IDLE`            | -                                            |
| `ST_SYS_IDLE`           | `EV_SYS_BUTTON_RELEASED` | -           | `ST_SYS_IDLE`            | -                                            |
| `ST_SYS_IDLE`            | `EV_SYS_CAMERA_DETECTED` | -           | `ST_SYS_WAITING_BUTTON`  | -                                            |
| `ST_SYS_IDLE`            | `EV_SYS_CAMERA_CLEARED`  | -           | `ST_SYS_IDLE`            | -                                            |
| `ST_SYS_IDLE`            | `EV_SYS_COIL_DETECTED`   | -           | `ST_SYS_IDLE`            | -                                            |
| `ST_SYS_IDLE`            | `EV_SYS_COIL_CLEARED`    | -           | `ST_SYS_IDLE`            | -                                            |
| `ST_SYS_WAITING_BUTTON`  | `EV_SYS_BUTTON_PRESSED`  | -           | `ST_SYS_BARRIER_OPENING` | `EV_ACT_OPEN_BARRIER`, tick = DEL_BARRIER  |
| `ST_SYS_WAITING_BUTTON`  | `EV_SYS_BUTTON_RELEASED` | -           | `ST_SYS_WAITING_BUTTON`  | -                                            |
| `ST_SYS_WAITING_BUTTON`  | `EV_SYS_CAMERA_DETECTED` | -           | `ST_SYS_WAITING_BUTTON`  | -                                            |
| `ST_SYS_WAITING_BUTTON`  | `EV_SYS_CAMERA_CLEARED`  | -           | `ST_SYS_WAITING_BUTTON`  | -                                            |
| `ST_SYS_WAITING_BUTTON`  | `EV_SYS_COIL_DETECTED`   | -           | `ST_SYS_WAITING_BUTTON`  | -                                            |
| `ST_SYS_WAITING_BUTTON`  | `EV_SYS_COIL_CLEARED`    | -           | `ST_SYS_WAITING_BUTTON`  | -                                            |
| `ST_SYS_BARRIER_OPENING` | `EV_SYS_BUTTON_PRESSED`  | -           | `ST_SYS_BARRIER_OPENING` | -                                            |
| `ST_SYS_BARRIER_OPENING` | `EV_SYS_BUTTON_RELEASED` | -           | `ST_SYS_BARRIER_OPENING` | -                                            |
| `ST_SYS_BARRIER_OPENING` | `EV_SYS_CAMERA_DETECTED` | -           | `ST_SYS_BARRIER_OPENING` | -                                            |
| `ST_SYS_BARRIER_OPENING` | `EV_SYS_CAMERA_CLEARED`  | -           | `ST_SYS_BARRIER_OPENING` | -                                            |
| `ST_SYS_BARRIER_OPENING` | `EV_SYS_COIL_DETECTED`   | -           | `ST_SYS_BARRIER_OPENING` | -                                            |
| `ST_SYS_BARRIER_OPENING` | `EV_SYS_COIL_CLEARED`    | -           | `ST_SYS_BARRIER_OPENING` | -                                            |
| `ST_SYS_BARRIER_OPENING` | -                        | [tick > 0]  | `ST_SYS_BARRIER_OPENING` | tick--                                     |
| `ST_SYS_BARRIER_OPENING` | -                        | [tick == 0] | `ST_SYS_WAITING_CAR`     | `EV_ACT_STOP_BARRIER` |
| `ST_SYS_WAITING_CAR`     | `EV_SYS_BUTTON_PRESSED`  | -           | `ST_SYS_WAITING_CAR`     | -                                            |
| `ST_SYS_WAITING_CAR`     | `EV_SYS_BUTTON_RELEASED` | -           | `ST_SYS_WAITING_CAR`     | -                                            |
| `ST_SYS_WAITING_CAR`     | `EV_SYS_CAMERA_DETECTED` | -           | `ST_SYS_WAITING_CAR`     | -                                            |
| `ST_SYS_WAITING_CAR`     | `EV_SYS_CAMERA_CLEARED`  | -           | `ST_SYS_WAITING_CAR`     | -                                            |
| `ST_SYS_WAITING_CAR`     | `EV_SYS_COIL_DETECTED`   | -           | `ST_SYS_WAITING_CAR`     | -                                            |
| `ST_SYS_WAITING_CAR`     | `EV_SYS_COIL_CLEARED`    | -           | `ST_SYS_BARRIER_CLOSING` | `EV_ACT_CLOSE_BARRIER`, tick = DEL_BARRIER |
| `ST_SYS_BARRIER_CLOSING` | `EV_SYS_BUTTON_PRESSED`  | -           | `ST_SYS_BARRIER_CLOSING` | -                                            |
| `ST_SYS_BARRIER_CLOSING` | `EV_SYS_BUTTON_RELEASED` | -           | `ST_SYS_BARRIER_CLOSING` | -                                            |
| `ST_SYS_BARRIER_CLOSING` | `EV_SYS_CAMERA_DETECTED` | -           | `ST_SYS_BARRIER_CLOSING` | -                                            |
| `ST_SYS_BARRIER_CLOSING` | `EV_SYS_CAMERA_CLEARED`  | -           | `ST_SYS_BARRIER_CLOSING` | -                                            |
| `ST_SYS_BARRIER_CLOSING` | `EV_SYS_COIL_DETECTED`   | -           | `ST_SYS_BARRIER_CLOSING` | -                                            |
| `ST_SYS_BARRIER_CLOSING` | `EV_SYS_COIL_CLEARED`    | -           | `ST_SYS_BARRIER_CLOSING` | -                                            |
| `ST_SYS_BARRIER_CLOSING` | -                        | [tick > 0]  | `ST_SYS_BARRIER_CLOSING` | tick--                                     |
| `ST_SYS_BARRIER_CLOSING` | -                        | [tick == 0] | `ST_SYS_IDLE`            | -                                            |


