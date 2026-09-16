# AGENTS.md - Reglas para OpenBao Repository

## Reglas de Confirmación

**REGLA PRINCIPAL:** Cualquier acción que cree, modifique o borre algo FUERA del entorno local REQUIERE confirmación explícita del usuario antes de ejecutarse.

### Acciones que requieren confirmación:

- **Infraestructura:** Crear, modificar o eliminar contenedores, imágenes Docker, volúmenes, redes, o servicios en el VPS
- **GHCR:** Publicar, actualizar o eliminar imágenes en GitHub Container Registry
- **VPS:** Ejecutar comandos en el servidor VPS (SSH), instalar/actualizar/desinstalar paquetes, modificar servicios del sistema
- **Nginx:** Modificar configuración de reverse proxy, certificados SSL, o virtual hosts
- **Producción:** Cualquier cambio en servicios de producción o despliegues
- **Variables de entorno:** Modificar secrets, tokens, o credenciales en GitHub o el VPS
- **Red:** Modificar reglas de firewall, puertos, o configuración de red

### Acciones que NO requieren confirmación:

- Leer archivos en el repositorio local
- Ejecutar búsquedas (grep, find, etc.)
- Crear/modificar archivos dentro del repositorio local (con moderación)
- Ejecutar tests locales
- Verificar estado del repositorio (git status, git log, etc.)

## Reglas de Commits y PRs

**REGLA OBLIGATORIA:** Para subir cualquier cambio al repositorio, SE DEBE seguir este proceso exacto:

1. **Crear rama** con nombre descriptivo
   ```bash
   git checkout -b feat/nombre-descriptivo
   # o fix/nombre-descriptivo, chore/nombre-descriptivo, etc.
   ```

2. **Hacer commit** con mensaje claro y convencional
   ```bash
   git add .
   git commit -m "feat: descripción del cambio"
   ```

3. **Push** de la rama al remoto
   ```bash
   git push origin feat/nombre-descriptivo
   ```

4. **Crear PR** (Pull Request)
   ```bash
   gh pr create --title "feat: título del PR" --body "Descripción del cambio"
   ```

### Convención de nombres de ramas:

- `feat/` - Nuevas funcionalidades
- `fix/` - Corrección de bugs
- `chore/` - Tareas de mantenimiento
- `docs/` - Documentación
- `refactor/` - Refactorización de código
- `test/` - Añadir o modificar tests
- `ci/` - Cambios en CI/CD

### Convención de mensajes de commit:

- `feat:` - Nueva funcionalidad
- `fix:` - Corrección de bug
- `docs:` - Documentación
- `style:` - Formato (no afecta lógica)
- `refactor:` - Refactorización
- `test:` - Tests
- `chore:` - Mantenimiento
- `ci:` - Cambios en CI/CD

## Flujo de Trabajo Típico

```
1. El usuario solicita un cambio
2. El agente lee y entiende el código existente
3. El agente planifica el cambio
4. EL AGENTE PIDE CONFIRMACIÓN si el cambio afecta fuera del entorno local
5. El agente ejecuta el cambio localmente
6. El agente crea rama, commit, push y PR
7. El agente informa al usuario del PR creado
```

## Seguridad

- **NUNCA** commitear secrets, tokens, o credenciales
- **NUNCA** exponer variables de entorno sensibles en logs
- **SIEMPRE** usar GitHub Secrets para credenciales en CI/CD
- **VERIFICAR** que `.gitignore` excluye archivos sensibles
