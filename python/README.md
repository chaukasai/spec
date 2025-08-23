# Chaukas Python Client

Python client library for Chaukas agent audit and explainability platform.

## Installation

```bash
pip install chaukas-spec
```

## Usage

### Client Integration

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

### Server Implementation

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

## Development

This package contains generated protobuf code. See the main repository for development instructions.