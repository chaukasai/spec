# Chaukas Specification

Protocol Buffer specifications and generated client libraries for the Chaukas agent audit and explainability platform.

## Overview

Chaukas is an open-core agent audit and explainability SDK and platform. This repository contains:

- **Protocol Buffer definitions** for event schema and gRPC services
- **Generated Python client libraries** for SDK integration
- **Generated Go server libraries** for platform implementation

## Structure

```
proto/chaukas/spec/
├── common/v1/       # Shared data models (Event, QueryRequest, etc.)
├── client/v1/       # Client-side gRPC service definitions  
└── server/v1/       # Server-side gRPC service definitions

python-client/           # Client SDK package (chaukas-spec-client)
python-server/           # Server implementation package (chaukas-spec-server)

go/chaukas/spec/         # Generated Go packages and module
├── common/v1/       # Data models
├── client/v1/       # Client gRPC stubs
└── server/v1/       # Server gRPC stubs + server-specific models

.generated/python/       # Temporary generated Python code (build artifact)
```

## Installation

### For Client-side SDK Development
```bash
pip install chaukas-spec-client
```

### For Server-side Platform Implementation
```bash
pip install chaukas-spec-server
```

### For Go Development
```bash
go get github.com/chaukasai/spec
```

## Python Usage

### SDK Integration (Client-side)
```python
from chaukas.spec.client.v1.client_pb2_grpc import ChaukasClientServiceStub
from chaukas.spec.client.v1.client_pb2 import IngestEventRequest
from chaukas.spec.common.v1.events_pb2 import Event, EventType

# Create gRPC client
stub = ChaukasClientServiceStub(channel)

# Create and send event
event = Event(
    event_id="evt_123",
    type=EventType.EVENT_TYPE_AGENT_START,
    session_id="session_abc"
)
request = IngestEventRequest(event=event)
stub.IngestEvent(request)
```

### Platform Implementation (Server-side)
```python
from chaukas.spec.server.v1.server_pb2_grpc import ChaukasServerServiceServicer
from chaukas.spec.server.v1.server_pb2 import IngestEventResponse

class MyChaukasServer(ChaukasServerServiceServicer):
    def IngestEvent(self, request, context):
        # request is IngestEventRequest with .event field
        return IngestEventResponse(
            event_id=request.event.event_id,
            status="accepted"
        )
```

## Go Usage (Server-side)

```go
import (
    serverv1 "github.com/chaukasai/spec/chaukas/spec/server/v1"
)

type MyChaukasServer struct {
    serverv1.UnimplementedChaukasServerServiceServer
}

func (s *MyChaukasServer) IngestEvent(ctx context.Context, req *serverv1.IngestEventRequest) (*serverv1.IngestEventResponse, error) {
    return &serverv1.IngestEventResponse{
        EventId: req.Event.EventId,
        Status: "accepted",
    }, nil
}
```

## Development

### Generate Code
```bash
make gen-all        # Generate both Python and Go code
make gen-python     # Generate Python code only (for packages)
make gen-go         # Generate Go code only
```

### Build Packages
```bash
make build-packages # Build both client and server Python packages
make build-client   # Build client package only
make build-server   # Build server package only
```

### Test Packages
```bash
make test-packages  # Test both packages can be installed and imported
```

### Clean Generated Code
```bash
make clean-all      # Clean all generated code
make clean-packages # Clean built packages
```

### Lint and Format
```bash
make lint           # Lint proto files with buf
make format         # Format proto files with buf
make breaking       # Check for breaking changes against main
```

## CI/CD Pipeline

[![CI](https://github.com/chaukasai/spec/workflows/CI/badge.svg)](https://github.com/chaukasai/spec/actions)

The repository includes a comprehensive CI/CD pipeline that:

1. **🔍 Lints & Validates**: Runs `buf lint` and format checking
2. **🚨 Breaking Changes**: Detects API breaking changes on PRs
3. **🔨 Build & Test**: Generates code and tests compilation across multiple Python/Go versions
4. **📦 Package Building**: Creates separate client and server Python packages
5. **🚀 Automated Releases**: Publishes to PyPI and Go modules on version tags

### Manual Release Process
1. Update version in package files
2. Create a git tag: `git tag v1.0.0`
3. Push the tag: `git push origin v1.0.0`
4. GitHub Actions will automatically build and publish packages

## Architecture

The specification supports comprehensive agent observability through:

- **Event Types**: SESSION_START, AGENT_START, MODEL_INVOCATION_START, TOOL_CALL_START, etc.
- **Span-based Tracking**: Distributed tracing with parent-child relationships
- **Rich Metadata**: Performance metrics, cost tracking, infrastructure data
- **Audit Features**: WORM compliance, content hashing, integrity proofs
- **Privacy**: PII categorization, redaction capabilities
- **Multi-tenancy**: Tenant and project scoping

This is part of the open-core Chaukas agent audit and explainability platform.