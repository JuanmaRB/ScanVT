
# scanvt

`scanvt` es una herramienta de escaneo de malware automatizado para sistemas Linux. Utiliza **ClamAV** para el análisis de archivos y **VirusTotal** para confirmar si las amenazas detectadas son reales o falsos positivos. Los resultados se registran en CSV, se envían alertas por correo, y los archivos sospechosos se manejan cuidadosamente.

## ✨ Características

- Escaneo automático de archivos modificados recientemente.
- Primer escaneo completo del sistema.
- Consulta con la API de VirusTotal para evitar falsos positivos.
- Whitelist local para evitar consultas redundantes.
- Informes detallados en CSV por cada ejecución.
- Servicio y temporizador systemd.
- Soporte para múltiples directorios configurables.
- Configuración centralizada en `/etc/scanvt/config`.

## 📦 Instalación

### Desde paquete .deb

```bash
sudo dpkg -i scanvt_1.0_all.deb
sudo systemctl daemon-reexec
sudo systemctl enable --now scanvt-generate.service scanvt.timer
```

### Dependencias

```bash
sudo apt install clamav jq curl mailutils -y
```

## ⚙️ Configuración

Edita `/etc/scanvt/config`:

```bash
VT_API_KEY="tu_api_key_virustotal"
SCAN_DIRS=("/home" "/var/www")
SCAN_DAYS=10
SCAN_HOUR="03:00"
SCAN_DAYS_OF_WEEK="Mon,Tue,Wed,Thu,Fri"
MAIL_DEST="admin@tudominio.com"
QUAR_RETENTION_DAYS=7
```

## 🧪 Resultados

- Archivos en cuarentena: `/var/quarantine`
- Logs: `/var/log/scanvt/scan.log`
- Whitelist de falsos positivos: `/var/cache/scanvt/whitelist.txt`
- CSV por escaneo: `/root/scanvt/scanvt_report_YYYY-MM-DD_HH-MM-SS.csv`

## 🧹 Limpieza

- Si `QUAR_RETENTION_DAYS=0`, los archivos en cuarentena **no se eliminan automáticamente**.
- Si `QUAR_RETENTION_DAYS=N`, los archivos en cuarentena se eliminan tras N días.

## ✉️ Alertas

Se enviarán correos cuando:
- Se detecte malware confirmado.
- Se restaure un archivo considerado falso positivo.

> El CSV del escaneo se adjunta al correo.

## 🔧 Mantenimiento

Mantenedor: **Juan Manuel Biglia**  
Contacto: `juanma.biglia@gmail.com`

---
