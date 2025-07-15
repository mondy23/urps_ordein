import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/models/urps_websocket_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final webSocketUrl = 'wss://127.0.0.1:15001/ws?token=my-very-secret-key';

final systemSummaryProvider =
    StateNotifierProvider<SystemSummaryNotifier, SystemSummaryModels?>(
        (ref) {
  return SystemSummaryNotifier();
});

class SystemSummaryNotifier extends StateNotifier<SystemSummaryModels?> {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 10;

  SystemSummaryNotifier() : super(null) {
    _connect();
  }

  void _connect() {
    _channel = WebSocketChannel.connect(Uri.parse(webSocketUrl));

    _subscription = _channel!.stream.listen(
      (message) {
        _reconnectAttempts = 0; // Reset on successful message
        final data = json.decode(message);
        final urpsJson = data['data'];
        state = SystemSummaryModels.fromJson(urpsJson);
      },
      onError: (error) {
        print('WebSocket Error: $error');
        _attemptReconnect();
      },
      onDone: () {
        print('WebSocket Closed');
        _attemptReconnect();
      },
      cancelOnError: true,
    );
  }

  void _attemptReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      print('Max reconnect attempts reached, giving up.');
      return;
    }

    _reconnectAttempts++;
    final delay = Duration(seconds: 2 << (_reconnectAttempts - 1));
    print('Reconnecting in ${delay.inSeconds} seconds... Attempt $_reconnectAttempts');

    Future.delayed(delay, () {
      _subscription?.cancel();
      _channel?.sink.close();
      _connect();
    });
  }

  void sendMessage(String msg) {
    if (_channel != null) {
      _channel!.sink.add(msg);
    } else {
      print('Cannot send message: WebSocket is not connected');
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _channel?.sink.close();
    super.dispose();
  }
}
