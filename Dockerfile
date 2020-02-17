FROM python:3.7.6-buster
COPY /app /app
COPY /data /data
COPY requirements.txt /requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "/app/main.py"]
