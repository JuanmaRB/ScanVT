
    #!/bin/bash
    CONFIG_FILE="/etc/scanvt/config"
    DEFAULT_TIME="02:00"
    DEFAULT_DAYS="Mon,Tue,Wed,Thu,Fri,Sat,Sun"

    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
    fi

    SCAN_TIME="${SCAN_HOUR:-$DEFAULT_TIME}"
    SCAN_DAYS="${SCAN_DAYS_OF_WEEK:-$DEFAULT_DAYS}"

    echo "[Timer]
OnCalendar=${SCAN_DAYS} *-*-* ${SCAN_TIME}:00
Persistent=true
" > /run/systemd/scanvt.timer

    systemctl daemon-reexec
    systemctl restart scanvt.service
