FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ app/
COPY data/ data/
RUN useradd --create-home --uid 1000 kraken \
 && mkdir /app/output && chown kraken /app/output
USER kraken
ENV SOURCE_URL=data/stations.csv OUTPUT_DIR=/app/output
CMD ["python", "-m", "app.main"]
