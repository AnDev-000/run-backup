# RunBackup v2 - Respaldo Automático Mejorado

Este script es la evolución del proyecto original **RunBackup**, que automatiza la copia de respaldos para tus archivos importantes.

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

## ✅ Objetivos cumplidos hasta ahora

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

---

## 🆕 Nuevas mejoras agregadas

### 🚀 Mejoras del 28 de mayo de 2025
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

## 📥 Descargar la última versión

La versión más reciente de **RunBackup** está disponible en la sección de Releases.  
Puedes descargar los archivos ejecutables desde el siguiente enlace:

🔹 [Descargar RunBackup v2.1.0](https://github.com/AnDev-000/run-backup/releases/tag/v2.1.0)

Para descargar e instalar:
1. Haz clic en el enlace de descarga.
2. Descarga los archivos `RunBackup.ps1` y `RunBackup.bat`.
3. Configura las rutas en `RunBackup.ps1` según tus necesidades.
4. Ejecuta el respaldo con PowerShell o simplemente haz doble clic en `RunBackup.bat`.

---

## 📌 Características clave

### 🔹 Visualización clara del proceso de respaldo
- Se muestra la ruta de origen y cada destino con su respectivo color.
- Los destinos en la nube (☁ OneDrive, iCloud) tienen íconos especiales para diferenciarlos.
- Barra de progreso para cada destino, indicando el avance del respaldo en tiempo real.

### 📋 Reporte detallado de archivos respaldados
- Al finalizar, se despliega un informe estructurado con las carpetas copiadas.
- Cada carpeta lista sus archivos modificados, junto con fecha antes y después de la copia.

### ⚠ Manejo de errores y confirmaciones
- El script muestra mensajes claros si algún archivo no pudo copiarse.
- Se registra el nombre de los archivos con errores, facilitando la depuración.
- Al terminar, se solicita presionar una tecla para cerrar, permitiendo revisar la información con calma.

---

## 📌 Configuración de las rutas

Antes de ejecutar el script, define las rutas de **origen** y **destino**:

```powershell
# 📂 Ruta de origen: carpeta que deseas respaldar
$SourcePath = "C:\Users\TuUsuario\Documents"

# 📌 Rutas de destino: carpetas donde se guardará el respaldo
$DestinationPaths = @(
    "D:\Respaldo\Carpeta1",
    "E:\Respaldo\Carpeta2"
)
```

### Instrucciones

1. **Modifica `$SourcePath`**  
   Sustituye `C:\Users\TuUsuario\Documents` por la ruta completa de la carpeta que quieres respaldar.

2. **Configura `$DestinationPaths`**  
   - Añade una o más rutas entre comillas, separadas por comas.  
   - Cada ruta debe comenzar con la letra de la unidad seguida de `:\` (p. ej. `D:\Respaldo\Carpeta1`).  
   - Puedes incluir tantos destinos como necesites.

3. Guarda los cambios en el script.

---

## 🚀 Cómo usar RunBackup v2

1. **Descarga** los archivos desde el repositorio:  
   - `RunBackup.ps1`  
   - `RunBackup.bat`

2. **Configura** las rutas editando la sección **Configuración de las rutas** en `RunBackup.ps1`.

3. **Ejecuta** el respaldo:

   ```powershell
   # Desde PowerShell
   .\RunBackup.ps1
   ```

   O simplemente haz doble clic en `RunBackup.bat` para ejecutarlo sin complicaciones.
