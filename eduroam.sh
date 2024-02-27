# Borrar posibles archivos anteriores
sudo rm /etc/NetworkManager/system-connections/b749c5ca-6cfa-477e-8354-c9f1a8d3ba2e.nmmeta

# Recoge los datos
clear
echo "Configurador de eduroam"
echo "by Xabierland"
echo " "
echo "Introduce tu LDAP de la UPV/EHU"
read usuario
echo "Introduce tu contraseña"
read contrasena
echo " "
echo "Configurando..."
echo " "

# Descargar el certificado

cp ca.pem /home/$USER/.config/cat_installer/ca.pem > /dev/null

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
ca-cert=/home/$USER/.config/cat_installer/ca.pem
eap=ttls;
identity=$usuario@ehu.es
password=$contrasena
phase2-auth=pap

[ipv4]
method=auto

[ipv6]
addr-gen-mode=default
method=auto

[proxy]" | sudo tee /etc/NetworkManager/system-connections/eduroam.nmconnection > /dev/null

# Cambia los permisos del archivo
sudo chmod 600 /etc/NetworkManager/system-connections/eduroam.nmconnection
sudo chown root:root /etc/NetworkManager/system-connections/eduroam.nmconnection

# Reinicia NetworkManager
sudo systemctl restart NetworkManager

# Mensaje final
echo "Listo!"