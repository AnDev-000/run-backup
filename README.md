# RunBackup v2 - Respaldo Automático Mejorado

Este script automatiza la copia de archivos a ubicacion(es) seguras (locales o en la nube). Esta versión es una evolución de [RunBackup v1](https://github.com/AnDev-000/run-backup/tree/v1).

---

## 💡¿Qué es?

RunBackup es un script que te sirve para copiar archivos desde una ruta de origen (Ruta A) hacia una o varias ubicaciones de destino (Rutas B, C, D, etc.).

---

## 📌 ¿Cuándo usar este script?
En situaciones que necesites respaldar **frecuentemente** los mismos archivos o carpetas en destinos predefinidos, y requieres algo simple.

👉 Casos de uso recomendados:

- ✅ **Sincronización de documentos** entre nubes o discos.
- ✅ **Copias de seguridad periódicas** programadas.
- ✅ **Respaldo de partidas de videojuegos** entre dispositivos.
- ✅ **Respaldo de configuraciones o perfiles de usuario**.

⚠️ No es ideal para:

- Sistemas que requieren respaldo incremental con versiones históricas.  
- Compresión avanzada de archivos.  
- Cifrado o seguridad de datos altamente sensible.
- Sincronización en tiempo real entre dispositivos.

---

## 📋 Características

- 🔄 Respaldo automático desde múltiples rutas de origen.
- ✅ Validación de rutas de origen y destino.
- 🎨 Colores dinámicos para identificar fácilmente cada destino.
- 💾 Compatible con OneDrive, iCloudDrive, unidades externas y rutas locales.
- 📊 Barra de progreso visual para seguimiento en tiempo real.
- 🧠 Registro de archivos modificados y sus fechas.

---

## 🛠️ Requisitos

- PowerShell 5.1 o superior.
- Sistema operativo Windows.
- Permisos de escritura en las rutas de destino.

---

## 🧪 Ejemplo de ejecución

Supongamos que configuras las siguientes rutas:

- **Origen:**  
  `C:\Users\TuUsuario\Desktop\Proyectos`

- **Destinos:**  
  - Local: `D:\Backups\Proyectos`  
  - OneDrive: `C:\Users\TuUsuario\OneDrive\Backups`

Durante la ejecución, la terminal mostrará algo similar a:

```
📂 Origen:  
  C:\Users\TuUsuario\Desktop\Proyectos

💾 Destinos:  
  1: 📂 D:\Backups\Proyectos  
  2: ☁ C:\Users\TuUsuario\OneDrive\Backups
```

--------------------------------------------------
🔄 **Respaldando...**  

```
1: 📂 [██████████░░░░░░░░░░░░░░░░░░░░░░] 50% completado
2: ☁ [██████████████████████████░░░░░░] 80% completado
```
--------------------------------------------------
✅ **Respaldo completado en:**  
- 1: 📂 **Proyectos** — Nombre de la subcarpeta del destino local. 
- 2: ☁ **OneDrive** — Al detectar una ruta en la nube, se muestra el nombre de la nube con su ícono.
--------------------------------------------------
Al finalizar, se mostrará un informe detallado que incluye:

- Una tabla consolidada con las carpetas y archivos respaldados.  
- Cada archivo acompañado de su fecha original y fecha de respaldo.  
- Un mensaje interactivo solicitando presionar **Enter** para cerrar el script, permitiendo revisar el contenido en la terminal.

---

## 📥 Descargar la última versión

La versión más reciente de **RunBackup** está disponible en la sección de Releases.  
Puedes descargar los archivos ejecutables desde el siguiente enlace:

🔹 [Descargar RunBackup v2.2.2](https://github.com/AnDev-000/run-backup/releases/tag/v2.2.2)

---

## ⚙️ Configuración rápida

Descarga `RunBackup.zip` desde Releases.  
Descomprime y edita las rutas dentro de `RunBackup.ps1`:

```powershell
# Ruta de origen
$SourcePath = "C:\Users\TuUsuario\Documents"

# Ruta(s) de destino
$DestinationPaths = @(
    "D:\Respaldo\Carpeta1",
    "E:\Respaldo\Carpeta2"
)
```

Ejecuta desde PowerShell o haz doble clic en `RunBackup.bat` para ejecutarlo sin complicaciones.

📅 ¿Quieres automatizarlo?  
Consulta la guía 👉 [Automatización con Task Scheduler](docs/TaskScheduler.md).

---

## 📌 Advertencias y manejo de errores 

- **Validación de rutas:** Si la ruta de origen es inválida, el script se detendrá y mostrará un mensaje claro para corregir el error. Si alguna ruta de destino contiene errores de sintaxis, el proceso continuará únicamente con las rutas válidas. Las rutas conflictivas se marcarán con color y se mostrarán sugerencias para su corrección.

- **Registro y seguimiento:** Todos los errores y advertencias se registran automáticamente en los logs ubicados en extras/Logs/logs_runbackupv2, facilitando la revisión y el diagnóstico posterior.

- **Interacción segura:** Al finalizar, el script espera a que el usuario presione Enter antes de cerrar, asegurando que tenga tiempo suficiente para revisar el mensaje final y la salida del proceso.

---

## 📜 Licencia
Este proyecto está bajo la licencia MIT. Incluida directamente en el repositorio se encuentran las versiones traducidas de la licencia para mayor transparencia sin depender de enlaces externos.

## 🤝 Contribuciones
¡Las contribuciones son bienvenidas! Si encuentras un error o tienes una mejora en mente, abre un issue o envía un pull request. Este proyecto es educativo y experimental, pero cualquier idea que aporte será cuidadosamente evaluada.

## 🙋‍♂️ Autor
Creado por [AnDev](https://github.com/AnDev-000) como un ejercicio práctico de scripting y automatización de tareas comunes.

---


<div>
   <br>
   <br>
   <br>
   <br>
</div>

<div align="center">

# 🧱 SECCIÓN TÉCNICA Y DE DESARROLLO

</div>



---

## 🚀 Origen del proyecto  

Este proyecto nació al enfrentar un problema puntual: **respaldar una carpeta carpeta especifica diariamente a hacia multiples rutas.**

Como jugador que alternaba entre pc y movil, necesitaba una forma de respaldar carpetas específicas (como partidas de juegos o configuraciones personales) sin perder tiempo y sin depender de herramientas externas complejas.

Y aunque algunos emuladores ofrecen sincronización en la nube, muchos no lo hacen o no permiten definir múltiples rutas de respaldo. Eso obligaba a abrir carpetas específicas, copiar archivos, y pegarlos en un servicio como OneDrive o iCloud... todo manualmente y propenso a errores humanos.

Tras crear el script para automatizar este proceso, fue evolucionando y ganando características como validación de rutas, interfaz visual, soporte multilingüe y más.

Hoy, **RunBackup** es una herramienta versátil para cualquier tarea de respaldo sencilla y periódica.

---

## Objetivo principal

Hacer el respaldo automático con script más **transparente**, **visual** y **seguro**, de modo que el usuario entienda claramente qué sucede y qué archivos fueron modificados o actualizados.

---

## 📋 Lista de objetivos secundarios

### 🔹 Visualización clara del proceso de respaldo
- Se muestra la ruta de origen y cada ruta de destino con su respectivo color.
- Barra de progreso para cada carpeta destino, indicando el avance en tiempo real.
- Deteccion de nubes, y asignacion de íconos (por ejemplo, ☁ para OneDrive o iCloud).

### 📋 Reporte detallado de archivos respaldados
- Al finalizar, se despliega una tabla organizada con las carpetas copiadas.
- Dentro de cada carpeta, se listan los archivos respaldados con fechas antes y después de la copia.

### ⚠ Manejo de errores y confirmaciones
- El script muestra mensajes claros si alguna carpeta o archivo presenta error durante el respaldo.
- Se registran automáticamente todos los errores en los logs para su revisión.
- Al terminar, se solicita presionar una tecla para cerrar, permitiendo revisar la información.

---

## 🆕 Ultimas mejoras agregadas
🚀 Mejoras del 06 de junio de 2025, ver 2.2.2  
- **RunBackup.ps1:**  
  • Se optimizó la presentación en terminal: banners, separadores y resumen mejorados.  
  • Ruta de origen y destinos ahora muestran íconos (`📂`, `☁`) y prefijos (`└─`), con funciones que eliminan espacios innecesarios.
  • Nuevas notificaciones:
    - Advertencia si la ruta de origen está vacía.
    - Warning para destinos inválidos (spinner de 7 s + mensajes singular/plural). 
    - Success incluye resumen de contadores (Existentes, Copiados, Fallidos).
  • Flujo reordenado: warnings antes de success.  

- **modules/Notifications:**  
  • Refactorización de `Notifications.psm1`/`.psd1` e integración de `Wait-WithSpinner`.  
  • Nuevos activos: `error.png`, `success.png`, `warning.png` y sus `.wav`.  
  • Verificación de dependencias(BurntToast) y llamada a `installer/Setup.ps1` si falta.

- **lang/languages.ps1:**  
  • Diccionario ampliado y reorganizado con nuevos textos.  
  • Soporte extra agregado (e.g., chino) y orden optimizado.  

- **installer/Setup.ps1:**
  • Simplificado para instalar sólo BurntToast.  
  • Spinner animado durante la instalación.

- **Reestructuración general:**  
  • Eliminación de carpetas y archivos obsoletos.
  • Refactorización para eliminar redundancias y mejorar validaciones.

---

🚀 Mejoras del 04 de junio de 2025, ver 2.2.1  
- ✅ **Refactorización y reestructuración total:** Se eliminó SuccessfulBackup.ps1 y se sustituyó por notifications.ps1 para lograr un proyecto más modular.  
- ✅ **Orden y limpieza en RunBackup.ps1:** Reorganización integral del script principal, facilitando el mantenimiento y la comprensión.  
- ✅ **Actualización del diccionario:** Se amplió y optimizó lang/languages.ps1, mejorando el soporte multilingüe.  
- ✅ **Mejor manejo de pausas y modo minimizado:** Se ajustó la pausa del script y se incorporaron funciones para ejecutarlo de forma minimizada, ideal para TaskScheduler.  
- ✅ **Optimización general del código:** Refactorización y ordenación de todos los archivos del proyecto, eliminando redundancias y facilitando futuras ampliaciones.
  
---

🚀 Mejoras del 02 de junio de 2025, ver 2.2.0
- ✅ **Continuación de la refactorización y orden del código:** Se ha mantenido el trabajo de refactorización, asegurando consistencia en el codigo.
- ✅ **Reestructuración modular del proyecto:** Se crearon las carpetas installer y extras (con subcarpetas para logs, notifications, etc.) para organizar de forma clara y modular los componentes del proyecto.
- ✅ **Reubicación y ampliación de logs:** La generación de logs se trasladó a extras/Logs/logs_runbackupv2, ahora con soporte para formatos múltiples (CSV, JSON, entre otros) para un análisis detallado.
- ✅ **Inclusión integrada de la licencia MIT:** La licencia (junto con sus traducciones) se encuentra directamente en el proyecto, posibilitando su consulta sin depender de enlaces externos.
- ✅ **Implementación de notificaciones:** Se han incorporado notificaciones mediante el módulo **[BurntToast](https://www.powershellgallery.com/packages/BurntToast)**.Ahora el script muestra una notificación tras finalizar el respaldo. Además, se creó un espacio [dedicado](extras/notifications) para personalizarlas en el futuro (para la versión 2.2.1, imágenes y sonidos personalizados).
- ✅ **Instalación silenciosa de dependencias:** Se implementó la instalación de **BurntToast** con un spinner animado, evitando mostrar mensajes técnicos al usuario y usando el parámetro -Scope CurrentUser.
- ✅ **Verificación automática de dependencias:** RunBackup.ps1 verifica e instala en automático las dependencias necesarias, ofreciendo una experiencia de usuario fluida y sin intervenciones adicionales.
- ✅ **Archivo para desinstalar BurntToast:** Se ha añadido un script llamado `Uninstall-BurntToast.ps1` en la carpeta [`installer`](installer), facilitando la desinstalación del módulo para pruebas y mantenimiento.

### 🚀  Mejoras del 01 de junio de 2025, ver 2.1.3
- ✅ **Refactorización y estandarización del código:** Se renombraron variables y funciones a inglés (manteniendo comentarios en español) y se externalizaron todos los textos y símbolos a languages.ps1.
- ✅ **Extracción completa de textos y símbolos:** RunBackup.ps1 ahora utiliza los contenidos de languages.ps1 para garantizar uniformidad y evitar problemas visuales.
- ✅ **Modo incremental implementado:** Solo se copian aquellos archivos que requieren actualización; los existentes se marcan con "Ya existe" y se excluyen del total de copiados.
- ✅ **Exportación de logs en CSV y JSON:** Se genera una tabla consolidada de respaldos, exportándose en formatos CSV y JSON para facilitar su análisis.

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

### 🚀 Mejoras del 27 de mayo de 2025
Durante el desarrollo de RunBackup v2, se añadieron nuevas características que no estaban en los objetivos iniciales, pero mejoran la experiencia del respaldo:

- ✅ Los servicios en la nube se distinguen mediante íconos (☁)
- ✅ Ahora el nombre de los archivos con errores aparece en el mensaje de fallo.
- ✅ Refinamiento del flujo del respaldo para mejor legibilidad y depuración.
- ✅ Mejora en la salida visual de los archivos modificados.

---

## 🧩 Evolución del proyecto

---

### 🔄 Objetivos para la próxima versión (**V2.3 Final**, en desarrollo)

- ✅ Concluir personalización de notificaciones  
- ✅ Completar reestructuración y organización del código  
- ❌ Corregir errores  
- ❌ Concluir codificación del proyecto

### ✅ Objetivos cumplidos en **Versión 2.2.0**

- ✔️ Soporte para **español, inglés**, con opción de expandir a otros idiomas.  
- ✔️ Documentación en `TaskScheduler.md` para programar el script automáticamente.  
- ✔️ Notificación en el **Centro de Windows** tras completar el respaldo.  
- ✔️ Creación de la carpeta `logs_RunBackupV2` con historial de hasta 5 registros.  
- ✔️ Implementación del **modo incremental**, evitando copias innecesarias.  
- ✔️ Protección contra errores por múltiples rutas en `$SourcePath`, con mensaje claro.  
- ✔️ Implementación de Tabla Consolidada en CSV para logs estructurados y exportables.

### ✅ Objetivos cumplidos en **Versión 2.1.0**

### 🔹 Visualización clara del proceso de respaldo
- ✔️ Se muestra la ruta de origen y cada ruta de destino en la salida del script.
- ✔️ Implementación de colores distintivos para cada ruta.
- ✔️ Diferenciación de servicios en la nube con íconos (☁ OneDrive, iCloud).
- ✔️ Barra de progreso para indicar el avance del respaldo.

### 📋 Reporte detallado de archivos respaldados
- ✔️ Tabla organizada con las carpetas copiadas y archivos respaldados.
- ✔️ Listado detallado de los archivos respaldados al finalizar el proceso.
- ✔️ Cada archivo respaldado se lista junto a su fecha original y la fecha en que se realizó la copia.

### ⚠ Manejo de errores y confirmaciones
- ✔️ El script verifica si las carpetas destino existen antes de iniciar el respaldo.
- ✔️ Se crean las carpetas automáticamente si no existen, evitando errores.
- ✔️ Los archivos que no pudieron respaldarse se listan claramente en el mensaje final.
- ✔️ El script espera la pulsación de Enter antes de cerrar, dando al usuario tiempo suficiente para revisar el informe completo en la terminal.

