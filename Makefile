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
	$(MAKE) organize-python

# Generate Python code only
gen-python: clean-python  
	buf generate
	$(MAKE) organize-python

# Generate Go code only
gen-go: clean-go
	buf generate
	@echo "✓ Go server code generated in go/"

# Fix Python import paths for proper relative imports
organize-python:
	# Fix import paths for relative imports within each package
	find python/chaukas/spec/client/v1 -name "*_pb2.py" -exec sed -i '' 's/from chaukas\.spec\.common\.v1 import/from ...common.v1 import/g' {} \; 2>/dev/null || true
	find python/chaukas/spec/client/v1 -name "*_grpc.py" -exec sed -i '' 's/from chaukas\.spec\.common\.v1 import/from ...common.v1 import/g' {} \; 2>/dev/null || true
	find python/chaukas/spec/server/v1 -name "*_pb2.py" -exec sed -i '' 's/from chaukas\.spec\.common\.v1 import/from ...common.v1 import/g' {} \; 2>/dev/null || true
	find python/chaukas/spec/server/v1 -name "*_grpc.py" -exec sed -i '' 's/from chaukas\.spec\.common\.v1 import/from ...common.v1 import/g' {} \; 2>/dev/null || true

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