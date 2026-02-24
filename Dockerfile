FROM cgr.dev/chainguard/python:latest-dev AS builder

WORKDIR /app

RUN python -m venv venv
ENV PATH="/app/venv/bin:$PATH"
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

FROM cgr.dev/chainguard/python:latest

WORKDIR /app

COPY app.py app.py
COPY templates templates/
COPY static static/
COPY --from=builder /app/venv /app/venv


ENV PATH="/app/venv/bin:$PATH"

EXPOSE 5000

ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]