#!/bin/bash

# Instalamos el gestor de paquetes de Python pip y nginx:
sudo apt-get update && sudo apt-get install -y python3-pip nginx

# Instalamos pipenv:
pip3 install pipenv

# Añadimos el directorio de instalación de pipenv al PATH:
PATH=$PATH:/home/$USER/.local/bin
pipenv --version

# Instalamos el paquete dotenv:
pip3 install python-dotenv

# Creamos el directorio de trabajo de la aplicación:
sudo mkdir -p /var/www/app

# Le damos permisos al directorio:
sudo chown -R $USER:www-data /var/www/app
sudo chmod -R 775 /var/www/app

# Nos movemos al directorio:
cd /var/www/app

# Copiamos el archivo .env al directorio:
cp /vagrant/.env /var/www/app

# Inicializamos el entorno virtual:
pipenv shell

# Instalamos las dependencias de la aplicación:
pipenv install flask gunicorn

# Copiamos los archivos de la aplicación al directorio:
cp /vagrant/application.py /var/www/app
cp /vagrant/wsgi.py /var/www/app

# Sacamos la ruta del ejecutable de gunicorn:
which gunicorn
# /home/vagrant/.local/share/virtualenvs/app-1lvW3LzD/bin/gunicorn

# Salimos del entorno virtual:
exit

# Creamos el archivo de servicio de systemd:
sudo cp /vagrant/flask_app.service /etc/systemd/system

# Recargamos los servicios de systemd:
sudo systemctl daemon-reload

# Habilitamos y arrancamos el servicio:
sudo systemctl enable flask_app
sudo systemctl start flask_app

# Configuramos el archivo de conf de nginx:
sudo cp /vagrant/app.conf /etc/nginx/sites-available/

# Creamos un enlace simbólico al archivo de configuración:
sudo ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/

# Reiniciamos nginx:
sudo systemctl restart nginx
sudo systemctl status nginx

# ----------------- TAREA DE AMPLIACIÓN -----------------

# Instalamos git:
sudo apt-get install -y git

# Nos movemos al directorio var/www:
cd /var/www/

# Le damos permisos al directorio:
sudo chown -R $USER:www-data /var/www
sudo chmod -R 775 /var/www

# Clonamos el repositorio de la aplicación:
git clone https://github.com/Azure-Samples/msdocs-python-flask-webapp-quickstart.git

# Le cambio el nombre para que sea mas manejable:
mv msdocs-python-flask-webapp-quickstart/ msdocs

# Copiamos el archivo .env al directorio:
cp /vagrant/.env /var/www/msdocs

# Inicializamos el entorno virtual:
pipenv shell

# Instalamos las dependencias de la aplicación:
pipenv install -r requirements.txt

# Copiamos los archivos de la aplicación al directorio:
cp /vagrant/application.py /var/www/msdocs-python-flask-webapp-quickstart
cp /vagrant/wsgi.py /var/www/msdocs-python-flask-webapp-quickstart

# Sacamos la ruta del ejecutable de gunicorn:
which gunicorn
# /home/vagrant/.local/share/virtualenvs/msdocs-y3qRkKm-/bin/gunicorn

# Salimos del entorno virtual:
exit

# Creamos el archivo de servicio de systemd:
sudo cp /vagrant/flask_app2.service /etc/systemd/system

# Recargamos los servicios de systemd:
sudo systemctl daemon-reload

# Habilitamos y arrancamos el servicio:
sudo systemctl enable flask_app2
sudo systemctl start flask_app2

# Configuramos el archivo de conf de nginx:
sudo cp /vagrant/msdocs.conf /etc/nginx/sites-available/

# Creamos un enlace simbólico al archivo de configuración:
sudo ln -s /etc/nginx/sites-available/msdocs.conf /etc/nginx/sites-enabled/

# Reiniciamos nginx:
sudo systemctl restart nginx
sudo systemctl status nginx