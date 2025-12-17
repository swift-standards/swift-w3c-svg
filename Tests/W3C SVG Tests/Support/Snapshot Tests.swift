// Snapshot Tests.swift

import InlineSnapshotTesting
import Testing

@MainActor
@Suite(
    .serialized,
    .snapshots(record: .missing)
)
struct `Snapshot Tests` {}
