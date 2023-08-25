FROM python:3.9.17

COPY . .

RUN pip3 install -r requirements.txt

EXPOSE 8080

CMD ["python3", "routes.py"]

