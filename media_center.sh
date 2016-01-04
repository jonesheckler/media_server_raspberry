
##Script para criar um Media Center usando o Raspberry Pi
 # Autor: Jones Heckler
 # twitter: @kanelaoka
 # git: https://github.com/kanelaoka
### 
 

# Usando o sistema operacional Wheezy

# configurar o diretorio de downloads dos torrents

dirDownload="/var/lib/minidlna/Filmes-e-Seriados"

# configurar o UUID do HD externo 
# descobrir o UUID do HD externo executar o comando
## sudo blkid
# copiar UUID e colar na variavel abaixo

uuid="722083C320838D33"
sistemaArquivo="ntfs"
localDev="/dev/sda1"



#### -------- Instalar MiniDLNA ----------####

# Instalar o Minidlna

apt-get -y update
apt-get -y upgrade
apt-get -y install minidlna

# auto-atualizar novos filmes

sed -i 's/#inotify=no/inotify=yes/g' /etc/minidlna.conf


# iniciar o minidlna
# Now we start minidlna and we should have a working media server!

service minidlna start



# Iniciar o Minidlna ao iniciar o sistema
# Finally, ask minidlna to start up automatically upon boot.

update-rc.d minidlna defaults


#apos configurar tudo fazer com que o minidlna force a checagem das pastas sempre que iniciar
#colocar ao final do arquivo  /etc/rc.local

echo "sudo service minidlna force-reload" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local


#### ---------Instalar o Transmission-Deamon ----------####

apt-get -y install transmission-daemon


# Para alterar a configuração é necessário parar o daemon

service transmission-daemon stop

# mudando usuario do transmission para root

sed -i 's/USER=debian-transmission/USER=root/g' /etc/init.d/transmission-daemon

#modificar json

sed -i 's/"rpc-whitelist-enabled": true,/"rpc-whitelist-enabled": false,/g' /etc/transmission-daemon/settings.json


# mudar o diretorio que guarda os downloads

sed -i "s|\/var\/lib\/transmission-daemon\/downloads|$dirDownload|g" /etc/transmission-daemon/settings.json



# Com as configurações alteradas reiniciar o daemon

service transmission-daemon start




######-----------Montar HD Externo ------------######

apt-get -y install ntfs-3g ntfs-config gdisk
mkdir -p /mnt/ext
mount $localDev /mnt/ext

echo "UUID=$uuid /mnt/ext $sistemaArquivo defaults 0 0" >>  /etc/fstab 



#Criar links para o minidlna achar a pasta dos filmes

ln -s /mnt/ext/Seriados-HD $dirDownload


#####--------Acessar o HD Externo pela rede com Samba ----------############

apt-get -y install samba samba-common-bin


echo "[disco_usb] \ncomment = Disco USB \npath = /mnt/ext \nread only = No \ncreate mask = 0777 \ndirectory mask = 0777 \nguest only = Yes \nguest ok = Yes" >> /etc/samba/smb.conf
service samba restart


apt-get -y update
apt-get -y upgrade

reboot


