# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thiguchi <thiguchi@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/18 22:15:20 by thiguchi          #+#    #+#              #
#    Updated: 2021/03/22 14:04:19 by thiguchi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# get image
FROM debian:buster

# keep move
#CMD tail -f /dev/null

RUN set -ex;\
	apt-get update;\
	apt-get upgrade;\
	apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap \
	wget \
	nginx mariadb-server \
	procps nano 
	
RUN rm -rf /var/lib/apt/lists/*

COPY ./srcs/bash.sh ./
COPY ./srcs/nginx-conf ./tmp
COPY ./srcs/phpmyadmin.inc.php ./tmp
COPY ./srcs/wp-config.php ./tmp

CMD bash bash.sh