FROM python:3.7.6-buster
COPY /app /app
COPY /data /data
COPY requirements.txt /requirements.txt
RUN pip install -r requirements.txt
RUN pip install gunicorn
EXPOSE 5000

# dev flask server
# ----------------
# CMD ["python", "/app/main.py"]

# or 

# production like deployment using Gunicorn
# -----------------------------------------
WORKDIR /app
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "main:app"]
# use 0.0.0.0 to accept requests from external ip (windows curl will not work otherwise)

