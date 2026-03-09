FROM python:3.13-slim AS builder

WORKDIR /app
COPY requirements.txt .

RUN pip install --no-cache-dir \
    --target=/python-deps \
    -r requirements.txt

FROM gcr.io/distroless/python3-debian13:nonroot-1d8908e5c48cc27b0e52f67fe8163c6572137506 AS runner

COPY --from=builder --chown=nonroot:nonroot /python-deps /python-deps

WORKDIR /app
COPY app.py app.py
COPY templates templates/
COPY static static/

ENV PYTHONPATH=/python-deps

EXPOSE 5000

CMD [ "-m", "flask", "run", "--host=0.0.0.0" ]