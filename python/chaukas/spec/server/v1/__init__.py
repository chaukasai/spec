# Copyright 2025 Chaukas AI
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0

"""Chaukas server-side models and gRPC stubs v1."""

# Import common models
from ...common.v1 import *

# Import server-specific gRPC stubs and additional models
from .server_pb2 import (
    IngestEventResponse,
    IngestBatchResponse, 
    EventStatsRequest,
    EventStatsResponse,
)

from .server_pb2_grpc import (
    ChaukasServerStub,
    ChaukasServerServicer,
    add_ChaukasServerServicer_to_server,
)

__all__ = [
    # Server-specific models
    "IngestEventResponse",
    "IngestBatchResponse",
    "EventStatsRequest", 
    "EventStatsResponse",
    
    # Server gRPC classes
    "ChaukasServerStub",
    "ChaukasServerServicer",
    "add_ChaukasServerServicer_to_server",
]