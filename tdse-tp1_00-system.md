
# Descripción del módulo System
El módulo **System** implementa la lógica de procesamiento del sistema de estacionamiento. Se ejecuta mediante una tarea temporizada no bloqueante cada 1 ms (Update by Time Code). Su objetivo principal es interpretar las señales (eventos) emitidas por el módulo **Sensor** y generar las acciones o señales dirigidas hacia el módulo **Actuator**.


## Estados (ST_SYS_NAME)
- **ST_SYS_IDLE:** Estado de reposo o espera del sistema, no hay auto al cuál procesar.
- **ST_SYS_WAITING_BUTTON:** Auto detectado y el sistema en espera de que el botón sea presionado.
- **ST_SYS_WAITING_CAR:** Ticket solicitado y apertura de barrera, el sistema en espera a que el auto avance hasta ser detectado por el sensor coil.
- **ST_SYS_CAR_PASSING:** Sensor coil detecta el auto, el sistema espera a que el auto abandone la zona de detección.


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

### Display
- **EV_ACT_WELCOME:** Acción de mostrar mensaje de bienvenida al conductor.
  
### Printer
- **EV_ACT_PRINT_TICKET:** Acción de imprimir ticket de parking.
  
### Barrier
- **EV_ACT_OPEN_BARRIER:** Acción de apertura de la barrera.
- **EV_ACT_CLOSE_BARRIER:** Acción de cierre de la barrera.
  
### Server
- **EV_ACT_CAR_INSIDE:** Acción de notificación al servidor de que el ingreso del auto ha sido completado.
  
  
## Variables de Control y Tiempos (timer)
not yet...



# Tabla de estado y excitaciones

| Current State | Event | [Guard] | Next State | Actions |
| :--- | :--- | :--- | :--- | :--- |
| `ST_SYS_IDLE` | `EV_SYS_BUTTON_PRESSED` | - | `ST_SYS_IDLE` | - |
| `ST_SYS_IDLE` | `EV_SYS_BUTTON_RELEASED` | - | `ST_SYS_IDLE` | - |
| `ST_SYS_IDLE` | `EV_SYS_CAMERA_DETECTED` | - | `ST_SYS_WAITING_BUTTON` | `EV_ACT_WELCOME` |
| `ST_SYS_IDLE` | `EV_SYS_CAMERA_CLEARED` | - | `ST_SYS_IDLE` | - |
| `ST_SYS_IDLE` | `EV_SYS_COIL_DETECTED` | - | `ST_SYS_IDLE` | - |
| `ST_SYS_IDLE` | `EV_SYS_COIL_CLEARED`  | - | `ST_SYS_IDLE` | - |
| `ST_SYS_WAITING_BUTTON` | `EV_SYS_BUTTON_PRESSED` | - | `ST_SYS_WAITING_CAR` | `EV_ACT_OPEN_BARRIER`, `EV_ACT_PRINT_TICKET` |
| `ST_SYS_WAITING_BUTTON` | `EV_SYS_BUTTON_RELEASED` | - | `ST_SYS_WAITING_BUTTON` | - |
| `ST_SYS_WAITING_CAR` | `EV_SYS_COIL_DETECTED` | - | `ST_SYS_CAR_PASSING` | - |
| `ST_SYS_WAITING_CAR` | `EV_SYS_COIL_CLEARED` | - | `ST_SYS_WAITING_CAR` | - |
| `ST_SYS_CAR_PASSING` | `EV_SYS_COIL_DETECTED` | - | `ST_SYS_CAR_PASSING` | - |
| `ST_SYS_CAR_PASSING` | `EV_SYS_COIL_CLEARED` | - | `ST_SYS_IDLE` | `EV_ACT_CLOSE_BARRIER`,  `EV_ACT_CAR_INSIDE` |
