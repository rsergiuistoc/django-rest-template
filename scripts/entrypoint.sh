#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# Collect static files from applications
python manage.py collectstatic --no-input

# Automatic creation of admin user
python manage.py createsuperuser --no-input

# Start wsgi
uwsgi --http 0.0.0.0:8080 --module config.wsgi
