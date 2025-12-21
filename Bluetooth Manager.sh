#!/bin/bash

#--------------------------------#
#     R36S Bluetooth Manager     #
#           By Jason             #
#     Multi-Language Edition     #
#          Inspired to           #
#daidaigo script and hotkey_patch#     
#--------------------------------#

# --- Vérification droits root ---
if [ "$(id -u)" -ne 0 ]; then
    exec sudo -E "$0" "$@"
fi

# --- Variables ---
CURR_TTY="/dev/tty1"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
INSTALL_FOLDER="${SCRIPT_DIR}"
local GITHUB_URL="https://uploadnow.io/f/KF3YP9F"

chmod 666 /dev/uinput

# Initialisation
SYSTEM_LANG=""
ES_CONF="/home/ark/.emulationstation/es_settings.cfg"

if [ -f "$ES_CONF" ]; then
    ES_DETECTED=$(grep "name=\"Language\"" "$ES_CONF" | grep -o 'value="[^"]*"' | cut -d '"' -f 2)
    
    if [ -n "$ES_DETECTED" ]; then
        SYSTEM_LANG="$ES_DETECTED"
    fi
fi

# --- DEFAULT : ENGLISH ---
T_BACKTITLE="R36S Bluetooth Manager by Jason"
T_STARTING="Starting Bluetooth Manager...\nPlease wait."
T_CHECK_INTERNET="Checking internet for installation..."
T_INSTALL_DONE="Installation complete!"
T_INSTALL_TITLE="Installation"
T_INSTALL_GAUGE="Installation in progress..."
T_ERR_INTERNET="Internet required to install Bluetooth."
T_ERR_TITLE="Error"
T_STOPPING="Stopping Bluetooth..."
T_STARTING_BT="Starting Bluetooth..."
T_ACTION="Action"
T_BT_DISABLED="Bluetooth disabled.\nEnable it first."
T_SCAN_TITLE="Scanning"
T_SCAN_GAUGE="Searching for devices..."
T_NO_DEVICE="No named device detected."
T_INFO="Info"
T_NEARBY="Bluetooth nearby"
T_BACK="Back"
T_CHOOSE_DEV="Choose a device:"
T_SUCCESS="Success"
T_CONNECTED="is connected"
T_RETRY="First attempt failed...\nRebooting Audio & Retrying..."
T_FAILED="Failed"
T_FAIL_CONNECT="Unable to connect to"
T_FAIL_MSG="Ensure device is in pairing mode."
T_FAIL_KNOWN="Check if device is ON and within range."
T_NO_KNOWN="No known devices."
T_KNOWN_DEV="Known Devices"
T_CONNECT_TO="Connect to:"
T_CONNECTING_TO="Connecting to"
T_NOTHING_DEL="Nothing to delete."
T_DELETE_TITLE="Delete"
T_CHOOSE_DEL="Choose device to forget:"
T_DELETING="Deleting"
T_FORGOTTEN="Device forgotten."
T_MAIN_TITLE="Main Menu"
T_QUIT="Quit"
T_STATUS="Bluetooth Status"
T_CONN_TO="Connected to"
T_NONE="None"
T_M_TOGGLE="Enable / Disable Bluetooth"
T_M_SCAN="Scan and Connect"
T_M_KNOWN="Known Devices"
T_M_FORGET="Forget a Device"
T_M_QUIT="Quit"
T_FIXING_AUDIO="Fixing audio protocols..."
T_PAIRING="Pairing in progress..."
G_INIT="Initializing..."
G_EXTRACT="Extracting patch..."
G_BIN="Installing binaries..."
G_SYSTEMD="Installing services..."
G_USER="Installing user files..."
G_PKGS="Installing packages..."
G_BT="Enabling Bluetooth..."
G_AUDIO="Audio configuration..."
G_CLEAN="Cleaning up..."
G_ERROR="Installation error"

# --- FRANÇAIS (FR) ---
if [[ "$SYSTEM_LANG" == *"fr"* ]]; then
    T_STARTING="Demarrage du Bluetooth Manager...\nVeuillez patienter."
    T_CHECK_INTERNET="Verification internet pour installation..."
    T_INSTALL_DONE="Installation terminee !"
    T_INSTALL_GAUGE="Installation en cours..."
    T_ERR_INTERNET="Internet requis pour installer Bluetooth."
    T_ERR_TITLE="Erreur"
    T_STOPPING="Arret du Bluetooth..."
    T_STARTING_BT="Demarrage du Bluetooth..."
    T_BT_DISABLED="Bluetooth desactive.\nActivez-le d'abord."
    T_SCAN_TITLE="Recherche"
    T_SCAN_GAUGE="Recherche des peripheriques..."
    T_NO_DEVICE="Aucun peripherique nomme detecte."
    T_INFO="Info"
    T_NEARBY="Bluetooth a proximite"
    T_BACK="Retour"
    T_CHOOSE_DEV="Choisir un appareil:"
    T_SUCCESS="Succes"
    T_CONNECTED="est connecte"
    T_RETRY="Echec... Redemarrage Audio...\nNouvelle tentative..."
    T_FAILED="Echec"
    T_FAIL_CONNECT="Impossible de connecter"
    T_FAIL_MSG="Assurez-vous que l'appareil est bien en mode appairage."
    T_FAIL_KNOWN="Verifiez que l'appareil est ALLUME et a portee."
    T_NO_KNOWN="Aucun peripherique connu."
    T_KNOWN_DEV="Peripheriques Connus"
    T_CONNECT_TO="Se connecter a :"
    T_CONNECTING_TO="Connexion a"
    T_NOTHING_DEL="Rien a supprimer."
    T_DELETE_TITLE="Supprimer"
    T_CHOOSE_DEL="Choisir l'appareil a oublier :"
    T_DELETING="Suppression de"
    T_FORGOTTEN="Peripherique oublie."
    T_MAIN_TITLE="Menu Principal"
    T_QUIT="Quitter"
    T_STATUS="Etat Bluetooth"
    T_CONN_TO="Connecte a"
    T_NONE="Aucun"
    T_M_TOGGLE="Activer / Desactiver Bluetooth"
    T_M_SCAN="Scanner et Connecter"
    T_M_KNOWN="Peripheriques Connus"
    T_M_FORGET="Oublier un Peripherique"
    T_M_QUIT="Quitter"
    T_FIXING_AUDIO="Reparation du protocole audio..."
    T_PAIRING="Appairage en cours..."
    G_INIT="Initialisation..."
    G_EXTRACT="Extraction du patch..."
    G_BIN="Installation des binaires..."
    G_SYSTEMD="Installation des services..."
    G_USER="Installation utilisateur..."
    G_PKGS="Installation des paquets..."
    G_BT="Activation du Bluetooth..."
    G_AUDIO="Configuration audio..."
    G_CLEAN="Nettoyage..."
    G_ERROR="Erreur pendant l'installation"

# --- ESPAÑOL (ES) ---
elif [[ "$SYSTEM_LANG" == *"es"* ]]; then
    T_BACKTITLE="R36S Bluetooth Manager por Jason"
    T_STARTING="Iniciando Bluetooth Manager...\nEspere por favor."
    T_CHECK_INTERNET="Comprobando internet para instalacion..."
    T_INSTALL_DONE="Instalacion completa!"
    T_INSTALL_TITLE="Instalacion"
    T_INSTALL_GAUGE="Instalacion en curso..."
    T_ERR_INTERNET="Se requiere internet para instalar Bluetooth."
    T_ERR_TITLE="Error"
    T_STOPPING="Deteniendo Bluetooth..."
    T_STARTING_BT="Iniciando Bluetooth..."
    T_BT_DISABLED="Bluetooth desactivado.\nActivelo primero."
    T_SCAN_TITLE="Escaneando"
    T_SCAN_GAUGE="Buscando dispositivos..."
    T_NO_DEVICE="Ningun dispositivo detectado."
    T_INFO="Info"
    T_NEARBY="Bluetooth cercano"
    T_BACK="Atras"
    T_CHOOSE_DEV="Elegir dispositivo:"
    T_SUCCESS="Exito"
    T_CONNECTED="esta conectado"
    T_RETRY="Primer intento fallido...\nReintentando..."
    T_FAILED="Fallo"
    T_FAIL_CONNECT="No se pudo conectar a"
    T_FAIL_MSG="Asegurese de que el dispositivo este en modo emparejamiento."
    T_FAIL_KNOWN="Verifique que el dispositivo este ENCENDIDO y cerca."
    T_NO_KNOWN="Sin dispositivos conocidos."
    T_KNOWN_DEV="Dispositivos Conocidos"
    T_CONNECT_TO="Conectar a:"
    T_CONNECTING_TO="Conectando a"
    T_NOTHING_DEL="Nada que eliminar."
    T_DELETE_TITLE="Eliminar"
    T_CHOOSE_DEL="Elegir dispositivo a olvidar:"
    T_DELETING="Eliminando"
    T_FORGOTTEN="Dispositivo olvidado."
    T_MAIN_TITLE="Menu Principal"
    T_QUIT="Salir"
    T_STATUS="Estado Bluetooth"
    T_CONN_TO="Conectado a"
    T_NONE="Ninguno"
    T_M_TOGGLE="Activar / Desactivar Bluetooth"
    T_M_SCAN="Escanear y Conectar"
    T_M_KNOWN="Dispositivos Conocidos"
    T_M_FORGET="Olvidar Dispositivo"
    T_M_QUIT="Salir"
    T_FIXING_AUDIO="Reparando protocolo de audio..."
    T_PAIRING="Emparejando..."
    G_INIT="Inicializando..."
    G_EXTRACT="Extrayendo parche..."
    G_BIN="Instalando binarios..."
    G_SYSTEMD="Instalando servicios..."
    G_USER="Instalando archivos de usuario..."
    G_PKGS="Instalando paquetes..."
    G_BT="Activando Bluetooth..."
    G_AUDIO="Configuracion de audio..."
    G_CLEAN="Limpiando..."
    G_ERROR="Error de instalacion"

# --- PORTUGUÊS (PT) ---
elif [[ "$SYSTEM_LANG" == *"pt"* ]]; then
    T_BACKTITLE="R36S Bluetooth Manager por Jason"
    T_STARTING="Iniciando Gerenciador...\nAguarde."
    T_CHECK_INTERNET="Verificando internet para instalacao..."
    T_INSTALL_DONE="Instalacao concluida!"
    T_INSTALL_TITLE="Instalacao"
    T_INSTALL_GAUGE="Instalacao em andamento..."
    T_ERR_INTERNET="Internet necessaria para instalar Bluetooth."
    T_ERR_TITLE="Erro"
    T_STOPPING="Parando Bluetooth..."
    T_STARTING_BT="Iniciando Bluetooth..."
    T_BT_DISABLED="Bluetooth desativado.\nAtive-o primeiro."
    T_SCAN_TITLE="Escaneando"
    T_SCAN_GAUGE="Procurando dispositivos..."
    T_NO_DEVICE="Nenhum dispositivo detectado."
    T_INFO="Info"
    T_NEARBY="Bluetooth proximo"
    T_BACK="Voltar"
    T_CHOOSE_DEV="Escolher dispositivo:"
    T_SUCCESS="Sucesso"
    T_CONNECTED="esta conectado"
    T_RETRY="Primeira tentativa falhou...\nTentando novamente..."
    T_FAILED="Falha"
    T_FAIL_CONNECT="Nao foi possivel conectar a"
    T_FAIL_MSG="Verifique se o dispositivo esta em modo de pareamento."
    T_FAIL_KNOWN="Verifique se o dispositivo esta LIGADO e proximo."
    T_NO_KNOWN="Nenhum dispositivo conhecido."
    T_KNOWN_DEV="Dispositivos Conhecidos"
    T_CONNECT_TO="Conectar a:"
    T_CONNECTING_TO="Conectando a"
    T_NOTHING_DEL="Nada para excluir."
    T_DELETE_TITLE="Excluir"
    T_CHOOSE_DEL="Escolher dispositivo para esquecer:"
    T_DELETING="Excluindo"
    T_FORGOTTEN="Dispositivo esquecido."
    T_MAIN_TITLE="Menu Principal"
    T_QUIT="Sair"
    T_STATUS="Status Bluetooth"
    T_CONN_TO="Conectado a"
    T_NONE="Nenhum"
    T_M_TOGGLE="Ativar / Desactivar Bluetooth"
    T_M_SCAN="Escanear e Conectar"
    T_M_KNOWN="Dispositivos Conhecidos"
    T_M_FORGET="Esquecer Dispositivo"
    T_M_QUIT="Sair"
    T_FIXING_AUDIO="Reparando protocolo de audio..."
    T_PAIRING="A emparelhar..."
    G_INIT="Inicializando..."
    G_EXTRACT="Extraindo patch..."
    G_BIN="Instalando binarios..."
    G_SYSTEMD="Instalando servicos..."
    G_USER="Instalando arquivos de usuario..."
    G_PKGS="Instalando pacotes..."
    G_BT="Ativando Bluetooth..."
    G_AUDIO="Configuracao de audio..."
    G_CLEAN="Limpando..."
    G_ERROR="Erro de instalacao"

# --- ITALIANO (IT) ---
elif [[ "$SYSTEM_LANG" == *"it"* ]]; then
    T_BACKTITLE="R36S Bluetooth Manager by Jason"
    T_STARTING="Avvio Gestore...\nAttendere prego."
    T_CHECK_INTERNET="Controllo internet per l'installazione..."
    T_INSTALL_DONE="Installazione completata!"
    T_INSTALL_TITLE="Installazione"
    T_INSTALL_GAUGE="Installazione in corso..."
    T_ERR_INTERNET="Internet richiesto per installare il Bluetooth."
    T_ERR_TITLE="Errore"
    T_STOPPING="Arresto Bluetooth..."
    T_STARTING_BT="Avvio Bluetooth..."
    T_BT_DISABLED="Bluetooth disabilitato.\nAbilitarlo prima."
    T_SCAN_TITLE="Scansione"
    T_SCAN_GAUGE="Ricerca dispositivi..."
    T_NO_DEVICE="Nessun dispositivo rilevato."
    T_INFO="Info"
    T_NEARBY="Bluetooth nelle vicinanze"
    T_BACK="Indietro"
    T_CHOOSE_DEV="Scegli un dispositivo:"
    T_SUCCESS="Successo"
    T_CONNECTED="e' connesso"
    T_RETRY="Primo tentativo fallito...\nRiprovo..."
    T_FAILED="Fallito"
    T_FAIL_CONNECT="Impossibile connettersi a"
    T_FAIL_MSG="Assicurarsi che il dispositivo sia in modalita' accoppiamento."
    T_FAIL_KNOWN="Verifica che il dispositivo sia ACCESO e nel raggio."
    T_NO_KNOWN="Nessun dispositivo noto."
    T_KNOWN_DEV="Dispositivos Noti"
    T_CONNECT_TO="Connetti a:"
    T_CONNECTING_TO="Connessione a"
    T_NOTHING_DEL="Nulla da eliminare."
    T_DELETE_TITLE="Elimina"
    T_CHOOSE_DEL="Scegli dispositivo da rimuovere:"
    T_DELETING="Eliminazione"
    T_FORGOTTEN="Dispositivo rimosso."
    T_MAIN_TITLE="Menu Principale"
    T_QUIT="Esci"
    T_STATUS="Stato Bluetooth"
    T_CONN_TO="Connesso a"
    T_NONE="Nessuno"
    T_M_TOGGLE="Attiva / Disattiva Bluetooth"
    T_M_SCAN="Scansiona e Connetti"
    T_M_KNOWN="Dispositivos Noti"
    T_M_FORGET="Rimuovi Dispositivo"
    T_M_QUIT="Esci"
    T_FIXING_AUDIO="Riparazione protocollo audio..."
    T_PAIRING="Abbinamento..."
    G_INIT="Inizializzazione..."
    G_EXTRACT="Estrazione patch..."
    G_BIN="Installazione binari..."
    G_SYSTEMD="Installazione servizi..."
    G_USER="Installazione file utente..."
    G_PKGS="Installazione pacchetti..."
    G_BT="Abilitazione Bluetooth..."
    G_AUDIO="Configurazione audio..."
    G_CLEAN="Pulizia..."
    G_ERROR="Errore di installazione"

# --- DEUTSCH (DE) ---
elif [[ "$SYSTEM_LANG" == *"de"* ]]; then
    T_BACKTITLE="R36S Bluetooth Manager von Jason"
    T_STARTING="Starte Bluetooth Manager...\nBitte warten."
    T_CHECK_INTERNET="Pruefe Internet fuer Installation..."
    T_INSTALL_DONE="Installation abgeschlossen!"
    T_INSTALL_TITLE="Installation"
    T_INSTALL_GAUGE="Installation laeuft..."
    T_ERR_INTERNET="Internet fuer Bluetooth-Installation erforderlich."
    T_ERR_TITLE="Fehler"
    T_STOPPING="Stoppe Bluetooth..."
    T_STARTING_BT="Starte Bluetooth..."
    T_BT_DISABLED="Bluetooth deaktiviert.\nBitte zuerst aktivieren."
    T_SCAN_TITLE="Suche"
    T_SCAN_GAUGE="Suche nach Geraeten..."
    T_NO_DEVICE="Kein benanntes Geraet gefunden."
    T_INFO="Info"
    T_NEARBY="Bluetooth in der Naehe"
    T_BACK="Zurueck"
    T_CHOOSE_DEV="Geraet waehlen:"
    T_SUCCESS="Erfolg"
    T_CONNECTED="ist verbunden"
    T_RETRY="Erster Versuch fehlgeschlagen...\nErneuter Versuch..."
    T_FAILED="Fehlgeschlagen"
    T_FAIL_CONNECT="Verbindung fehlgeschlagen zu"
    T_FAIL_MSG="Stellen Sie sicher, dass das Geraet im Pairing-Modus ist."
    T_FAIL_KNOWN="Pruefen Sie, ob das Geraet AN und in Reichweite ist."
    T_NO_KNOWN="Keine bekannten Geraete."
    T_KNOWN_DEV="Bekannte Geraete"
    T_CONNECT_TO="Verbinden mit:"
    T_CONNECTING_TO="Verbinde mit"
    T_NOTHING_DEL="Nichts zu loeschen."
    T_DELETE_TITLE="Loeschen"
    T_CHOOSE_DEL="Geraet zum Entfernen waehlen:"
    T_DELETING="Loesche"
    T_FORGOTTEN="Geraet entfernt."
    T_MAIN_TITLE="Hauptmenue"
    T_QUIT="Beenden"
    T_STATUS="Bluetooth Status"
    T_CONN_TO="Verbunden mit"
    T_NONE="Keinem"
    T_M_TOGGLE="Bluetooth Ein / Aus"
    T_M_SCAN="Suchen und Verbinden"
    T_M_KNOWN="Bekannte Geraete"
    T_M_FORGET="Geraet entfernen"
    T_M_QUIT="Beenden"
    T_FIXING_AUDIO="Repariere Audio-Protokolle..."
    T_PAIRING="Paarung..."
    G_INIT="Initialisierung..."
    G_EXTRACT="Extrahiere Patch..."
    G_BIN="Installiere Binaries..."
    G_SYSTEMD="Installiere Dienste..."
    G_USER="Installiere Benutzerdateien..."
    G_PKGS="Installiere Pakete..."
    G_BT="Aktiviere Bluetooth..."
    G_AUDIO="Audio-Konfiguration..."
    G_CLEAN="Aufraeumen..."
    G_ERROR="Installationsfehler"
fi

# --- Gestion de l'affichage ---
printf "\033c" > "$CURR_TTY"
printf "\e[?25l" > "$CURR_TTY"
dialog --clear

# --- FONT SELECTION ---
if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
    setfont /usr/share/consolefonts/Lat7-TerminusBold22x11.psf.gz
else
    setfont /usr/share/consolefonts/Lat7-Terminus16.psf.gz
fi

pkill -9 -f gptokeyb || true
pkill -9 -f osk.py || true

printf "\033c" > "$CURR_TTY"
printf "$T_STARTING" > "$CURR_TTY"
sleep 1

# --- Variables Globales ---
height="15"
width="50"
list_height="8"
BACKTITLE="$T_BACKTITLE"


# --- Patch Bluetooth ---
GAUGE_FD=0
PROGRESS=0

gauge_start() {
    exec 3> >(dialog --backtitle "$BACKTITLE" \
                     --title "$T_INSTALL_TITLE" \
                     --gauge "$T_INSTALL_GAUGE" 10 60 0)
    GAUGE_FD=3
}

gauge_update() {
    PROGRESS=$1
    MSG="$2"
    echo "$PROGRESS" >&$GAUGE_FD
    echo "$MSG" >&$GAUGE_FD
}

fail() {
    exec 3>&-
    dialog --backtitle "$BACKTITLE" \
           --title "$T_ERR_TITLE" \
           --msgbox "\n$G_ERROR:\n$1\n" 8 60
    exit 1
}

run_step() {
    local weight=$1
    local msg="$2"
    shift 2

    gauge_update "$PROGRESS" "$msg"
    "$@" || fail "$msg"

    PROGRESS=$((PROGRESS + weight))
    gauge_update "$PROGRESS" "$msg"
}

Installbt() {
    systemctl stop oga_events

    gauge_start

    run_step 5  "$G_INIT" \
        mkdir -p /opt/system && echo 1 > /opt/system/bt.txt

    run_step 15 "$G_EXTRACT" \
        unzip -X -oq ${GITHUB_URL} -d "${INSTALL_FOLDER}/tmp"

    run_step 15 "$G_BIN" \
        bash -c '
            mkdir -p /tmp/patch &&
            cp '"${INSTALL_FOLDER}"'/tmp/usr/local/bin/* /tmp/patch &&
            chmod 755 /tmp/patch/* &&
            chown ark:ark /tmp/patch/* &&
            mv -f /tmp/patch/* /usr/local/bin
        '

    run_step 15 "$G_SYSTEMD" \
        bash -c '
            cp '"${INSTALL_FOLDER}"'/tmp/etc/systemd/system/* /tmp/patch &&
            chmod 644 /tmp/patch/* &&
            chown root:root /tmp/patch/* &&
            mv -f /tmp/patch/* /etc/systemd/system &&
            rm -f /etc/systemd/system/multi-user.target.wants/watchforbtaudio.service &&
            rm -f /etc/systemd/system/multi-user.target.wants/oga_events.service &&
            ln -sf /etc/systemd/system/watchforbtaudio.service \
                   /etc/systemd/system/multi-user.target.wants/watchforbtaudio.service &&
            ln -sf /etc/systemd/system/oga_events.service \
                   /etc/systemd/system/multi-user.target.wants/oga_events.service
        '

    run_step 10 "$G_USER" \
        bash -c '
            cp '"${INSTALL_FOLDER}"'/tmp/home/ark/* /tmp/patch &&
            chmod 755 /tmp/patch/* &&
            chown ark:ark /tmp/patch/* &&
            mv -f /tmp/patch/* /home/ark
        '

    run_step 15 "$G_PKGS" \
        bash -c '
            tar xzf '"${INSTALL_FOLDER}"'/tmp/packages.tar.gz -C '"${INSTALL_FOLDER}"'/tmp &&
            dpkg -i '"${INSTALL_FOLDER}"'/tmp/var/cache/apt/archives/*.deb
        '

    run_step 5 "$G_BT" rfkill unblock bluetooth

    run_step 10 "$G_AUDIO" \
        bash -c '
            systemctl --global disable pulseaudio.service pulseaudio.socket &&
            usermod -aG bluetooth ark &&
            usermod -aG lp pulse &&
            usermod -aG lp,pulse-access ark &&
            cp '"${INSTALL_FOLDER}"'/tmp/etc/pulse/* /tmp/patch &&
            chmod 644 /tmp/patch/* &&
            chown root:root /tmp/patch/* &&
            mv -f /tmp/patch/* /etc/pulse &&
            systemctl enable pulseaudio &&
            systemctl start pulseaudio
        '

    run_step 10 "$G_CLEAN" \
        rm -Rf /tmp/patch "${INSTALL_FOLDER}/tmp"
    systemctl start oga_events

    gauge_update 100 "$T_INSTALL_DONE"
    sleep 0.5
    exec 3>&-
}

# --- Dependances ---
CheckDeps() {
    if [ -f /opt/system/bt.txt ]; then
        dialog --backtitle "$BACKTITLE" --title "Verification" --infobox "\n$T_CHECK_INTERNET\n" 5 50 > "$CURR_TTY"
        if ping -c 1 -W 3 8.8.8.8 > /dev/null 2>&1; then
    Installbt
  else
            dialog --backtitle "$BACKTITLE" --title "$T_ERR_TITLE" --msgbox "\n$T_ERR_INTERNET\n" 6 50 > "$CURR_TTY"
            ExitMenu
        fi
}

# --- Etat du Bleutooth ---
GetPowerStatus() {
    if rfkill list bluetooth | grep -q "Soft blocked: yes"; then return 1; fi
    if ! systemctl is-active --quiet bluetooth; then return 1; fi
    if ! echo "show" | bluetoothctl | sed 's/\x1b\[[0-9;]*m//g' | grep -q "Powered: yes"; then return 1; fi
    return 0
}

GetConnectedName() {
    local found_name=""
    found_name=$(bluetoothctl devices | while read -r _ mac name; do
        if bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes"; then
            if bluetoothctl info "$mac" | grep -q "UUID"; then
                echo "$name"
                break
            fi
        fi
    done)

    if [ -n "$found_name" ]; then
        echo "$found_name"
    else
        echo "$T_NONE"
    fi
}

has_valid_profile() {
    bluetoothctl info "$1" | grep -Eq "UUID:.*(Audio Sink|A2DP|HID|Headset)"
}

# --- Actions ---
ToggleBT() {
  if GetPowerStatus; then
      dialog --backtitle "$BACKTITLE" --title "$T_ACTION" --infobox "\n  $T_STOPPING" 5 30 > "$CURR_TTY"
      sudo bluetoothctl power off> /dev/null 2>&1
      sudo systemctl stop bluetooth> /dev/null 2>&1
      sudo systemctl disable bluetooth> /dev/null 2>&1
      sudo rfkill block bluetooth> /dev/null 2>&1
  else
      dialog --backtitle "$BACKTITLE" --title "$T_ACTION" --infobox "\n  $T_STARTING_BT" 5 35 > "$CURR_TTY"
      sudo rfkill unblock bluetooth> /dev/null 2>&1
      sudo systemctl enable bluetooth> /dev/null 2>&1
      sudo systemctl start bluetooth> /dev/null 2>&1
      sleep 1
      sudo bluetoothctl power on> /dev/null 2>&1
  fi
  sleep 2
}

ScanAndConnect() {
  if ! GetPowerStatus; then
      dialog --backtitle "$BACKTITLE" --title "$T_ERR_TITLE" --msgbox "\n $T_BT_DISABLED" 8 30 > "$CURR_TTY"
      return
  fi

  dialog --backtitle "$BACKTITLE" --title "$T_SCAN_TITLE" --infobox "\n $T_SCAN_GAUGE" 5 40 > "$CURR_TTY"
  
  bluetoothctl devices > /tmp/bt_cache_check
  while read -r line; do
      # Extraction de l'adresse MAC 
      local c_mac=$(echo "$line" | awk '{print $2}')
      if [[ "$c_mac" =~ ..:..:..:..:..:.. ]]; then
          if ! bluetoothctl info "$c_mac" | grep -q "Trusted: yes"; then
              bluetoothctl remove "$c_mac"
          fi
      fi
  done < /tmp/bt_cache_check
  rm -f /tmp/bt_cache_check
    
    bluetoothctl scan off > /dev/null 2>&1

  # Identifie d'abord si un périphérique connu est connecte
  connected_mac=""
while read -r _ mac _; do
    if is_connected_stable "$mac" && has_valid_profile "$mac"; then
        connected_mac="$mac"
        break
    fi
done < <(bluetoothctl devices)

  # Lancement du scan
  bluetoothctl scan on > /dev/null 2>&1 &
  SCAN_PID=$!
    
  (
    # Jauge pour le scan
    for i in $(seq 0 1 100); do
        echo "$i"
        sleep 0.1
    done
  ) | dialog --backtitle "$BACKTITLE" --title "$T_SCAN_TITLE" --gauge "\n $T_SCAN_GAUGE" 8 40 0 > "$CURR_TTY"
    
  kill $SCAN_PID > /dev/null 2>&1
  bluetoothctl scan off > /dev/null 2>&1

  bluetoothctl devices > /tmp/bt_scan_raw
  sed -i 's/\x1b\[[0-9;]*m//g' /tmp/bt_scan_raw
  
  IFS=$'\n'
  unset coptions
  
  while read -r line; do
    if [[ "$line" == *"Device"* ]] && [[ "$line" == *:* ]]; then
        local mac=$(echo "$line" | grep -oE '([0-9A-Fa-f]{2}:){5}([0-9A-Fa-f]{2})')
        local name=$(echo "$line" | sed "s/.*$mac //")
        
        # Nettoyage des espaces
        name=$(echo "$name" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

        if [ -n "$mac" ]; then
            # --- Filtre ---
            local valid=true
            
            # Pas de nom vide
            if [ -z "$name" ] || [ "$name" == "$line" ]; then valid=false; fi
            # Le nom ne doit pas être l'adresse MAC
            if [ "$name" == "$mac" ]; then valid=false; fi
            # Le nom ne doit pas être une adresse MAC avec des tirets
            if [[ "$name" =~ ^([0-9A-Fa-f]{2}-){5}[0-9A-Fa-f]{2}$ ]]; then valid=false; fi
            # Filtre garbage
            if [[ "$name" == *"rguments"* ]]; then valid=false; fi

            if [ "$valid" = true ]; then
                local dev_info=$(bluetoothctl info "$mac")
                local is_paired=$(echo "$dev_info" | grep "Paired: yes")
                local is_connected=$(echo "$dev_info" | grep "Connected: yes")
                
                if [ "$valid" = true ]; then
                    # Ajout de l'astérisque si connecté avec couleur violet
                    local display_name="$name"
                    if [ "$mac" == "$connected_mac" ]; then
  display_name="\Z5* $name $T_CONNECTED *\Zn"
                    fi
                    coptions+=("$mac" "$display_name")
                fi
            fi
        fi
    fi
  done < /tmp/bt_scan_raw
  rm -f /tmp/bt_scan_raw
  unset IFS

  if [ ${#coptions[@]} -eq 0 ]; then
     dialog --backtitle "$BACKTITLE" --title "$T_INFO" --msgbox "\n  $T_NO_DEVICE" 6 40 > "$CURR_TTY"
     return
  fi

  while true; do
    cselection=$(dialog \
    --colors \
   	--backtitle "$BACKTITLE" \
   	--title "$T_NEARBY" \
   	--no-collapse \
   	--clear \
	--cancel-label "$T_BACK" \
    --menu "$T_CHOOSE_DEV" $height $width $list_height \
    "${coptions[@]}" 2>&1 > "$CURR_TTY")

    if [ $? -ne 0 ]; then break; fi
    
    ConnectProcess "$cselection"
    break
  done
}

ConnectProcess() {
  local mac="$1"
  local name=$(bluetoothctl info "$mac" | grep "Alias:" | cut -d ':' -f 2- | sed 's/^ *//')
  [ -z "$name" ] && name="Device"

  # Nettoyage
  bluetoothctl scan off > /dev/null 2>&1
  bluetoothctl agent on > /dev/null 2>&1
  bluetoothctl default-agent > /dev/null 2>&1
    
  echo 1 > /tmp/bt_conn_ret
  
  (
      # --- Appairage ---
      echo "XXX"
      echo "$T_PAIRING"
      echo "XXX"
      
      # Appairage en arrière-plan
      echo "yes" | bluetoothctl pair "$mac" > /tmp/bt_pair_log 2>&1 &
      CMD_PID=$!

      local curr=0
      while kill -0 $CMD_PID 2>/dev/null; do
          curr=$((curr + 1))
          if [ $curr -gt 25 ]; then curr=25; fi
          echo $curr
          sleep 0.2
      done
      wait $CMD_PID

      for i in $(seq $curr 30); do echo $i; sleep 0.05; done
    
      bluetoothctl trust "$mac" > /dev/null 2>&1
      
      echo "XXX"
      echo "$T_FIXING_AUDIO"
      echo "XXX"

      for i in $(seq 30 50); do echo $i; sleep 0.1; done

      echo "XXX"
      echo "$T_CONNECTING_TO $name..."
      echo "XXX"
      
      SUCCESS=1

      for attempt in 1 2 3; do
          local start_pct=50
          local end_pct=65
          
          if [ $attempt -eq 2 ]; then start_pct=65; end_pct=80; fi
          if [ $attempt -eq 3 ]; then start_pct=80; end_pct=95; fi
          
          # Lancement de la connexion en arrière-plan
          bluetoothctl connect "$mac" > /tmp/bt_conn_log 2>&1 &
          CMD_PID=$!
          
          curr=$start_pct

          while kill -0 $CMD_PID 2>/dev/null; do
              curr=$((curr + 1))
              if [ $curr -gt $end_pct ]; then curr=$end_pct; fi
              echo $curr
              sleep 0.2
          done
          wait $CMD_PID
          
          # Vérification
          if is_connected_stable "$mac" && has_valid_profile "$mac"; then

              SUCCESS=0

              for i in $(seq $curr 100); do echo $i; sleep 0.02; done
              break
          fi
          
          # Si échec 
          if [ $attempt -lt 3 ]; then
              echo "XXX"
              echo "$T_CONNECTING_TO $name ($attempt/3)..."
              echo "XXX"

              local next_start=$end_pct
              for i in $(seq $curr $next_start); do echo $i; sleep 0.1; done
          fi
      done

      echo $SUCCESS > /tmp/bt_conn_ret
      sleep 0.5
  ) | dialog --backtitle "$BACKTITLE" --title "Connexion" --gauge "\n $T_PAIRING" 8 50 > "$CURR_TTY"
  
  CONN_RES=$(cat /tmp/bt_conn_ret)

  if [ "$CONN_RES" -eq 0 ]; then
      dialog --backtitle "$BACKTITLE" --title "$T_SUCCESS" --msgbox "\n $name $T_CONNECTED " 7 $width > "$CURR_TTY"
  else
    
      (
          echo "XXX"
          echo "$T_RETRY"
          echo "XXX"
          echo "0"
          
          pulseaudio -k > /dev/null 2>&1

          for i in $(seq 0 30); do echo $i; sleep 0.1; done
          
          pulseaudio --start > /dev/null 2>&1
    
          for i in $(seq 30 50); do echo $i; sleep 0.1; done
    
          pactl load-module module-bluetooth-discover > /dev/null 2>&1

          bluetoothctl connect "$mac" > /tmp/bt_conn_log 2>&1 &
          CMD_PID=$!
          
          curr=50
          while kill -0 $CMD_PID 2>/dev/null; do
              curr=$((curr + 1))
              if [ $curr -gt 95 ]; then curr=95; fi
              echo $curr
              sleep 0.2
          done
          wait $CMD_PID
          
          if is_connected_stable "$mac" && has_valid_profile "$mac"; then
    RET=0
else
    RET=1
fi

          echo $RET > /tmp/bt_conn_ret

          for i in $(seq $curr 100); do echo $i; sleep 0.05; done
          sleep 0.5
      ) | dialog --backtitle "$BACKTITLE" --title "Tentative 2 (Fix Audio)" --gauge "\n $T_RETRY" 8 50 > "$CURR_TTY"

      CONN_RES=$(cat /tmp/bt_conn_ret)

      if [ "$CONN_RES" -eq 0 ]; then
          dialog --backtitle "$BACKTITLE" --title "$T_SUCCESS" --msgbox "\n $name $T_CONNECTED" 7 $width > "$CURR_TTY"
      else
          local error_msg=$(grep "Failed" /tmp/bt_pair_log | tail -n 1)
          if [ -z "$error_msg" ]; then 
            error_msg=$(grep "Failed" /tmp/bt_conn_log | tail -n 1)
          fi
          if [ -z "$error_msg" ]; then error_msg="Error"; fi
          
          dialog --backtitle "$BACKTITLE" --title "$T_FAILED" --msgbox "\n $T_FAIL_CONNECT $name.\n\n Error: $error_msg\n\n $T_FAIL_MSG" 12 $width > "$CURR_TTY"
      fi
  fi
  rm -f /tmp/bt_pair_log /tmp/bt_conn_log /tmp/bt_conn_ret
}

is_connected_stable() {
    local mac="$1"
    for i in {1..5}; do
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            sleep 1
            if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
                return 0
            fi
        fi
        sleep 1
    done
    return 1
}

ListKnownAndConnect() {
    if ! GetPowerStatus; then
      dialog --backtitle "$BACKTITLE" --title "$T_ERR_TITLE" --msgbox "\n $T_BT_DISABLED" 8 30 > "$CURR_TTY"
      return
  fi
    
  bluetoothctl devices > /tmp/bt_paired_raw
  sed -i 's/\x1b\[[0-9;]*m//g' /tmp/bt_paired_raw
  
  IFS=$'\n'
  unset koptions
  while read -r line; do
    if [[ "$line" == *:* ]]; then
        local mac=$(echo "$line" | awk '{print $2}')
        local name=$(echo "$line" | cut -d ' ' -f 3-)

        if ! bluetoothctl info "$mac" | grep -q "Paired: yes"; then
            continue
        fi
      
        koptions+=("$name" "$mac")
    fi
done < /tmp/bt_paired_raw
  rm -f /tmp/bt_paired_raw
  unset IFS
  
  if [ ${#koptions[@]} -eq 0 ]; then
     dialog --backtitle "$BACKTITLE" --title "$T_INFO" --msgbox "\n $T_NO_KNOWN" 7 33 > "$CURR_TTY"
     return
  fi
    
  while true; do
    kselection=$(dialog \
   	--backtitle "$BACKTITLE" \
   	--title "$T_KNOWN_DEV" \
   	--no-collapse \
   	--clear \
	--cancel-label "$T_BACK" \
    --menu "$T_CONNECT_TO" $height $width $list_height \
    "${koptions[@]}" 2>&1 > "$CURR_TTY")

    if [ $? -ne 0 ]; then break; fi

    local target_mac=$(bluetoothctl devices | grep -F "$kselection" | awk '{print $2}' | head -n 1)
    if [ -z "$target_mac" ]; then target_mac="$kselection"; fi

    # Nettoyage preventif
    bluetoothctl trust "$target_mac" > /dev/null 2>&1
    
    echo 1 > /tmp/bt_know_ret
    
    (

      echo "XXX"
      echo "$T_FIXING_AUDIO"
      echo "XXX"
      
      for i in $(seq 0 20); do echo $i; sleep 0.05; done
      
      echo "XXX"
      echo "$T_CONNECTING_TO $kselection..."
      echo "XXX"
      
      SUCCESS=1

      for attempt in 1 2 3; do
          local start_pct=20
          local end_pct=50
          
          if [ $attempt -eq 2 ]; then start_pct=50; end_pct=75; fi
          if [ $attempt -eq 3 ]; then start_pct=75; end_pct=95; fi
          
          bluetoothctl connect "$target_mac" > /tmp/bt_know_log 2>&1 &
          CMD_PID=$!
          
          curr=$start_pct

          while kill -0 $CMD_PID 2>/dev/null; do
              curr=$((curr + 1))
              if [ $curr -gt $end_pct ]; then curr=$end_pct; fi
              echo $curr
              sleep 0.2
          done
          wait $CMD_PID
          
          if is_connected_stable "$target_mac" && has_valid_profile "$target_mac"; then
              SUCCESS=0

              for i in $(seq $curr 100); do echo $i; sleep 0.02; done
              break
          fi

          if [ $attempt -lt 3 ]; then
              echo "XXX"
              echo "$T_CONNECTING_TO $kselection ($attempt/3)..."
              echo "XXX"
              local next_start=$end_pct
              for i in $(seq $curr $next_start); do echo $i; sleep 0.1; done
          fi
      done
      
      echo $SUCCESS > /tmp/bt_know_ret
      sleep 0.5
    ) | dialog --backtitle "$BACKTITLE" --title "Connexion" --gauge "\n $T_CONNECTING_TO $kselection..." 8 50 > "$CURR_TTY"
    
    CONN_RES=$(cat /tmp/bt_know_ret)

    if [ "$CONN_RES" -eq 0 ]; then
        dialog --backtitle "$BACKTITLE" --title "$T_SUCCESS" --msgbox "\n $T_SUCCESS !" 7 20 > "$CURR_TTY"
    else

        (
          echo "XXX"
          echo "$T_RETRY"
          echo "XXX"
          echo "0"
          
          pulseaudio -k > /dev/null 2>&1

          for i in $(seq 0 30); do echo $i; sleep 0.1; done
          
          pulseaudio --start > /dev/null 2>&1

          for i in $(seq 30 50); do echo $i; sleep 0.1; done
          
          pactl load-module module-bluetooth-discover > /dev/null 2>&1
          
          # Connexion finale
          bluetoothctl connect "$target_mac" > /tmp/bt_know_log 2>&1 &
          CMD_PID=$!
          
          curr=50
          while kill -0 $CMD_PID 2>/dev/null; do
              curr=$((curr + 1))
              if [ $curr -gt 95 ]; then curr=95; fi
              echo $curr
              sleep 0.2
          done
          wait $CMD_PID
          
          if is_connected_stable "$target_mac" && has_valid_profile "$target_mac"; then
    RET=0
else
    RET=1
fi
echo $RET > /tmp/bt_know_ret
      
          for i in $(seq $curr 100); do echo $i; sleep 0.05; done
          sleep 0.5
        ) | dialog --backtitle "$BACKTITLE" --title "Tentative 2 (Fix Audio)" --gauge "\n $T_RETRY" 8 50 > "$CURR_TTY"
        
        CONN_RES=$(cat /tmp/bt_know_ret)

        if [ "$CONN_RES" -eq 0 ]; then
            dialog --backtitle "$BACKTITLE" --title "$T_SUCCESS" --msgbox "\n $T_SUCCESS !" 7 20 > "$CURR_TTY"
        else
            # On recupere le message d'erreur
            local k_err=$(cat /tmp/bt_know_log | grep -v "Attempting" | tail -n 1)
            [ -z "$k_err" ] && k_err="Connection Failed."
            
            dialog --backtitle "$BACKTITLE" --title "$T_FAILED" --msgbox "\n $T_FAIL_CONNECT $kselection\n\n Error: $k_err\n\n $T_FAIL_KNOWN" 12 $width > "$CURR_TTY"
        fi
    fi
    rm -f /tmp/bt_know_log /tmp/bt_know_ret
    break
  done
}

DeleteDevice() {
    if ! GetPowerStatus; then
      dialog --backtitle "$BACKTITLE" --title "$T_ERR_TITLE" --msgbox "\n $T_BT_DISABLED" 8 30 > "$CURR_TTY"
      return
  fi
  bluetoothctl devices > /tmp/bt_paired_raw
  sed -i 's/\x1b\[[0-9;]*m//g' /tmp/bt_paired_raw
  
  IFS=$'\n'
  unset doptions
  while read -r line; do
    if [[ "$line" == *:* ]]; then
        local mac=$(echo "$line" | awk '{print $2}')
        local name=$(echo "$line" | cut -d ' ' -f 3-)

        if ! bluetoothctl info "$mac" | grep -q "Paired: yes"; then
            continue
        fi
      
        doptions+=("$name" "$mac")
    fi
done < /tmp/bt_paired_raw
  rm -f /tmp/bt_paired_raw
  unset IFS
  
  if [ ${#doptions[@]} -eq 0 ]; then
     dialog --backtitle "$BACKTITLE" --title "$T_INFO" --msgbox "\n $T_NOTHING_DEL" 7 25 > "$CURR_TTY"
     return
  fi

  while true; do
    dselection=$(dialog \
   	--backtitle "$BACKTITLE" \
   	--title "$T_DELETE_TITLE" \
   	--no-collapse \
   	--clear \
	--cancel-label "$T_BACK" \
    --menu "$T_CHOOSE_DEL" $height $width $list_height \
    "${doptions[@]}" 2>&1 > "$CURR_TTY")

    if [ $? -ne 0 ]; then break; fi

    local target_mac=$(bluetoothctl devices | grep -F "$dselection" | awk '{print $2}' | head -n 1)
    if [ -z "$target_mac" ]; then target_mac="$dselection"; fi
    
    dialog --backtitle "$BACKTITLE" --title "$T_ACTION" --infobox "\n $T_DELETING $dselection..." 5 50 > "$CURR_TTY"
    bluetoothctl untrust "$target_mac" > /dev/null 2>&1
    bluetoothctl remove "$target_mac" > /dev/null 2>&1

    dialog --backtitle "$BACKTITLE" --title "$T_SUCCESS" --msgbox "\n $T_FORGOTTEN" 7 30 > "$CURR_TTY"
    break
  done
}

ExitMenu() {
    printf "\033c" > "$CURR_TTY"
    printf "\e[?25h" > "$CURR_TTY" 
    pkill -f "gptokeyb -1 Bluetooth Manager.sh" || true 
    if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
        setfont /usr/share/consolefonts/Lat7-Terminus20x10.psf.gz
    fi
    exit 0
}

# --- Menu Principal ---
MainMenu() {
  CheckDeps
  
  while true; do
    if GetPowerStatus; then
        # \Z2 = Vert
        BT_STAT="\Z2ON\Zn"
        RAW_NAME=$(GetConnectedName)
        # \Z4 = Bleu
        DEV_NAME="\Z4$RAW_NAME\Zn"
    else
        # \Z1 = Rouge
        BT_STAT="\Z1OFF\Zn"
        DEV_NAME="$T_NONE"
    fi
    
    mainselection=$(dialog \
    --colors \
   	--backtitle "$BACKTITLE" \
   	--title "$T_MAIN_TITLE" \
   	--no-collapse \
   	--clear \
	--cancel-label "$T_QUIT" \
    --menu "\n$T_STATUS : $BT_STAT\n$T_CONN_TO : $DEV_NAME\n " $height $width 6 \
    1 "$T_M_TOGGLE" \
    2 "$T_M_SCAN" \
    3 "$T_M_KNOWN" \
    4 "$T_M_FORGET" \
    5 "$T_M_QUIT" \
    2>&1 > "$CURR_TTY")
    
    if [ $? -ne 0 ]; then ExitMenu; fi
    
    case $mainselection in
        1) ToggleBT ;;
        2) ScanAndConnect ;;
        3) ListKnownAndConnect ;;
        4) DeleteDevice ;;
        5) ExitMenu ;;
    esac
  done
}

# --- Lancement Manette & Script ---
sudo chmod 666 /dev/uinput
export SDL_GAMECONTROLLERCONFIG_FILE="/opt/inttools/gamecontrollerdb.txt"
/opt/inttools/gptokeyb -1 "Bluetooth Manager.sh" -c "/opt/inttools/keys.gptk" > /dev/null 2>&1 &

trap ExitMenu EXIT
MainMenu