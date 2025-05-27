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

Durante el desarrollo de RunBackup v2, se añadieron nuevas características que no estaban en los objetivos iniciales, pero mejoran la experiencia del respaldo:

- ✅ Diferenciación de servicios en la nube con íconos (☁ OneDrive, iCloud).
- ✅ Ahora el nombre de los archivos con errores aparece en el mensaje de fallo.
- ✅ Refinamiento del flujo del respaldo para mejor legibilidad y depuración.
- ✅ Mejora en la salida visual de los archivos modificados.

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

## 🚀 Cómo usar RunBackup v2

1. 🔹 Descarga el script `RunBackup.ps1` desde el repositorio.
2. 🔹 Edita el archivo para definir tu ruta de origen y destinos de respaldo.
3. 🔹 Ejecuta el script en Windows PowerShell con:

```powershell
.\RunBackup.ps1
```

