#=======================================================
# Rocky Linux 10 - Tulpencraft Proxy + Lobby Node
#=======================================================
# Auteur:  Ronny Roethof
#
# Doel:
#   Automatische installatie van een Rocky Linux 10
#   Tulpencraft Proxy + Lobby node
#
# NODE
# ----
#   mc-proxy01
#
# STACK
# -----
#   Rocky Linux 10
#   Java 25
#   Velocity
#   ViaVersion
#   Paper Lobby
#
# ARCHITECTUUR
# ------------
#
#                         INTERNET
#                             |
#                             | TCP/25565
#                             v
#                    +----------------+
#                    |    VELOCITY    |
#                    |    :25565      |
#                    +-------+--------+
#                            |
#             +--------------+--------------+
#             |              |              |
#             v              v              v
#        LOBBY LOCAL     SURVIVAL01      EVENTS01
#        127.0.0.1       PRIVATE IP      PRIVATE IP
#        :25566          :25567          :25568
#
#
# Lobby draait op dezelfde node als Velocity.
#
# Survival en Events draaien op aparte nodes en zijn
# uitsluitend bereikbaar via het private netwerk.
#
#
# SECURITY
# --------
#   SELinux enforcing
#   firewalld
#   SSH key-only
#   root login disabled
#   dedicated service users
#   systemd sandboxing
#   random Velocity forwarding secret
#   localhost lobby
#   private backend network
#
# PUBLIC PORTS
# ------------
#   TCP/22     SSH
#   TCP/25565  Velocity
#
# NOT PUBLIC
# ----------
#   TCP/25566  Lobby
#   TCP/25567  Survival
#   TCP/25568  Events
#
#=======================================================


#=======================================================
# INSTALLATION MODE
#=======================================================

text
skipx


#=======================================================
# AUTHENTICATION
#=======================================================

authselect select minimal


#=======================================================
# INSTALLATION SOURCE
#=======================================================

url --url="https://mirror.nl.leaseweb.net/rockylinux/10/BaseOS/x86_64/os/"

repo --name="AppStream" \
     --baseurl="https://mirror.nl.leaseweb.net/rockylinux/10/AppStream/x86_64/os/"

repo --name="CRB" \
     --baseurl="https://mirror.nl.leaseweb.net/rockylinux/10/CRB/x86_64/os/"


#=======================================================
# LOCALE / TIMEZONE
#=======================================================

keyboard --vckeymap=us --xlayouts='us'

lang en_US.UTF-8

timezone Europe/Amsterdam --utc


#=======================================================
# NETWORK
#=======================================================

network --bootproto=static \
        --device=link \
        --ip=172.16.0.30 \
        --netmask=255.255.255.0 \
        --gateway=172.16.0.20 \
        --nameserver=172.16.0.20 \
        --ipv6=disabled \
        --activate

network --hostname=mc-proxy01


#=======================================================
# SECURITY BASELINE
#=======================================================

selinux --enforcing

firewall --enabled --ssh

rootpw --lock


#=======================================================
# SERVICES
#=======================================================

services --enabled=chronyd
services --enabled=sshd
services --enabled=auditd
services --enabled=firewalld
services --enabled=rsyslog

services --disabled=bluetooth
services --disabled=avahi-daemon


#=======================================================
# ADMIN USER
#=======================================================

user --name=rroethof \
     --groups=wheel \
     --gecos="Ronny Roethof" \
     --password="$y$j9T$TzNnH9jQpBaQ6gOEdIVz2/$yQr/MaO5tpNlscUVfbUZEr6DFTqG5p5RGOQoAZuw4C1" \
     --iscrypted


#=======================================================
# DISK CONFIGURATION
#=======================================================

ignoredisk --only-use=nvme0n1

clearpart --all \
          --drives=nvme0n1 \
          --initlabel


#=======================================================
# EFI
#=======================================================

part /boot/efi \
     --fstype="efi" \
     --size=512 \
     --fsoptions="umask=0077"


#=======================================================
# BOOT
#=======================================================

part /boot \
     --fstype="xfs" \
     --size=1024


#=======================================================
# OS PV
#=======================================================

part pv.01 \
     --fstype="lvmpv" \
     --ondisk=nvme0n1 \
     --size=1 \
     --grow


#=======================================================
# PRE-INSTALL
#=======================================================

%pre
#!/bin/bash

UUID=$(cat /sys/class/dmi/id/product_uuid 2>/dev/null | tr -d '-')

if [ -z "$UUID" ] || \
   [ "$UUID" = "00000000000000000000000000000000" ]; then

    UUID=$(uuidgen | tr -d '-')

fi

SHORT_UUID="${UUID:0:8}"

VG_OS="vg_os_${SHORT_UUID}"


cat > /tmp/vgname.ks <<EOF
volgroup ${VG_OS} pv.01 --pesize=4096
EOF


cat > /tmp/lvs.ks <<EOF

#=======================================================
# OPERATING SYSTEM
#=======================================================

logvol swap \
    --vgname=${VG_OS} \
    --name=lv_swap \
    --size=2048

logvol / \
    --vgname=${VG_OS} \
    --name=lv_root \
    --size=16384 \
    --fstype="xfs"

logvol /tmp \
    --vgname=${VG_OS} \
    --name=lv_tmp \
    --size=2048 \
    --fstype="xfs" \
    --fsoptions="nodev,nosuid"

logvol /var \
    --vgname=${VG_OS} \
    --name=lv_var \
    --size=4096 \
    --fstype="xfs" \
    --fsoptions="nodev"

logvol /var/log \
    --vgname=${VG_OS} \
    --name=lv_var_log \
    --size=2048 \
    --fstype="xfs" \
    --fsoptions="nodev,nosuid"

logvol /var/log/audit \
    --vgname=${VG_OS} \
    --name=lv_var_log_audit \
    --size=2048 \
    --fstype="xfs" \
    --fsoptions="nodev,nosuid"

logvol /var/tmp \
    --vgname=${VG_OS} \
    --name=lv_var_tmp \
    --size=1024 \
    --fstype="xfs" \
    --fsoptions="nodev,nosuid"

EOF


%end


%include /tmp/vgname.ks
%include /tmp/lvs.ks


#=======================================================
# BOOTLOADER
#=======================================================

bootloader --location=boot \
           --timeout=5 \
           --append="audit=1"


#=======================================================
# PACKAGES
#=======================================================

%packages --excludedocs

@^minimal-environment

kernel
kernel-tools
microcode_ctl

audit

policycoreutils
policycoreutils-python-utils

chrony

rsyslog

firewalld

NetworkManager

#=======================================================
# JAVA 25
#=======================================================

java-25-openjdk-headless

#=======================================================
# ADMIN TOOLING
#=======================================================

sudo
openssh-server

curl
wget
vim-enhanced
tmux
tree
tar
gzip
unzip
git
jq
openssl

%end


#=======================================================
# POST INSTALL
#=======================================================

%post --log=/var/log/kickstart.log

#!/bin/bash

set -Eeuo pipefail

trap 'echo "FOUT op regel $LINENO — zie /var/log/kickstart.log"' ERR


#=======================================================
# TULPENCRAFT CONFIGURATION
#=======================================================

NODE_ROLE="proxy+lobby"

NODE_NAME="mc-proxy01"

JAVA_MAJOR_REQUIRED="25"

MINECRAFT_VERSION="26.2"

VELOCITY_ROOT="/srv/minecraft/velocity"

LOBBY_ROOT="/srv/minecraft/lobby"

CONFIG_ROOT="/etc/tulpencraft"

LOG_ROOT="/var/log/tulpencraft"

VELOCITY_PORT="25565"

LOBBY_PORT="25566"


#=======================================================
# REMOTE BACKENDS
#=======================================================
#
# Deze worden later aangepast naar de private IP's.
#
# BELANGRIJK:
#   Gebruik hier NOOIT publieke backend-IP's als dat
#   voorkomen kan worden.
#
#=======================================================

SURVIVAL_HOST="SURVIVAL_IP"

SURVIVAL_PORT="25567"

EVENTS_HOST="EVENTS_IP"

EVENTS_PORT="25568"


#=======================================================
# DIRECTORIES
#=======================================================

mkdir -p "${VELOCITY_ROOT}/plugins"

mkdir -p "${LOBBY_ROOT}"

mkdir -p "${CONFIG_ROOT}"

mkdir -p "${LOG_ROOT}"


#=======================================================
# USERS
#=======================================================

if ! id minecraft-proxy >/dev/null 2>&1; then

    useradd \
        --system \
        --home-dir "${VELOCITY_ROOT}" \
        --shell /sbin/nologin \
        minecraft-proxy

fi


if ! id minecraft-lobby >/dev/null 2>&1; then

    useradd \
        --system \
        --home-dir "${LOBBY_ROOT}" \
        --shell /sbin/nologin \
        minecraft-lobby

fi


chown -R minecraft-proxy:minecraft-proxy \
    "${VELOCITY_ROOT}"


chown -R minecraft-lobby:minecraft-lobby \
    "${LOBBY_ROOT}"


chown -R minecraft-proxy:minecraft-proxy \
    "${LOG_ROOT}"


#=======================================================
# JAVA VALIDATION
#=======================================================

echo "======================================================="
echo " Java"
echo "======================================================="

java -version


JAVA_MAJOR=$(
    java -version 2>&1 \
    | awk -F '"' '/version/ {print $2}' \
    | cut -d. -f1
)


if [ "${JAVA_MAJOR}" != "${JAVA_MAJOR_REQUIRED}" ]; then

    echo "ERROR: Java ${JAVA_MAJOR_REQUIRED} required"

    exit 1

fi


#=======================================================
# SSH HARDENING
#=======================================================

cat > /etc/ssh/sshd_config.d/99-tulpencraft-hardening.conf <<'EOF'

PermitRootLogin no

PasswordAuthentication no

KbdInteractiveAuthentication no

PubkeyAuthentication yes

AuthenticationMethods publickey

MaxAuthTries 3

AllowAgentForwarding no

AllowTcpForwarding no

X11Forwarding no

PermitTunnel no

ClientAliveInterval 300

ClientAliveCountMax 0

EOF


#=======================================================
# SSH KEY
#=======================================================

mkdir -p /home/rroethof/.ssh

chmod 700 /home/rroethof/.ssh


cat > /home/rroethof/.ssh/authorized_keys <<'EOF'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMELqQdsIVHY4dU/rwGVkgAb1MV+TQM9rFzYDhweWafB rroethof@kickstart
EOF


chmod 600 \
    /home/rroethof/.ssh/authorized_keys


chown -R rroethof:rroethof \
    /home/rroethof/.ssh


#=======================================================
# SUDO
#=======================================================

cat > /etc/sudoers.d/rroethof <<'EOF'
rroethof ALL=(ALL) ALL
EOF


chmod 440 \
    /etc/sudoers.d/rroethof


#=======================================================
# FIREWALL
#=======================================================

systemctl enable firewalld

systemctl start firewalld || true


firewall-cmd --permanent \
    --add-service=ssh


#=======================================================
# VELOCITY PUBLIC PORT
#=======================================================

firewall-cmd --permanent \
    --add-port="${VELOCITY_PORT}/tcp"


#=======================================================
# IMPORTANT
#=======================================================
#
# Lobby is bound to localhost.
#
# Survival and Events are remote private backends.
#
# Therefore:
#
#   25566 = NOT public
#   25567 = NOT public
#   25568 = NOT public
#
#=======================================================

firewall-cmd --reload


#=======================================================
# SYSCTL
#=======================================================

cat > /etc/sysctl.d/99-tulpencraft.conf <<'EOF'

net.ipv4.ip_forward=0

net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.default.accept_redirects=0

net.ipv4.conf.all.send_redirects=0

net.ipv4.conf.all.accept_source_route=0
net.ipv4.conf.default.accept_source_route=0

net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1

net.ipv4.conf.all.log_martians=1

net.ipv4.tcp_syncookies=1

net.ipv6.conf.all.accept_redirects=0
net.ipv6.conf.default.accept_redirects=0

kernel.randomize_va_space=2

kernel.kptr_restrict=2

kernel.dmesg_restrict=1

kernel.sysrq=0

kernel.unprivileged_bpf_disabled=1

fs.suid_dumpable=0

EOF


sysctl --system


#=======================================================
# JOURNALD
#=======================================================

mkdir -p /var/log/journal


sed -i \
    's/^#\?Storage=.*/Storage=persistent/' \
    /etc/systemd/journald.conf


sed -i \
    's/^#\?SystemMaxUse=.*/SystemMaxUse=1G/' \
    /etc/systemd/journald.conf


#=======================================================
# CHRONY
#=======================================================

systemctl enable chronyd

systemctl start chronyd || true


#=======================================================
# VELOCITY VERSION
#=======================================================

VELOCITY_VERSION="${VELOCITY_VERSION:-3.4.0}"


echo "Velocity version: ${VELOCITY_VERSION}"


#=======================================================
# VELOCITY BUILD
#=======================================================

VELOCITY_BUILD=$(
    curl -fsSL \
        "https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY_VERSION}/builds" \
    | jq -r '
        .builds
        | map(select(.channel == "default"))
        | .[-1].build
    '
)


if [ -z "${VELOCITY_BUILD}" ] || \
   [ "${VELOCITY_BUILD}" = "null" ]; then

    echo "ERROR: unable to determine Velocity build"

    exit 1

fi


VELOCITY_JAR="velocity-${VELOCITY_VERSION}-${VELOCITY_BUILD}.jar"


#=======================================================
# DOWNLOAD VELOCITY
#=======================================================

cd "${VELOCITY_ROOT}"


curl -fL \
    -o velocity.jar \
    "https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY_VERSION}/builds/${VELOCITY_BUILD}/downloads/${VELOCITY_JAR}"


chown minecraft-proxy:minecraft-proxy \
    velocity.jar


chmod 640 \
    velocity.jar


#=======================================================
# VELOCITY INITIAL START
#=======================================================

su -s /bin/bash minecraft-proxy -c \
    "cd '${VELOCITY_ROOT}' && \
     timeout 15 \
     /usr/bin/java \
     -Xms128M \
     -Xmx256M \
     -jar velocity.jar" \
    > "${LOG_ROOT}/velocity-bootstrap.log" 2>&1 \
    || true


#=======================================================
# FORWARDING SECRET
#=======================================================

umask 077


openssl rand -hex 32 \
    > "${VELOCITY_ROOT}/forwarding.secret"


chown minecraft-proxy:minecraft-proxy \
    "${VELOCITY_ROOT}/forwarding.secret"


chmod 600 \
    "${VELOCITY_ROOT}/forwarding.secret"


#=======================================================
# VELOCITY CONFIGURATION
#=======================================================

cat > "${VELOCITY_ROOT}/velocity.toml" <<EOF

#=======================================================
# Tulpencraft Velocity Proxy
#=======================================================

config-version = "2.7"

bind = "0.0.0.0:${VELOCITY_PORT}"

motd = "<#55FF55>Tulpencraft <gray>- <white>Survival zoals het hoort"

show-max-players = 100

online-mode = true

force-key-authentication = true

player-info-forwarding-mode = "modern"

forwarding-secret-file = "forwarding.secret"

announce-forge = false

kick-existing-players = false

ping-passthrough = "DESCRIPTION"

enable-player-address-logging = true


#=======================================================
# BACKEND SERVERS
#=======================================================

[servers]

lobby = "127.0.0.1:${LOBBY_PORT}"

survival = "${SURVIVAL_HOST}:${SURVIVAL_PORT}"

events = "${EVENTS_HOST}:${EVENTS_PORT}"

try = [
    "lobby"
]


#=======================================================
# FORCED HOSTS
#=======================================================

[forced-hosts]


#=======================================================
# ADVANCED
#=======================================================

[advanced]

compression-threshold = 256

compression-level = 6

login-ratelimit = 3000

connection-timeout = 5000

read-timeout = 30000

tcp-fast-open = true

bungee-plugin-message-channel = true

show-ping-requests = false

announce-proxy-commands = true

failover-on-unexpected-server-disconnect = true

log-command-executions = false

log-player-connections = true

accepts-transfers = false

EOF


#=======================================================
# VIAVERSION
#=======================================================

VIAVERSION_VERSION="5.10.0"


echo "======================================================="
echo " Installing ViaVersion ${VIAVERSION_VERSION}"
echo "======================================================="


curl -fL \
    -o "${VELOCITY_ROOT}/plugins/ViaVersion.jar" \
    "https://hangar.papermc.io/api/v1/projects/ViaVersion/versions/${VIAVERSION_VERSION}/platforms/VELOCITY/download"


chown minecraft-proxy:minecraft-proxy \
    "${VELOCITY_ROOT}/plugins/ViaVersion.jar"


chmod 640 \
    "${VELOCITY_ROOT}/plugins/ViaVersion.jar"


#=======================================================
# PAPER LOBBY
#=======================================================

echo "======================================================="
echo " Installing Paper Lobby"
echo "======================================================="


PAPER_VERSION="${PAPER_VERSION:-${MINECRAFT_VERSION}}"


PAPER_BUILD=$(
    curl -fsSL \
        "https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds" \
    | jq -r '
        .builds
        | map(select(.channel == "default"))
        | .[-1].build
    '
)


if [ -z "${PAPER_BUILD}" ] || \
   [ "${PAPER_BUILD}" = "null" ]; then

    echo "ERROR: unable to determine Paper build"

    exit 1

fi


PAPER_JAR="paper-${PAPER_VERSION}-${PAPER_BUILD}.jar"


cd "${LOBBY_ROOT}"


curl -fL \
    -o paper.jar \
    "https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${PAPER_BUILD}/downloads/${PAPER_JAR}"


chown minecraft-lobby:minecraft-lobby \
    paper.jar


chmod 640 \
    paper.jar


#=======================================================
# LOBBY EULA
#=======================================================

echo "eula=true" \
    > "${LOBBY_ROOT}/eula.txt"


chown minecraft-lobby:minecraft-lobby \
    "${LOBBY_ROOT}/eula.txt"


#=======================================================
# LOBBY SERVER.PROPERTIES
#=======================================================

cat > "${LOBBY_ROOT}/server.properties" <<EOF

server-port=${LOBBY_PORT}

server-ip=127.0.0.1

online-mode=false

motd=Tulpencraft Lobby

difficulty=peaceful

gamemode=adventure

force-gamemode=true

spawn-protection=0

allow-flight=true

view-distance=8

simulation-distance=6

max-players=100

network-compression-threshold=256

enable-status=true

enable-query=false

enable-rcon=false

broadcast-rcon-to-ops=false

hide-online-players=false

prevent-proxy-connections=false

EOF


chown minecraft-lobby:minecraft-lobby \
    "${LOBBY_ROOT}/server.properties"


#=======================================================
# PAPER GLOBAL CONFIG
#=======================================================
#
# Paper's proxy support is configured here after the
# initial startup creates the configuration structure.
#
#=======================================================


#=======================================================
# LOBBY SYSTEMD
#=======================================================

cat > /etc/systemd/system/tulpencraft-lobby.service <<'EOF'

[Unit]

Description=Tulpencraft Paper Lobby

After=network-online.target

Wants=network-online.target


[Service]

Type=simple

User=minecraft-lobby

Group=minecraft-lobby

WorkingDirectory=/srv/minecraft/lobby


ExecStart=/usr/bin/java \
    -Xms1G \
    -Xmx2G \
    -XX:+UseG1GC \
    -XX:+ParallelRefProcEnabled \
    -XX:MaxGCPauseMillis=100 \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+DisableExplicitGC \
    -jar paper.jar \
    nogui


Restart=on-failure

RestartSec=10

TimeoutStopSec=60

KillSignal=SIGINT

LimitNOFILE=65535


#=======================================================
# SYSTEMD HARDENING
#=======================================================

NoNewPrivileges=true

PrivateTmp=true

ProtectSystem=strict

ProtectHome=true

ProtectKernelTunables=true

ProtectKernelModules=true

ProtectControlGroups=true

RestrictRealtime=true

RestrictSUIDSGID=true

LockPersonality=true

RestrictAddressFamilies=AF_INET AF_INET6 AF_UNIX

ReadWritePaths=/srv/minecraft/lobby


[Install]

WantedBy=multi-user.target

EOF


#=======================================================
# VELOCITY SYSTEMD
#=======================================================

cat > /etc/systemd/system/velocity.service <<'EOF'

[Unit]

Description=Tulpencraft Velocity Proxy

Documentation=https://docs.papermc.io/velocity/

After=network-online.target

Wants=network-online.target


[Service]

Type=simple

User=minecraft-proxy

Group=minecraft-proxy

WorkingDirectory=/srv/minecraft/velocity


ExecStart=/usr/bin/java \
    -Xms256M \
    -Xmx512M \
    -XX:+UseG1GC \
    -XX:+ParallelRefProcEnabled \
    -XX:+AlwaysPreTouch \
    -jar velocity.jar


Restart=on-failure

RestartSec=5

TimeoutStopSec=30

KillSignal=SIGINT

LimitNOFILE=65535


#=======================================================
# SYSTEMD HARDENING
#=======================================================

NoNewPrivileges=true

PrivateTmp=true

ProtectSystem=strict

ProtectHome=true

ProtectKernelTunables=true

ProtectKernelModules=true

ProtectControlGroups=true

RestrictRealtime=true

RestrictSUIDSGID=true

LockPersonality=true

MemoryDenyWriteExecute=false

RestrictAddressFamilies=AF_INET AF_INET6 AF_UNIX

ReadWritePaths=/srv/minecraft/velocity


[Install]

WantedBy=multi-user.target

EOF


#=======================================================
# PERMISSIONS
#=======================================================

chown -R minecraft-proxy:minecraft-proxy \
    "${VELOCITY_ROOT}"


chown -R minecraft-lobby:minecraft-lobby \
    "${LOBBY_ROOT}"


chmod 600 \
    "${VELOCITY_ROOT}/forwarding.secret"


chmod 640 \
    "${VELOCITY_ROOT}/velocity.toml"


#=======================================================
# SELINUX
#=======================================================

restorecon -RFv \
    /srv/minecraft \
    /etc/tulpencraft \
    || true


#=======================================================
# SYSTEMD
#=======================================================

systemctl daemon-reload


systemctl enable velocity.service

systemctl enable tulpencraft-lobby.service


#=======================================================
# SSH VALIDATION
#=======================================================

sshd -t


#=======================================================
# INSTALLATION VALIDATION
#=======================================================

if [ ! -f "${VELOCITY_ROOT}/velocity.jar" ]; then

    echo "ERROR: velocity.jar missing"

    exit 1

fi


if [ ! -f "${VELOCITY_ROOT}/forwarding.secret" ]; then

    echo "ERROR: forwarding.secret missing"

    exit 1

fi


if [ ! -f "${VELOCITY_ROOT}/plugins/ViaVersion.jar" ]; then

    echo "ERROR: ViaVersion.jar missing"

    exit 1

fi


if [ ! -f "${LOBBY_ROOT}/paper.jar" ]; then

    echo "ERROR: paper.jar missing"

    exit 1

fi


#=======================================================
# NODE INFORMATION
#=======================================================

cat > "${CONFIG_ROOT}/node.conf" <<EOF

NODE_NAME=${NODE_NAME}

NODE_ROLE=${NODE_ROLE}

MINECRAFT_VERSION=${MINECRAFT_VERSION}

JAVA_VERSION=${JAVA_MAJOR_REQUIRED}

VELOCITY_VERSION=${VELOCITY_VERSION}

VELOCITY_BUILD=${VELOCITY_BUILD}

VIAVERSION_VERSION=${VIAVERSION_VERSION}

PAPER_VERSION=${PAPER_VERSION}

PAPER_BUILD=${PAPER_BUILD}

VELOCITY_PORT=${VELOCITY_PORT}

LOBBY_PORT=${LOBBY_PORT}

SURVIVAL_HOST=${SURVIVAL_HOST}

SURVIVAL_PORT=${SURVIVAL_PORT}

EVENTS_HOST=${EVENTS_HOST}

EVENTS_PORT=${EVENTS_PORT}

EOF


chmod 640 \
    "${CONFIG_ROOT}/node.conf"


#=======================================================
# START LOBBY
#=======================================================

echo "======================================================="

echo " Starting Tulpencraft Lobby"

echo "======================================================="


systemctl start tulpencraft-lobby.service


#=======================================================
# WAIT FOR LOBBY
#=======================================================

for i in {1..60}; do

    if ss -lnt | grep -q "127.0.0.1:${LOBBY_PORT} "; then

        echo "Lobby is listening on ${LOBBY_PORT}."

        break

    fi

    sleep 2

done


#=======================================================
# START VELOCITY
#=======================================================

echo "======================================================="

echo " Starting Velocity"

echo "======================================================="


systemctl start velocity.service


#=======================================================
# WAIT FOR VELOCITY
#=======================================================

for i in {1..30}; do

    if ss -lnt | grep -q ":${VELOCITY_PORT} "; then

        echo "Velocity is listening on ${VELOCITY_PORT}."

        break

    fi

    sleep 2

done


#=======================================================
# FINAL STATUS
#=======================================================

echo

echo "======================================================="

echo " TULPENCRAFT PROXY + LOBBY INSTALLATION COMPLETED"

echo "======================================================="

echo

echo "Node:"
echo "  ${NODE_NAME}"

echo

echo "Role:"
echo "  ${NODE_ROLE}"

echo

echo "OS:"
echo "  Rocky Linux 10"

echo

echo "Java:"
java -version

echo

echo "Minecraft:"
echo "  ${MINECRAFT_VERSION}"

echo

echo "Velocity:"
echo "  ${VELOCITY_VERSION}"

echo "  build ${VELOCITY_BUILD}"

echo

echo "ViaVersion:"
echo "  ${VIAVERSION_VERSION}"

echo

echo "Paper:"
echo "  ${PAPER_VERSION}"

echo "  build ${PAPER_BUILD}"

echo

echo "PUBLIC:"
echo "  TCP/25565 -> Velocity"

echo

echo "LOCAL:"
echo "  127.0.0.1:25566 -> Lobby"

echo

echo "REMOTE BACKENDS:"
echo "  Survival -> ${SURVIVAL_HOST}:${SURVIVAL_PORT}"

echo "  Events   -> ${EVENTS_HOST}:${EVENTS_PORT}"

echo

echo "FORWARDING:"
echo "  Velocity modern forwarding"

echo

echo "SECRET:"
echo "  ${VELOCITY_ROOT}/forwarding.secret"

echo

echo "LISTENING:"
ss -lntp || true

echo

echo "FIREWALL:"
firewall-cmd --list-all || true

echo

echo "SERVICES:"

systemctl --no-pager --full status tulpencraft-lobby.service || true

systemctl --no-pager --full status velocity.service || true

echo

echo "======================================================="


%end


#=======================================================
# REBOOT
#=======================================================

reboot