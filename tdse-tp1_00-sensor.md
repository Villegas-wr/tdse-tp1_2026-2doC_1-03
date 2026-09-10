
# Descripción del módulo Sensor

El módulo **Sensor** implementa una tarea no bloqueante ejecutada periódicamente cada 1 ms (Update by Time Code) para escrutar el estado de entrada de un botón. Su función principal es realizar el filtrado mecánico de rebotes (debouncing) antes de notificar un evento válido al módulo **System**.

> [!IMPORTANT]
> <ins>**Lógica física:**</ins> Botón configurado activo en bajo con resistencia de pull-up (al presionar la entrada lee 0 / 0V).
> 
> <ins>**Lógica de software:**</ins>  La señal se tomará como presionado = 0 y liberado = 1.




### Estados (ST_BTN_NAME):

- **ST_BTN_UP:** Botón estabilizado en reposo (not pressed). 
- **ST_BTN_DOWN:** Botón estabilizado en estado presionado (pressed).
- **ST_BTN_FALLING:** Detección de flanco de bajada / inicio de presión (not pressed); estado de espera para filtrado de rebotes (1 - 0).    
- **ST_BTN_RISING:** Detección de flanco de subida / inicio de liberación (pressed); estado de espera para filtrado de rebotes (0 - 1).

### Eventos de Entrada / Excitaciones (EV_BTN_NAME)

- **EV_BTN_UP:** Entrada digital evaluada en estado alto lógico (1).
- **EV_BTN_DOWN:** Entrada digital evaluada en estado bajo lógico (0).

### Señales / Acciones hacia System (EV_SYS_NAME)

- **EV_SYS_PRESSED:** Acción emitida al confirmar que la pulsación es estable.  
- **EV_SYS_RELEASED:** Acción emitida al confirmar que la liberación es estable.

### Variables de Control y Tiempos (timer)  
El tick o clock es un contador que va incrementado en cada llamada temporizada de 1 ms. 

- **DEL_BTN_FALLING:** Ventana temporal de retardo (ej. 20 ms) requerida para validar la transición a pressed.  
- **DEL_BTN_RISING:** Ventana temporal de retardo (ej. 20 ms) requerida para validar la transición a not pressed.


# Tabla de Estados y Excitaciones

### Sensor Statechart - State Transition Table

| Current State | Event | [Guard] | Next State | Actions |
| :--- | :--- | :--- | :--- | :--- |
| ST_BTN_UP | EV_BTN_UP | - | ST_BTN_UP | - |
| ST_BTN_UP | EV_BTN_DOWN | - | ST_BTN_FALLING | tick = 0 |
| ST_BTN_FALLING | EV_BTN_UP | - | ST_BTN_UP | - |
| ST_BTN_FALLING | EV_BTN_DOWN | [tick >= DEL_BTN_FALLING] | ST_BTN_DOWN | EV_SYS_PRESSED |
| ST_BTN_DOWN | EV_BTN_UP | - | ST_BTN_RISING | tick = 0 |
| ST_BTN_DOWN | EV_BTN_DOWN | - | ST_BTN_DOWN | - |
| ST_BTN_RISING | EV_BTN_UP | [tick >= DEL_BTN_RISING] | ST_BTN_UP | EV_SYS_RELEASED |
| ST_BTN_RISING | EV_BTN_DOWN | - | ST_BTN_DOWN | - |

