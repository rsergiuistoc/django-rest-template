FROM python:3.10-slim-bullseye

# Set environment variables
ENV APP_WORKSPACE=/opt/django-rest-template/

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir -p $APP_WORKSPACE

# Install OS dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends build-essential \
    gcc \
    libgnutls28-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libpq-dev \
    && apt-get clean

COPY Pipfile Pipfile.lock ./

# Install Python dependencies
RUN python -m pip install --upgrade pip
RUN pip install pipenv  \
    && pipenv install --system --deploy --ignore-pipfile \
    && useradd -U django-rest-template \
    && install -d -m 0755 -o django-rest-template -g django-rest-template ${APP_WORKSPACE}

WORKDIR $APP_WORKSPACE

# Create app user to restritc permission on workspace
USER django-rest-template:django-rest-template

COPY --chown=django-rest-template:django-rest-template . .

RUN chmod a+x  ./scripts/entrypoint.sh

CMD ["./scripts/entrypoint.sh"]
