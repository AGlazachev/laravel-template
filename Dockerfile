FROM php:7.3-fpm

# Set working directory
WORKDIR /var/www


# Install dependencies
RUN docker-php-ext-install opcache

RUN apt-get update &&\
    apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git &&\
    rm -rf /var/lib/apt/lists/*
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/conf.d/local.ini
RUN cd ~ \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential
RUN apt-get update -y && apt-get install -y \
  libicu-dev \
  && docker-php-ext-configure intl \
  && docker-php-ext-install intl
RUN apt-get update && apt-get install -y \
    build-essential \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    nano \
    unzip \
    git \
    curl \
    libzip-dev
RUN apt-get update && apt-get install -y wget git unzip \
    && pecl install xdebug-2.7.1 \
    && docker-php-ext-enable xdebug
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN printf "\n" | pecl install imagick
RUN docker-php-ext-enable imagick
# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN apt-get update && apt-get install -y libpng-dev
RUN apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev
RUN docker-php-ext-configure gd \
    --with-gd \
    --with-webp-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-xpm-dir \
    --with-freetype-dir
RUN docker-php-ext-install gd
# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update &&\
    apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git &&\
    rm -rf /var/lib/apt/lists/*
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/php.ini

ENV TZ 'Europe/Moscow'
ENV LC_ALL ru_RU.UTF-8
ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU.UTF-8
RUN echo $TZ > /etc/timezone
#RUN apt-get update && DEBIAN_FRONTEND=noninteractive && apt-get install -y locales tzdata systemd
RUN sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=ru_RU.UTF-8
RUN echo "LANGUAGE=ru_RU.UTF-8" >> /etc/default/locale && \
    echo "LC_ALL=ru_RU.UTF-8" >> /etc/default/locale
RUN rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
RUN localedef -c -f UTF-8 -i ru_RU ru_RU.UTF-8
RUN apt-get clean
RUN echo "Europe/Moscow" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update -y \
  && apt-get install -y \
     libxml2-dev \
  && apt-get clean -y \
  && docker-php-ext-install soap

RUN apt-get update && apt-get install -y telnet

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
