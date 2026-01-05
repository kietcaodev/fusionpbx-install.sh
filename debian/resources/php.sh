#!/bin/sh

apt install -y ca-certificates apt-transport-https curl
curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/sury-php.gpg

echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ bookworm main" \
> /etc/apt/sources.list.d/php-sury.list

sudo apt update && sudo apt upgrade -y
apt-get install -y --no-install-recommends php8.1 php8.1-common php8.1-cli php8.1-dev php8.1-fpm php8.1-pgsql php8.1-sqlite3 php8.1-odbc php8.1-curl php8.1-imap php8.1-xml php8.1-gd php8.1-mbstring php8.1-ldap php8.1-inotify php8.1-snmp
service php8.1-fpm start
service php8.1-fpm status

sed -i 's#post_max_size = .*#post_max_size = 80M#g' /etc/php/8.1/fpm/php.ini
sed -i 's#upload_max_filesize = .*#upload_max_filesize = 80M#g' /etc/php/8.1/fpm/php.ini
sed -i 's#;max_input_vars = .*#max_input_vars = 8000#g' /etc/php/8.1/fpm/php.ini
sed -i 's#; max_input_vars = .*#max_input_vars = 8000#g' /etc/php/8.1/fpm/php.ini
./ioncube.sh
systemctl daemon-reload
systemctl restart php8.1-fpm
systemctl status php8.1-fpm
