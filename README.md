# Salon Appointment Scheduler

Este proyecto es una aplicación simple para gestionar turnos en un salón de belleza, desarrollada en Bash y PostgreSQL como parte del curso de freeCodeCamp.

---

## Archivos del proyecto

- **salon.sql**  
  Contiene el script SQL para crear la base de datos `salon`, con las tablas necesarias (`services`, `customers`, `appointments`) y datos iniciales.

- **salon.sh**  
  Script Bash que funciona como interfaz para que el usuario pueda:  
  - Elegir un servicio  
  - Ingresar su teléfono y nombre (si es cliente nuevo)  
  - Agendar un turno con hora  
  - Ver confirmación del turno

---

## Requisitos

- PostgreSQL instalado y configurado  
- Bash shell (Linux, macOS o Windows con WSL/Git Bash)

---

## Cómo usar

1. Crear la base de datos y tablas ejecutando el script `salon.sql`:

```bash
psql -U tu_usuario -f salon.sql
