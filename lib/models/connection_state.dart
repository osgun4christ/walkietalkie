/// Represents the connection state of a WebRTC peer connection
class ConnectionState {
  final String state;
  final bool isConnected;

  const ConnectionState({
    required this.state,
    required this.isConnected,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectionState &&
          runtimeType == other.runtimeType &&
          state == other.state &&
          isConnected == other.isConnected;

  @override
  int get hashCode => state.hashCode ^ isConnected.hashCode;

  @override
  String toString() => 'ConnectionState(state: $state, isConnected: $isConnected)';
}


