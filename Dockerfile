FROM php:8.2-apache
COPY homepage/ /var/www/html/
# Enable Apache modules
RUN a2enmod rewrite
# Install any extensions you need
RUN docker-php-ext-install mysqli pdo pdo_mysql
