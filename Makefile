# Copyright 2025 Chaukas AI
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0

.PHONY: gen-python gen-go gen-all clean-python clean-go clean-all lint install-python

# Generate all code (Python + Go)
gen-all: clean-all
	buf generate
	@echo "✅ All code generated successfully"

# Generate Python code only
gen-python: clean-python  
	buf generate
	@echo "✅ Python code generated in python/chaukas/spec/"

# Generate Go code only
gen-go: clean-go
	buf generate
	@echo "✅ Go code generated in go/chaukas/spec/"

# Clean generated Python files
clean-python:
	find python/chaukas/spec -name "*_pb2.py" -delete 2>/dev/null || true
	find python/chaukas/spec -name "*_pb2.pyi" -delete 2>/dev/null || true
	find python/chaukas/spec -name "*_grpc.py" -delete 2>/dev/null || true

# Clean generated Go files  
clean-go:
	rm -rf go/chaukas

# Clean all generated files
clean-all: clean-python clean-go

# Install Python package in development mode
install-python:
	cd python && pip install -e .

# Lint proto files
lint:
	buf lint

# Format proto files
format:
	buf format --write

# Check for breaking changes
breaking:
	buf breaking --against '.git#branch=main'