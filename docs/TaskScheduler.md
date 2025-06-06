

# 🕒 Automatización con Task Scheduler

Con el **Task Scheduler (Programador de Tareas)** de Windows puedes programar la ejecución de **RunBackup v2** de forma automática sin intervención manual.  
A continuación se presentan algunos escenarios y ejemplos que puedes adaptar según tus necesidades.

---

## 🔹 Escenario 1: Ejecutar el respaldo al iniciar Windows

1. Abre una ventana del **Símbolo del sistema** o **PowerShell** como administrador.
2. Ejecuta el siguiente comando (ajusta la ruta completa al script):

```powershell
schtasks /create /tn "RunBackup_Inicio" /tr "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"C:\ruta\al\script\RunBackup.ps1\"" /sc onstart /rl HIGHEST
```

📌 **Detalles del comando**:

- `/tn "RunBackup_Inicio"`: Nombre de la tarea.
- `/tr "powershell.exe ... RunBackup.ps1"`: Comando que ejecuta el script.
- `/sc onstart`: Ejecuta la tarea al iniciar Windows.
- `/rl HIGHEST`: Ejecuta con el máximo nivel de privilegios.

---

## 🔹 Escenario 2: Ejecutar el respaldo cada cierto número de horas

1. Abre la terminal como administrador.
2. Ejecuta el siguiente comando, reemplazando `HH:MM` por la hora de inicio (ej. `08:00`) y ajustando el intervalo con `/mo`:

```powershell
schtasks /create /tn "RunBackup_Horario" /tr "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"C:\ruta\al\script\RunBackup.ps1\"" /sc hourly /mo 4 /st 08:00
```

📌 **Detalles del comando**:

- `/sc hourly`: Ejecuta cada hora.
- `/mo 4`: Cada 4 horas.
- `/st 08:00`: Comienza a las 08:00.

---

## 🔹 Escenario 3: Ejecutar el respaldo al cerrar una aplicación específica

Este escenario requiere una configuración más avanzada usando **eventos del sistema**.

1. Abre el **Visor de eventos** y localiza un evento que ocurra al cerrar la aplicación (por ejemplo, **PPSSPP**).
2. Crea una tarea basada en ese evento:

```powershell
schtasks /create /tn "RunBackup_DespuesDePPSSPP" /tr "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"C:\ruta\al\script\RunBackup.ps1\"" /sc onevent /ec Application /mo * /st 00:00 /v1
```

📌 **Detalles del comando**:

- `/sc onevent`: Ejecuta cuando ocurra un evento.
- `/ec Application`: El evento proviene del registro de aplicación.

🔎 **Nota**: Este comando es solo una referencia. La configuración del evento exacto dependerá del ID y origen del evento encontrado en el Visor de eventos.

Consulta la [documentación oficial de Microsoft](https://learn.microsoft.com/es-es/windows/win32/taskschd/about-the-task-scheduler) para detalles sobre eventos.

---

## 📝 Notas adicionales

- ✅ **Verifica la ruta**: Asegúrate de que el path al script sea correcto y esté entre comillas si contiene espacios.
- ✅ **Prueba la tarea**: Desde el Programador de tareas, ejecuta manualmente para confirmar que funciona.
- ✅ **Revisa los permisos**: Algunas tareas requieren permisos de administrador.

---

Esta guía te ayudará a configurar **RunBackup v2** para ejecutarse automáticamente según tus necesidades. ¡Personalízala libremente!
