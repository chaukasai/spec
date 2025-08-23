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

python/chaukas/spec/     # Generated Python packages
├── common/v1/       # Data models only
├── client/v1/       # Client gRPC stubs + models
└── server/v1/       # Server gRPC stubs + server-specific models

go/                      # Generated Go packages  
├── common/v1/       # Data models
├── client/v1/       # Client gRPC stubs (reference)
└── server/v1/       # Server gRPC stubs + server-specific models
```

## Python Usage

### Installation
```bash
pip install chaukas-spec
```

### SDK Integration (Client-side)
```python
from chaukas.spec.client.v1.client_pb2_grpc import ChaukasClientStub
from chaukas.spec.common.v1.events_pb2 import Event, EventType

# Create gRPC client
stub = ChaukasClientStub(channel)

# Create and send event
event = Event(
    event_id="evt_123",
    type=EventType.AGENT_START,
    session_id="session_abc"
)
stub.IngestEvent(event)
```

### Platform Implementation (Server-side)
```python
from chaukas.spec.server.v1.server_pb2_grpc import ChaukasServerServicer
from chaukas.spec.server.v1.server_pb2 import IngestEventResponse
from chaukas.spec.common.v1.events_pb2 import Event

class MyChaukasServer(ChaukasServerServicer):
    def IngestEvent(self, request, context):
        return IngestEventResponse(
            event_id=request.event_id,
            status="accepted"
        )
```

## Go Usage (Server-side)

```go
import (
    "github.com/chaukasai/spec/common/v1"
    "github.com/chaukasai/spec/server/v1"
)

type MyChaukasServer struct {
    server.UnimplementedChaukasServerServer
}

func (s *MyChaukasServer) IngestEvent(ctx context.Context, req *common.Event) (*server.IngestEventResponse, error) {
    return &server.IngestEventResponse{
        EventId: req.EventId,
        Status: "accepted",
    }, nil
}
```

## Development

### Generate All Code
```bash
make gen-all        # Generate both Python and Go code
```

### Generate Language-Specific Code
```bash
make gen-python     # Python client + server stubs
make gen-go         # Go server stubs only
```

### Clean Generated Code
```bash
make clean-all      # Clean all generated code
make clean-python   # Clean Python generated code
make clean-go       # Clean Go generated code
```

### Install Python Package
```bash
make install-python # Install Python package in development mode
```

## Architecture

The specification supports comprehensive agent observability through:

- **Event Types**: SESSION_START, AGENT_START, MODEL_INVOCATION_START, TOOL_CALL_START, etc.
- **Span-based Tracking**: Distributed tracing with parent-child relationships
- **Rich Metadata**: Performance metrics, cost tracking, infrastructure data
- **Audit Features**: WORM compliance, content hashing, integrity proofs
- **Privacy**: PII categorization, redaction capabilities
- **Multi-tenancy**: Tenant and project scoping

This is part of the open-core Chaukas agent audit and explainability platform.