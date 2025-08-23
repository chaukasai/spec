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

go/chaukas/spec/         # Generated Go packages  
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