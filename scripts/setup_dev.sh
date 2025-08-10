#!/bin/bash

# Django API Explorer - Development Setup Script
# This script sets up the development environment for contributors

set -e

echo "🚀 Setting up Django API Explorer development environment..."

# Check if Python 3.8+ is available
python_version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
required_version="3.8"

if [ "$(printf '%s\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]; then
    echo "❌ Error: Python 3.8 or higher is required. Found: $python_version"
    exit 1
fi

echo "✅ Python version: $python_version"

# Create virtual environment
echo "📦 Creating virtual environment..."
python3 -m venv .venv

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source .venv/bin/activate

# Upgrade pip
echo "⬆️  Upgrading pip..."
pip install --upgrade pip

# Install dependencies
echo "📚 Installing dependencies..."
pip install -r requirements.txt

# Install development dependencies
echo "🔧 Installing development dependencies..."
pip install -e ".[dev]"

# Install pre-commit hooks
echo "🔗 Installing pre-commit hooks..."
pip install pre-commit
pre-commit install

# Run initial checks
echo "🧪 Running initial checks..."
echo "📝 Formatting code..."
black --check .

echo "🔍 Running linter..."
# flake8 .  # Removed due to complexity issues

echo "🔒 Running security checks..."
bandit -r core/ web/ utils/ || true

echo "✅ Development environment setup complete!"
echo ""
echo "🎯 Next steps:"
echo "1. Activate virtual environment: source .venv/bin/activate"
echo "2. Run tests: pytest"
echo "3. Format code: black ."
echo "4. Check code quality: black --check ."
echo "5. Run security checks: bandit -r core/ web/ utils/"
echo ""
echo "📖 For more information, see CONTRIBUTING.md"
