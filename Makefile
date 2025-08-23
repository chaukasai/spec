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

# Reorganize Python files to nested chaukas.spec structure
organize-python:
	# Create nested directory structure  
	mkdir -p python/chaukas/spec/client/v1 python/chaukas/spec/common/v1 python/chaukas/spec/server/v1
	
	# Move generated files from flat structure to nested structure
	find python/client/v1 -name "*_pb2.*" -exec cp {} python/chaukas/spec/client/v1/ \; 2>/dev/null || true
	find python/client/v1 -name "*_grpc.*" -exec cp {} python/chaukas/spec/client/v1/ \; 2>/dev/null || true
	find python/common/v1 -name "*_pb2.*" -exec cp {} python/chaukas/spec/common/v1/ \; 2>/dev/null || true
	find python/common/v1 -name "*_grpc.*" -exec cp {} python/chaukas/spec/common/v1/ \; 2>/dev/null || true
	find python/server/v1 -name "*_pb2.*" -exec cp {} python/chaukas/spec/server/v1/ \; 2>/dev/null || true
	find python/server/v1 -name "*_grpc.*" -exec cp {} python/chaukas/spec/server/v1/ \; 2>/dev/null || true
	
	# Fix import paths for relative imports within nested structure
	find python/chaukas/spec/client/v1 -name "*.py" -exec sed -i '' 's/from common\.v1 import/from ...common.v1 import/g' {} \; 2>/dev/null || true
	find python/chaukas/spec/client/v1 -name "*.py" -exec sed -i '' 's/from client\.v1 import/from . import/g' {} \; 2>/dev/null || true
	find python/chaukas/spec/server/v1 -name "*.py" -exec sed -i '' 's/from common\.v1 import/from ...common.v1 import/g' {} \; 2>/dev/null || true
	find python/chaukas/spec/server/v1 -name "*.py" -exec sed -i '' 's/from server\.v1 import/from . import/g' {} \; 2>/dev/null || true
	find python/chaukas/spec/common/v1 -name "*.py" -exec sed -i '' 's/from common\.v1 import/from . import/g' {} \; 2>/dev/null || true
	
	# Create __init__.py files for nested structure
	touch python/__init__.py
	touch python/chaukas/__init__.py python/chaukas/spec/__init__.py
	touch python/chaukas/spec/client/__init__.py python/chaukas/spec/client/v1/__init__.py
	touch python/chaukas/spec/common/__init__.py python/chaukas/spec/common/v1/__init__.py
	touch python/chaukas/spec/server/__init__.py python/chaukas/spec/server/v1/__init__.py
	
	# Remove flat structure after copying
	rm -rf python/client python/common python/server

# Clean generated Python files
clean-python:
	find python/chaukas/spec -name "*_pb2.py" -delete 2>/dev/null || true
	find python/chaukas/spec -name "*_pb2.pyi" -delete 2>/dev/null || true
	find python/chaukas/spec -name "*_grpc.py" -delete 2>/dev/null || true

# Clean generated Go files  
clean-go:
	rm -rf go/client go/common go/server

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