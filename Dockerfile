FROM ubuntu:latest
WORKDIR /usr/src/app

RUN apt update && apt upgrade
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt install -y nginx php7.2 php7.2-fpm php7.2-curl php7.2-dom php7.2-gd php7.2-json php7.2-mbstring php7.2-pdo php7.2-tokenizer php7.2-zip php7.2-mysql composer
RUN composer create-project flarum/flarum . --stability=beta
RUN composer require fof/gamification
RUN composer require "fof/auth-discord:*"
RUN composer require fof/bbcode-details
RUN composer require fof/default-user-preferences
RUN composer require fof/formatting
RUN composer require fof/transliterator
RUN rm /etc/nginx/sites-enabled/default
COPY ./nginx/php.conf /etc/nginx/php.conf
COPY ./nginx/flarum.conf /etc/nginx/conf.d/flarum.conf
RUN chown -R www-data:www-data /usr/src/app/
RUN service nginx reload
COPY ./start.sh ./start.sh
CMD [ "./start.sh" ]