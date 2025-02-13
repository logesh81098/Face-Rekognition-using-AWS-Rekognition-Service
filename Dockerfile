FROM python:3.12.3-alpine3.18

WORKDIR /app

COPY requirements.txt /app/requirements.txt

COPY templates /app/templates

COPY app.py /app/app.py

EXPOSE 81

RUN pip install --no-cache-dir -r requirements.txt

ENV FLASK_ENV=development

CMD [ "python", "app.py" ]