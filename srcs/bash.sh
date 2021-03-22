service mysql start

# Config Access
chown -R www-data /var/www/*
chmod -R 777 /var/www/*

# Generate website folder
mkdir /var/www/higukku && touch /var/www/higukku/index.php
echo "<?php phpinfo(); ?>" >> /var/www/higukku/index.php

# SSL
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/higukku.pem -keyout /etc/nginx/ssl/higukku.key -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42 School/OU=rchallie/CN=higukku"

# Config NGINX
mv ./tmp/nginx-conf /etc/nginx/sites-available/higukku
ln -s /etc/nginx/sites-available/higukku /etc/nginx/sites-enabled/higukku
rm -rf /etc/nginx/sites-enabled/default

# Config MYSQL
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# DL phpmyadmin
mkdir /var/www/higukku/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/higukku/phpmyadmin
mv ./tmp/phpmyadmin.inc.php /var/www/higukku/phpmyadmin/config.inc.php

# DL wordpress
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz 
mv wordpress /var/www/higukku
mv wp-config.php /var/www/higukku/wordpress

service php7.3-fpm start
service nginx start
tail -f /dev/null
bash