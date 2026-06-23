# World Cup Database (freeCodeCamp Project)

Este proyecto forma parte de la certificación **Relational Database** de freeCodeCamp. Consiste en la creación y automatización de una base de datos en PostgreSQL que almacena información histórica de los partidos de la Copa Mundial de la FIFA, junto con scripts en Bash para la inserción masiva de datos y la ejecución de consultas analíticas.

## 🚀 Características

* **Esquema Relacional**: Base de datos estructurada con tablas para equipos (`teams`) y partidos (`games`), implementando claves primarias, foráneas y restricciones de unicidad.
* **Automatización con Bash**: Script de automatización (`insert_data.sh`) encargado de procesar un archivo fuente CSV (`games.csv`), registrar dinámicamente los equipos y almacenar las estadísticas de cada partido de forma normalizada.
* **Consultas SQL**: Script analítico (`queries.sh`) enfocado en extraer métricas de rendimiento como promedios de goles, conteos de campeones y filtrados específicos de datos.

---

## 🛠️ Tecnologías Utilizadas

* **PostgreSQL**: Motor de base de datos relacional para el almacenamiento estructurado.
* **Bash Scripting**: Automatización y lectura de flujos de datos.

---

## 📂 Estructura del Proyecto

* `worldcup.sql`: Volcado (dump) del esquema y la configuración estructural de la base de datos PostgreSQL.
* `insert_data.sh`: Script en Bash diseñado para procesar el set de datos en formato CSV e insertar los registros en la base de datos de manera limpia y eficiente.
* `queries.sh`: Archivo ejecutable con consultas SQL complejas para responder preguntas estadísticas específicas sobre los torneos.

---

## 🔧 Configuración e Instalación

1. **Reconstruir la base de datos** utilizando el archivo estructural proporcionado:
   ```bash
   psql -U postgres < worldcup.sql

2. **Otorgar permisos de ejecución a los scripts de automatización:
   ```bash
   chmod +x insert_data.sh queries.sh

3. **Poblar la base de datos ejecutando el script de inserción (asegúrate de contar con el archivo fuente games.csv en el mismo directorio):
   ```bash
   ./insert_data.sh

4. **Ejecutar consultas estadísticas:
   ```bash
   ./queries.sh