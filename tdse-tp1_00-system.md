Descripción del módulo System
El módulo System implementa la lógica de procesamiento del sistema de estacionamiento. Se ejecuta mediante una tarea temporizada no bloqueante cada 1 ms (Update by Time Code). 
Su objetivo principal es interpretar las señales (eventos) emitidas por el módulo Sensor y generar las acciones o señales dirigidas hacia el módulo Actuator.

Estados (ST_SYS_NAME)
- ST_SYS_IDLE: Estado de reposo o espera del sistema (ej. aguardando llegada de un vehículo o pulsación).
- ST_SYS_ACTIVE: Estado activo donde el proceso del sistema está en ejecución (ej. ticket emitido / barrera abierta).
- ST_SYS_WAITING: Estado de temporización o retardo controlado antes de regresar a reposo.

Eventos de Entrada recibidas (EV_SYS_NAME)
- EV_SYS_ON: Señal proveniente del módulo Sensor que notifica la activación validada de la entrada.
- EV_SYS_OFF: Señal proveniente del módulo Sensor que notifica la desactivación validada de la entrada.

Acciones emitidas hacia Actuator (EV_ACT_NAME)
- EV_ACT_ON: Orden enviada al módulo Actuator para encender o activar la salida (ej. abrir barrera / encender LED).
- EV_ACT_OFF: Orden enviada al módulo Actuator para apagar o desactivar la salida (ej. cerrar barrera / apagar LED).
- EV_ACT_BLINK: Orden enviada al módulo Actuator para iniciar una secuencia de parpadeo.

Variables de Control y Tiempos (timer)
- tick: Contador incrementado en cada llamada del ciclo de 1 ms.
- DEL_SYS_TIMEOUT: Tiempo límite definido (guard) para controlar la duración de una acción o transición automática.

Tabla de estado y excitaciones

### System Statechart - State Transition Table

| Current State | Event | [Guard] | Next State | Actions |
| :--- | :--- | :--- | :--- | :--- |
| `ST_SYS_IDLE` | `EV_SYS_ON` | - | `ST_SYS_ACTIVE` | `EV_ACT_ON` |
| `ST_SYS_IDLE` | `EV_SYS_OFF` | - | `ST_SYS_IDLE` | - |
| `ST_SYS_ACTIVE` | `EV_SYS_OFF` | - | `ST_SYS_WAITING` | `tick = 0` |
| `ST_SYS_ACTIVE` | `EV_SYS_ON` | - | `ST_SYS_ACTIVE` | - |
| `ST_SYS_WAITING` | `EV_SYS_ON` | - | `ST_SYS_ACTIVE` | - |
| `ST_SYS_WAITING` | - | `[tick >= DEL_SYS_TIMEOUT]` | `ST_SYS_IDLE` | `EV_ACT_OFF` |

Descripciones:
- ST_SYS_IDLE: Estado en reposo. Permanece a la espera de la señal EV_SYS_ON (enviada cuando el sensor valida la pulsación). Al recibirla, transiciona a ST_SYS_ACTIVE y envía la 
señal EV_ACT_ON para activar la salida correspondiente.
- ST_SYS_ACTIVE: Permanece activo mientras el evento persista. Al recibir EV_SYS_OFF (sensor liberado), transiciona a ST_SYS_WAITING e inicializa el contador de tiempo tick = 0.
- ST_SYS_WAITING: Introduce un retardo o tiempo de gracia no bloqueante. Si finaliza el tiempo estipulado [tick >= DEL_SYS_TIMEOUT], transiciona a ST_SYS_IDLE y envía el comando
EV_ACT_OFF al actuador. Si el sensor se activa nuevamente antes de expirar el temporizador, regresa a ST_SYS_ACTIVE.  
