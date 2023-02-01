.PHONY: help generate-secret clean-migrations clean-pyc

help:
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

generate-secret: # Generates Django Secret Key
	python -c "import secrets; print(secrets.token_urlsafe())"

test-coverage: # Execute tests and generate coverage report
	coverage run --source='.' manage.py test
	coverage html

clean-migrations: # Clean existing migrations from all applications
	find . -path "*/migrations/*.py" -not -name "__init__.py" -not -name "*_load_initial_*.py" -delete
	find . -path "*/migrations/*.pyc"  -delete

clean-pyc: # Clean Python compiled bytecode files"
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

openapi-generate-swagger: # Generate OpenAPI swagger schema
	python manage.py spectacular --file ./api/swagger.yaml
