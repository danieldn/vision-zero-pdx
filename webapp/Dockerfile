FROM python:3.6
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt

EXPOSE 8000

ENTRYPOINT ["python"]

CMD ["app.py"]
