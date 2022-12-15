FROM python

RUN apt update

RUN apt install git

RUN git clone https://github.com/cceliuss187/Final-Project.git

WORKDIR /Final-Project

RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT FLASK_APP=app flask run --host=0.0.0.0
