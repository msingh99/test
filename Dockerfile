FROM richarvey/nginx-php-fpm

# Enable "mod-rewrite"
RUN sed -i 's#try_files $uri $uri/ =404;#try_files $uri $uri/ /index.php?$args;#g' /etc/nginx/sites-available/default.conf

# Install bcmath
RUN docker-php-ext-install bcmath
