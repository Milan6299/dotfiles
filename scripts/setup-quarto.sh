#!/usr/bin/env bash
set -e

echo "-> Python in use:"
which python
python --version
python -m pip --version

if [[ -z "$VIRTUAL_ENV" ]]; then
  echo "❌ No virtual environment detected"
  echo "Activate a venv before running this script"
  exit 1
fi

echo "-> Setting up Quarto + Jupyter Python environment"

# Optional but recommended
python -m pip install --upgrade pip wheel setuptools

echo "-> Installing core Jupyter + Quarto dependencies"

python -m pip install \
  ipykernel \
  nbformat \
  nbclient \
  jupyter_client \
  jupyter_core \
  ipython \
  PyYAML

echo "Registering Jupyter kernel: quarto-py"

python -m ipykernel install \
  --user \
  --name quarto-py \
  --display-name "Python (quarto-py)"

echo "-> Done!"
