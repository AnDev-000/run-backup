# RunBackup v2 - Respaldo Automático Mejorado

Este script es la evolución del proyecto original **RunBackup**, que automatiza la copia de respaldos para tus archivos importantes.

---

## 🚀 Origen del proyecto  

RunBackup v2 nació por una necesidad muy concreta: **automatizar respaldos rápidos y simples de carpetas específicas**, como la carpeta **savegame del emulador PPSSPP**, hacia una ubicación segura (local o en la nube).  

Como jugador que alternaba entre **PC y iPhone**, cada vez que terminaba de jugar, tenía que **ir manualmente a la carpeta del savegame, copiar los archivos y pegarlos en la nube** para poder seguir en otro dispositivo. Esto se convirtió en un proceso **tedioso y repetitivo**.  

Pensando en una solución más práctica, creé este script para **automatizar el respaldo** y asegurarme de que mis partidas siempre estuvieran sincronizadas sin perder tiempo en copias manuales.  

Aunque lo diseñé inicialmente para este propósito, pronto me di cuenta de que **podía ser útil para muchas más cosas**.  

---

## 📋 Características

- 🔄 Respaldo automático desde múltiples rutas de origen.
- ✅ Validación de rutas de origen y destino.
- 🎨 Colores dinámicos para identificar fácilmente cada destino.
- 💾 Compatible con OneDrive, iCloudDrive, unidades externas y rutas locales.
- 📊 Barra de progreso visual para seguimiento en tiempo real.
- 🧠 Registro de archivos modificados y sus fechas.

---

📌 ¿Cuándo usar este script?
Este script fue creado con un propósito muy concreto: automatizar respaldos de manera rápida y simples de carpetas específicas, hacia una ubicación segura (local o en la nube). Está pensado para tareas repetitivas donde no se requiere una solución robusta o compleja, sino algo que simplemente funcione.

👉 Casos de uso recomendados:

✅ **Respaldo de partidas de videojuegos**  
   _Si juegas en múltiples dispositivos y necesitas sincronizar tus archivos guardados sin complicaciones, con este script automatizar ese proceso._  

✅ **Sincronización de documentos entre dispositivos**  
   _Puedes configurar el script para copiar archivos importantes de una carpeta de trabajo a un disco externo o una nube como OneDrive/iCloud._  

✅ **Copias de seguridad periódicas en la nube**  
   _Guarda versiones de documentos críticos cada cierto tiempo sin intervención manual._  

✅ **Respaldo automático de configuraciones y archivos**  
   _Si trabajas con archivos que cambian frecuentemente, como perfiles de usuario o configuraciones de programas, puedes programar respaldos recurrentes._  

⚠️ No es ideal para:

- Sistemas que requieren respaldo incremental con versiones históricas.  
- Compresión avanzada de archivos.  
- Cifrado o seguridad de datos altamente sensible.
- Sincronización en tiempo real entre dispositivos.

---

## 🛠️ Requisitos

- PowerShell 5.1 o superior.
- Sistema operativo Windows.
- Permisos de escritura en las rutas de destino.

---

## 🧪 Ejemplo de ejecución  

📂 **Origen:**  
   `C:\Users\nombreUsuario\Desktop\Carpeta1`  

💾 **Destinos:**  
   📂 `C:\Backup\Local`  
   ☁ `D:\OneDrive\Backups`  

--------------------------------------------------
🔄 **Respaldando...**  

📂`[██████████░░░░░░░░░░░░░░░░░░░░░░] 50% completado`  
   
☁ `[██████████████████████████░░░░░░] 80% completado`  
...

✅ **Respaldo completado en:**  
- 📂 **Local**  
- ☁ **OneDrive**  

---

## 📥 Descargar la última versión

La versión más reciente de **RunBackup** está disponible en la sección de Releases.  
Puedes descargar los archivos ejecutables desde el siguiente enlace:

🔹 [Descargar RunBackup v2.1.1](https://github.com/AnDev-000/run-backup/releases/tag/v2.1.1)

---

## 📖 Instrucciones

1. **Descarga** los archivos `RunBackup.ps1` y `RunBackup.bat` desde la sección de Releases.
2. **Configura** las rutas de respaldo en `RunBackup.ps1` modificando las variables `$SourcePath` y `$DestinationPaths` según tus necesidades.
3. **Ejecuta** el script desde PowerShell o haz doble clic en `RunBackup.bat` para correrlo automáticamente.

🔁 **Automatización:**  
Si deseas automatizar la ejecución del respaldo, puedes configurar una tarea en Windows usando el Programador de Tareas (Task Scheduler).
consulta la guía 👉 [Automatización con Task Scheduler](docs/TaskScheduler.md).

---

## ⚙️ Configuración de las rutas

```powershell
# 📂 Ruta de origen: carpeta que deseas respaldar
$SourcePath = "C:\Users\TuUsuario\Documents"

# 📌 Rutas de destino: carpetas donde se guardará el respaldo
$DestinationPaths = @(
    "D:\Respaldo\Carpeta1",
    "E:\Respaldo\Carpeta2"
)
```

---

## 🚀 Cómo usar RunBackup v2

1. **Descarga** los archivos desde el repositorio:
   - `RunBackup.ps1`
   - `RunBackup.bat`
2. **Configura** las rutas en `RunBackup.ps1`.
3. **Ejecuta** el respaldo:

   ```powershell
   # Desde PowerShell
   .\RunBackup.ps1
   ```

   O simplemente haz doble clic en `RunBackup.bat` para ejecutarlo sin complicaciones.

---

## 📌 Advertencias y manejo de errores  

- Si alguna ruta es inválida, el script **lo notificará y detendrá la ejecución** hasta corregir los errores.  
- Detecta errores y los reporta individualmente, indicando qué rutas de destino **fallaron**.  
- Los errores quedan registrados en el **log** para revisión posterior.  

---

## 📜 Licencia
Este proyecto está bajo la licencia MIT. Puedes usarlo, modificarlo o adaptarlo a tus necesidades personales o profesionales.

## 🤝 Contribuciones
¡Las contribuciones son bienvenidas! Si encuentras un error o tienes una mejora en mente, siéntete libre de abrir un issue o enviar un pull request. Este proyecto es educativo y experimental, pero cualquier idea que aporte simplicidad será considerada.

## 🙋‍♂️ Autor
Creado por AnDev como un ejercicio práctico de scripting simple y automatización de tareas comunes.

---



<div align="center">

# 🧱 SECCIÓN TÉCNICA Y DE DESARROLLO

</div>



---

## Objetivo principal

Hacer el respaldo automático más **transparente**, **visual** y **seguro**, para que el usuario entienda claramente qué está sucediendo y qué archivos fueron modificados o actualizados.

---

## 📋 Lista de objetivos

### 🔹 Visualización clara del proceso de respaldo
- Se muestra la ruta de origen y cada ruta de destino con su respectivo color.
- Barra de progreso para cada carpeta destino, indicando el avance en tiempo real.

### 📋 Reporte detallado de archivos respaldados
- Al finalizar, se despliega una tabla organizada con las carpetas copiadas.
- Dentro de cada carpeta, se listan los archivos respaldados con fechas antes y después de la copia.

### ⚠ Manejo de errores y confirmaciones
- El script muestra mensajes claros si algún archivo no pudo copiarse.
- Se registra el nombre de los archivos con errores, facilitando la depuración.
- Al terminar, se solicita presionar una tecla para cerrar, permitiendo revisar la información con calma.

---

## 🆕 Ultimas mejoras agregadas

### 🚀 Mejoras del 30 de mayo de 2025, ver 2.1.2
- ✅ **Refactorización completa y reestructuración del código:** Se modularizó el script en funciones reutilizables para mejorar la legibilidad y mantenimiento.
- ✅ **Uso de composite formatting:** Se sustituyó la concatenación manual de cadenas por placeholders, garantizando una salida consistente y facilitando futuras actualizaciones.
- ✅ **Remodelación de la interfaz visual:** Se implementaron funciones dedicadas para la impresión de separadores y otros elementos gráficos, optimizando el formato de salida en consola.
- ✅ **Protección contra errores en `$SourcePath`:** Se detecta y muestra un mensaje claro al usuario cuando se definen múltiples o rutas erróneas, evitando cierres abruptos.
- ✅ **Optimización del soporte multilingüe:** Se extendió y optimizó el archivo `languages.ps1`, incorporando textos para español, inglés, japonés y alemán de forma nativa.
- ✅ **Documentación interna mejorada:** Se actualizaron los comentarios y se reestructuró la documentación del código para facilitar futuras ampliaciones.

### 🚀 Mejoras del 29 de mayo de 2025, ver 2.1.1
- ✅ **Externalización de textos:** Se han reemplazado las cadenas fijas por variables leídas desde languages.ps1, facilitando futuras expansiones al soporte multilingüe.
- ✅ **Empaquetado optimizado:** Se generó un archivo ZIP que conserva la estructura completa (incluyendo la carpeta lang) para asegurar que los usuarios obtengan todos los archivos necesarios sin errores.

### 🚀 Mejoras del 28 de mayo de 2025, ver 2.1.0
Con la actualización más reciente, se han incorporado nuevas mejoras que optimizan el respaldo y la configuración del usuario:

- ✅ **Validación avanzada de rutas:** ahora el script separa los destinos válidos de los inválidos e informa claramente los errores.
- ✅ **Asignación de colores consistente:** los colores de cada destino se mantienen uniformes a lo largo de la ejecución.
- ✅ **Reporte final mejorado:** se agrupan los archivos respaldados por destino y carpeta, mostrando un informe más detallado.
- ✅ **Uso de variables placeholder en la configuración:** las rutas de origen y destino se presentan como `"REEMPLAZA_CON_TU_RUTA_..."`, facilitando su edición.
- ✅ **Nuevo archivo RunBackup.bat:** permite ejecutar el script con doble clic, sin necesidad de abrir PowerShell manualmente.

---

### 🚀 Mejoras del 27 de mayo de 2025
Durante el desarrollo de RunBackup v2, se añadieron nuevas características que no estaban en los objetivos iniciales, pero mejoran la experiencia del respaldo:

- ✅ Diferenciación de servicios en la nube con íconos (☁ OneDrive, iCloud).
- ✅ Ahora el nombre de los archivos con errores aparece en el mensaje de fallo.
- ✅ Refinamiento del flujo del respaldo para mejor legibilidad y depuración.
- ✅ Mejora en la salida visual de los archivos modificados.

---

## 🧩 Evolución del proyecto

---

### 🔄 Objetivos para la próxima versión (**V2.2.0**, en desarrollo)

- ✔️ Soporte para **español, inglés**, con opción de expandir a otros idiomas.  
- ✔️ Documentación en `TaskScheduler.md` para programar el script automáticamente.  
- ❌ Notificación en el **Centro de Windows** tras completar el respaldo.  
- ❌ Creación de la carpeta `logs_RunBackupV2` con historial de hasta 5 registros.  
- ❌ Implementación del **modo incremental**, evitando copias innecesarias.  
- ✔️ Protección contra errores por múltiples rutas en `$SourcePath`, con mensaje claro.  
- ❌ Implementación de Tabla Consolidada en CSV para logs estructurados y exportables.

### ✅ Objetivos cumplidos en **Versión 2.1.0**

### 🔹 Visualización clara del proceso de respaldo
- ✔️ Se muestra la ruta de origen y cada ruta de destino en la salida del script.
- ✔️ Implementación de colores distintivos para cada ruta.
- ✔️ Diferenciación de servicios en la nube con íconos (☁ OneDrive, iCloud).
- ✔️ Barra de progreso para indicar el avance del respaldo.

### 📋 Reporte detallado de archivos respaldados
- ✔️ Tabla organizada con las carpetas copiadas y archivos respaldados.
- ✔️ Listado detallado de los archivos respaldados al finalizar el proceso.
- ✔️ Cada archivo se muestra con su fecha original y fecha de respaldo.

### ⚠ Manejo de errores y confirmaciones
- ✔️ El script verifica si las carpetas destino existen antes de iniciar el respaldo.
- ✔️ Se crean las carpetas automáticamente si no existen, evitando errores.
- ✔️ Los archivos que no pudieron respaldarse se listan claramente en el mensaje final.
- ✔️ Mensaje final solicita presionar Enter para evitar cierre automático del script.
