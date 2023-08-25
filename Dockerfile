FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install apache2 -y && \
    apt install php libapache2-mod-php php-mbstring php-cli php-bcmath php-json php-xml php-zip php-pdo php-common php-tokenizer php-mysql curl php-curl -y    

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html

RUN composer create-project laravel/laravel laravelapp

RUN chown -R www-data:www-data /var/www/html/laravelapp

RUN chmod -R 775 /var/www/html/laravelapp/storage

COPY laravel.conf /etc/apache2/sites-available/laravel.conf

RUN a2ensite laravel.conf

RUN a2enmod rewrite

RUN service apache2 restart

CMD ["apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
