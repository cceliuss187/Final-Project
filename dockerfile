FROM nginx:1.15.8-alpine
RUN apt update

RUN apt install git

RUN git clone https://github.com/cceliuss187/Final-Project.git

WORKDIR /Final-Project

COPY nginx.conf /etc/nginx/nginx.conf
CMD ./*.css /usr/share/nginx/html/
COPY ./*.png /usr/share/nginx/html/
COPY ./*.js /usr/share/nginx/html/

EXPOSE 80
