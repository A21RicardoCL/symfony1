FROM bitnami/symfony
WORKDIR /
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN apt update && apt install -y curl build-essential git

RUN curl -lsLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
ENV PATH "$PATH:/root/.symfony/bin"

RUN apt install -y symfony-cli
RUN symfony server:ca:install
RUN git config --global user.email "a21ricardocl@iessanclemente.net"
RUN git config --global user.name "a21ricardocl"
WORKDIR /var/www
CMD chmod -R 777 /opt/bitnami/php/var/run && cd symfony/ && chmod -R 777 . && rm -rf .git && \
    composer install && symfony serve