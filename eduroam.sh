# Recoge los datos
clear
echo "Configurador de eduroam"
echo "by Xabierland"
echo " "
echo "Introduce tu usuario de la UPV/EHU"
read usuario
echo "Introduce tu contraseña"
read contrasena
echo " "
echo "Configurando..."
echo " "

# Descargar el certificado

wget https://github.com/Xabierland/eduroam/blob/ea5dbbbd1ef1ccba287121d189fcec5e4672817c/ca.pem -O /home/$USER/.config/cat_installer/ca.pem

# Crea el archivo de configuración
echo "[connection]
id=eduroam
uuid=b749c5ca-6cfa-477e-8354-c9f1a8d3ba2e
type=wifi
permissions=user:$USER:;

[wifi]
ssid=eduroam

[wifi-security]
group=ccmp;tkip;
key-mgmt=wpa-eap
pairwise=ccmp;
proto=rsn;

[802-1x]
altsubject-matches=DNS:freeradius.ehu.es;
ca-cert=/home/xabierland/.config/cat_installer/ca.pem
eap=ttls;
identity=$usuario
password=$contrasena
phase2-auth=pap

[ipv4]
method=auto

[ipv6]
addr-gen-mode=default
method=auto

[proxy]