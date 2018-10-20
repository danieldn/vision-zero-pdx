FROM python:3.6
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
# CMD ["uwsgi", "--ini", "uwsgi.ini"]
CMD ["python", "main.py"]
