# Copyright 2025 Chaukas AI
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0

"""Chaukas common data models v1."""

from .events_pb2 import (
    Event,
    EventBatch,
    EventType,
    EventStatus,
    Severity,
    Author,
    MessageContent,
    ToolCall,
    ToolResponse,
    LLMInvocation,
    PolicyDecision,
    DataAccess,
    ErrorInfo,
    RedactionInfo,
    RetryInfo,
    PerformanceMetrics,
    InfrastructureMetrics,
    CostDetails,
)

from .query_pb2 import (
    QueryRequest,
    QueryResponse,
    QueryFilter,
    TimeRange,
    SortOrder,
    Capabilities,
)

__all__ = [
    # Core event types
    "Event",
    "EventBatch",
    
    # Enums
    "EventType",
    "EventStatus", 
    "Severity",
    "Author",
    "SortOrder",
    
    # Content types
    "MessageContent",
    "ToolCall",
    "ToolResponse", 
    "LLMInvocation",
    "PolicyDecision",
    "DataAccess",
    "ErrorInfo",
    
    # Metadata and metrics
    "RedactionInfo",
    "RetryInfo",
    "PerformanceMetrics",
    "InfrastructureMetrics", 
    "CostDetails",
    
    # Query types
    "QueryRequest",
    "QueryResponse",
    "QueryFilter",
    "TimeRange",
    "Capabilities",
]