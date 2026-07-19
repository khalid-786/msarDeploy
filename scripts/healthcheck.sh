#!/bin/bash

set -e

echo "Checking API..."

curl -f http://localhost:5080/health

echo ""

echo "API Healthy."

echo ""

echo "Checking Frontend..."

curl -f http://localhost

echo ""

echo "Frontend Healthy."

echo ""

echo "Everything is Healthy."