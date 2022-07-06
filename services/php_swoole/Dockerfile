# hyperf/hyperf:7.4
#
# @link     https://www.hyperf.io
# @document https://doc.hyperf.io
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

FROM hyperf/hyperf:7.4-alpine-v3.11-base
# FROM hyperf/hyperf:7.4-alpine-v3.14-swoole 不需要额外定制可用
# https://hub.docker.com/layers/hyperf/hyperf/hyperf/7.4-alpine-v3.14-swoole/images/sha256-eeed753f2e6cb58f210be3c4177d5fbdd0458752f0d355bc30bf745181781ce9?context=explore
# swoole编译参数--enable-trace-log 会导致async-queue异常

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ARG TZ
ARG SWOOLE_VERSION
ARG SWOOLE_PHP_COMPOSER_VERSION

##
# ---------- env settings ----------
##
ENV SW_VERSION=${SWOOLE_VERSION:-"v4.8.5"} \
    COMPOSER_VERSION=${SWOOLE_PHP_COMPOSER_VERSION:-"2.3.5"} \
    #  install and remove building packages
    PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc-dev make php7-dev php7-pear pkgconf re2c pcre-dev pcre2-dev zlib-dev libtool automake"

RUN apk add --no-cache tzdata \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone
    
# update
RUN set -ex \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk update \
    # for swoole extension libaio linux-headers
    && apk add --no-cache libstdc++ openssl git bash \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS libaio-dev openssl-dev curl-dev \
    # download
    && cd /tmp \
    && curl -SL "https://github.com/swoole/swoole-src/archive/${SW_VERSION}.tar.gz" -o swoole.tar.gz \
    && ls -alh \
    # php extension:swoole
    && cd /tmp \
    && mkdir -p swoole \
    && tar -xf swoole.tar.gz -C swoole --strip-components=1 \
    && ln -s /usr/bin/phpize7 /usr/local/bin/phpize \
    && ln -s /usr/bin/php-config7 /usr/local/bin/php-config \
    && ( \
        cd swoole \
        && phpize \
        && ./configure --enable-sockets --enable-openssl --enable-http2 --enable-swoole-curl --enable-swoole-json  \
        && make -s -j$(nproc) && make install \
    ) \
    && echo "memory_limit=1G" > /etc/php7/conf.d/00_default.ini \
    && echo "log_errors = On" > /etc/php7/conf.d/00_default.ini\
    && echo "display_errors = 1" > /etc/php7/conf.d/00_default.ini\
    && echo "error_log = /var/log/php/php.log" > /etc/php7/conf.d/00_default.ini\
    && echo "opcache.enable_cli = 'On'" >> /etc/php7/conf.d/00_opcache.ini \
    && echo "extension=swoole.so" > /etc/php7/conf.d/50_swoole.ini \
    && echo "swoole.use_shortname = 'Off'" >> /etc/php7/conf.d/50_swoole.ini \
    # rdkafka
    && apk add --no-cache php7-dev php7-pear \
    && apk add --no-cache \
    librdkafka-dev \
    && curl -O https://pear.php.net/go-pear.phar \
    && php go-pear.phar \
    && pecl install rdkafka && pecl install oauth\
    && echo "extension=rdkafka.so" > /etc/php7/conf.d/rdkafka.ini \
    # install composer
    && wget -nv -O /usr/local/bin/composer https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && chmod u+x /usr/local/bin/composer \
    # php info
    && php -v \
    && php -m \
    && php --ri swoole \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    # ---------- clear works ----------
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/local/bin/php* \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
    WORKDIR /opt/www