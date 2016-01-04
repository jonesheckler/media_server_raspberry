# Guia de Instalação - Media Center for PI
Scripts for PI, instalando MiniDLNA, Samba e Cliente Torrents

Após Rodar o Script você pode baixar seus torrents diretamente pelo Raspberry Pi no endereço

http://IP_do_PI:9091/transmission/

usuario: transmission
senha: transmission

Pode acessar os arquivos do HD Externo diretamente pela rede:

IP_do_PI/disco_usb

# Configuração

Para fazer o download execute seguinte comando

	$ git clone https://github.com/kanelaoka/media_server_raspberry_pi.git

caso não tenha o git instalado execute o seguinte comando

	$ sudo apt-get install git-core

Após fazer download do arquivo, precisa dar permissão de escrita para o mesmo
para isso execute o seguinte comando

	$ sudo chmod +x media_center.sh


Abra o arquivo media_center.sh com seu editor preferido e altere 
os parâmetros necessários.

	$ nano media_center.sh

edite a variável dirDownload
altere apenas o nome da pasta, deixe o caminho padrão /var/lib/minidlna/

Esse é o caminho que ira salvar os downloads e também já o caminho para o 
DLNA reconhecer os filmes e series.
não se preocupe essa pasta é apenas um apelido, pois os arquivos serão salvos diretamente
no HD Externo

# Configurar HD Externo

O Script já esta configurado para salvar os arquivos no HD externo ligado ao 
Raspberry Pi. 
O script também já irá montar o HD externo e configurar o mesmo no caminho /mnt/ext
esse caminho pode ser alterado caso queira, basta editar o script conforme a necessidade


os outros campos para mudar são referente ao HD Externo
para isso execute o seguinte comando

	$ sudo blkid

Copie os códigos e cole nas variáveis abaixo
no meu caso a resposta foi a seguinte

	$ /dev/sda1: LABEL="SANSUNG" UUID="722083C320838D33" TYPE="ntfs

e colei as variáveis da seguinte maneira, altere conforme a sua resposta 
	$uuid="722083C320838D33"
	
	$sistemaArquivo="ntfs"
	
	$localDev="/dev/sda1"

Depois de alterar as variáveis, é só rodar o script e buscar uma cerveja.

	$ ./media_center.sh