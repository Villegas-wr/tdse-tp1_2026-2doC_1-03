# Descripción del módulo Sensor

El módulo **Sensor** implementa una tarea no bloqueante ejecutada periódicamente cada 1 ms (Update by Time Code) para escrutar el estado de entrada de un botón. Su función principal es realizar el filtrado mecánico de rebotes (*debouncing*) antes de notificar un evento válido al módulo **System**.

> [!IMPORTANT]
> <ins>**Lógica física:**</ins> Botón configurado activo en bajo con resistencia de pull-up (al presionar la entrada lee 0 / 0V).
> 
> <ins>**Lógica de software:**</ins> Se invierte el estado leído para trabajar con lógica activa en alto (presionado = 1, liberado = 0).



### Estados (ST_BTN_NAME):

- **ST_BTN_UP:** Botón estabilizado en reposo (*not pressed*). 
- **ST_BTN_DOWN:** Botón estabilizado en estado presionado (*pressed*).
- **ST_BTN_FALLING:** Detección de flanco de bajada / inicio de presión (*not pressed*); estado de espera para filtrado de rebotes.    
- **ST_BTN_RISING:** Detección de flanco de subida / inicio de liberación (*pressed*); estado de espera para filtrado de rebotes.

### Eventos de Entrada / Excitaciones (EV_BTN_NAME)

- **EV_BTN_UP:** Entrada digital evaluada en estado bajo lógico (0).
- **EV_BTN_DOWN:** Entrada digital evaluada en estado alto lógico (1).

### Señales / Acciones hacia System (EV_SYS_NAME)

- **EV_SYS_PRESSED:** Acción emitida al confirmar que la *pulsación* es estable.  
- **EV_SYS_REALEASED:** Acción emitida al confirmar que la *liberación* es estable.

### Variables de Control y Tiempos (timer)  
El tick o clock es un contador que va incrementado en cada llamada temporizada de 1 ms. 

- **DEL_BTN_FALLING:** Ventana temporal de retardo (ej. 20 ms) requerida para validar la transición a *pressed*.  
- **DEL_BTN_RISING:** Ventana temporal de retardo (ej. 20 ms) requerida para validar la transición a *not pressed*.


# Tabla de Estados y Excitaciones

### Sensor Statechart - State Transition Table

| Current State | Event | [Guard] | Next State | Actions |
| :--- | :--- | :--- | :--- | :--- |
| `ST_BTN_UP` | `EV_BTN_DOWN` | - | `ST_BTN_FALLING` | `tick = 0` |
| `ST_BTN_UP` | `EV_BTN_UP` | - | `ST_BTN_UP` | - |
| `ST_BTN_FALLING` | `EV_BTN_DOWN` | `[tick >= DEL_BTN_FALLING]` | `ST_BTN_DOWN` | `EV_SYS_PRESSED` |
| `ST_BTN_FALLING` | `EV_BTN_UP` | - | `ST_BTN_UP` | - |
| `ST_BTN_DOWN` | `EV_BTN_UP` | - | `ST_BTN_RISING` | `tick = 0` |
| `ST_BTN_DOWN` | `EV_BTN_DOWN` | - | `ST_BTN_DOWN` | - |
| `ST_BTN_RISING` | `EV_BTN_UP` | `[tick >= DEL_BTN_RISING]` | `ST_BTN_UP` | `EV_SYS_RELEASED` |
| `ST_BTN_RISING` | `EV_BTN_DOWN` | - | `ST_BTN_DOWN` | - |

Descripciones:
- ST_BTN_UP: En estado de reposo, si se detecta que el botón pasa a nivel presionado (EV_BTN_DOWN), se transiciona a ST_BTN_FALLING y se reinicia el contador tick = 0.  
- ST_BTN_FALLING: Permanece evaluando la señal durante la ventana de tiempo. Si la señal se mantiene presionada y se alcanza el tiempo guardián DEL_BTN_FALLING (ej. 20 ms), 
se confirma la pulsación, transicionando a ST_BTN_DOWN y emitiendo la señal EV_SYS_ON al modelo System. Si la lectura vuelve a EV_BTN_UP antes de tiempo (un rebote o glitch), se descarta regresando a ST_BTN_UP.  
- ST_BTN_DOWN: Estado estable presionado. Al detectar la liberación (EV_BTN_UP), pasa a ST_BTN_RISING y reinicia el contador tick = 0.  
- ST_BTN_RISING: Si la liberación se mantiene hasta alcanzar DEL_BTN_RISING, transiciona a ST_BTN_UP y genera la acción EV_SYS_OFF.
