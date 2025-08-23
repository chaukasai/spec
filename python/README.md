# Chaukas Python Client

Python client library for Chaukas agent audit and explainability platform.

## Installation

```bash
pip install chaukas-spec
```

## Usage

### Client Integration

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

### Server Implementation

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

## Development

This package contains generated protobuf code. See the main repository for development instructions.