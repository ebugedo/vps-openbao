# OpenBao

OpenBao - Open source secret management, deployed via Docker from GHCR.

## Flujo

```
Repo GitHub → PR merge a main → GitHub Actions → Build → Push a GHCR → SSH deploy al VPS
```

## GitHub Secrets necesarios

Configurar en **Settings → Secrets and variables → Actions**:

| Secret | Descripción | Ejemplo |
|--------|-------------|---------|
| `VPS_HOST` | IP o hostname del VPS | `203.0.113.50` |
| `VPS_USER` | Usuario SSH del VPS | `root` |
| `VPS_SSH_KEY` | Clave privada SSH (ed25519 o RSA) | `-----BEGIN OPENSSH PRIVATE KEY-----...` |
| `VPS_GHCR_TOKEN` | GitHub PAT con scope `read:packages` | `ghp_xxxx` |

La clave SSH debe tener acceso sudo sin password al VPS.

### Preparación manual del VPS (una sola vez)

```bash
# Crear directorios
mkdir -p /opt/openbao/{data,config,logs}

# Copiar config inicial (edith según necesidades)
# El config.hcl está en config/config.hcl del repo
```

## Archivos en VPS

```
/opt/openbao/
├── data/       # Datos persistentes de OpenBao
├── config/     # Archivos de configuración (edith aquí)
└── logs/       # Logs de auditoría
```

## Nginx Reverse Proxy

```nginx
server {
    listen 443 ssl;
    server_name bao.tudominio.com;

    ssl_certificate     /etc/ssl/certs/openbao.crt;
    ssl_certificate_key /etc/ssl/private/openbao.key;

    location / {
        proxy_pass http://openbao:8200;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /v1/sys/storage/raft/snapshot {
        proxy_pass http://openbao:8200;
        proxy_set_header Host $host;
        proxy_buffering off;
    }
}
```
