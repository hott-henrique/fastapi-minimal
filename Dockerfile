FROM python:3.9-slim as compiler

ENV PYTHONUNBUFFERED 1

WORKDIR /app/

# CREATE PYTHON VIRTUAL ENVIRONMENT
RUN python -m venv /opt/venv

# ACTIVATE PYTHON VIRTUAL ENVIRONMENT BY GIVING PRIORITY IN THE PATH SEARCH.
ENV PATH="/opt/venv/bin:$PATH"

COPY ./requirements.txt /app/requirements.txt
RUN pip install -Ur requirements.txt

FROM python:3.9-slim as runner

WORKDIR /app/

COPY --from=compiler /opt/venv /opt/venv

# ACTIVATE PYTHON VIRTUAL ENVIRONMENT BY GIVING PRIORITY IN THE PATH SEARCH.
ENV PATH="/opt/venv/bin:$PATH"

COPY . /app/

CMD ["fastapi", "dev", "--host", "0.0.0.0", "--port", "8080", "main.py" ]

# EXPOSE 8080
