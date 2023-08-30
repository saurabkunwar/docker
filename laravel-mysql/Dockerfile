FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install apache2 -y && \
    apt install php git libapache2-mod-php php-mbstring php-cli php-bcmath php-json php-xml php-zip php-pdo php-common php-tokenizer php-mysql curl php-curl -y    

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html

RUN git clone https://github.com/thecodeholic/laravel-10-blog.git

RUN chown -R www-data:www-data /var/www/html/laravel-10-blog

RUN chmod -R 775 /var/www/html/laravel-10-blog/storage

COPY laravel.conf /etc/apache2/sites-available/laravel.conf

COPY .env /var/www/html/laravel-10-blog/.env

RUN a2ensite laravel.conf

RUN a2enmod rewrite

RUN service apache2 restart

WORKDIR /var/www/html/laravel-10-blog

RUN composer update

RUN php artisan key:generate

CMD ["apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
