FROM nginx:latest

RUN apt update

RUN apt upgrade -y

#ADD ./KodeSPACE.tar.gz /app/

COPY index.html /usr/share/nginx/html

COPY contact.html /usr/share/nginx/html

COPY about.html /usr/share/nginx/html

ADD /css /usr/share/nginx/html/css/

COPY /img /usr/share/nginx/html/img/

EXPOSE 80