FROM ubuntu

RUN apt update

RUN apt install git -y

RUN apt install nginx -y

RUN apt install systemctl -y

RUN systemctl start nginx

RUN systemctl enable nginx

WORKDIR /var/www/html

RUN rm -rf index*

RUN git clone https://github.com/cceliuss187/Final-Project.git

RUN cp -r /var/www/html/Final-Project/* /var/www/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
