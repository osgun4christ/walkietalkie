import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/walkie_talkie_provider.dart';
import '../constants/app_constants.dart';

class TalkScreen extends StatefulWidget {
  const TalkScreen({super.key});

  @override
  State<TalkScreen> createState() => _TalkScreenState();
}

class _TalkScreenState extends State<TalkScreen> {
  double _amplitude = 0.0;
  StreamSubscription<double>? _amplitudeSubscription;
  Timer? _connectionCheckTimer;

  @override
  void initState() {
    super.initState();
    _setupListeners();
    _startConnectionCheck();
  }

  void _setupListeners() {
    final provider = Provider.of<WalkieTalkieProvider>(context, listen: false);
    
    _amplitudeSubscription = provider.audioService.amplitudeStream.listen((amplitude) {
      if (mounted) {
        setState(() {
          _amplitude = amplitude;
        });
      }
    });
  }

  void _startConnectionCheck() {
    _connectionCheckTimer = Timer.periodic(
      AppConstants.connectionCheckInterval,
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        
        final provider = Provider.of<WalkieTalkieProvider>(context, listen: false);
        if (!provider.isConnected && 
            provider.channelId != null && 
            provider.username != null) {
          // Try to reconnect
          provider.joinChannel(provider.channelId!, provider.username!);
        }
      },
    );
  }

  @override
  void dispose() {
    _amplitudeSubscription?.cancel();
    _connectionCheckTimer?.cancel();
    super.dispose();
  }

  Future<void> _onPressStart() async {
    final provider = Provider.of<WalkieTalkieProvider>(context, listen: false);
    
    if (!provider.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not connected. Waiting for other users...'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    HapticFeedback.mediumImpact();
    await provider.startRecording();
    await provider.audioService.startRecording();
  }

  Future<void> _onPressEnd() async {
    final provider = Provider.of<WalkieTalkieProvider>(context, listen: false);
    
    HapticFeedback.mediumImpact();
    await provider.stopRecording();
    await provider.audioService.stopRecording();
  }

  Future<void> _disconnect() async {
    final provider = Provider.of<WalkieTalkieProvider>(context, listen: false);
    await provider.disconnect();
    
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalkieTalkieProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Channel: ${provider.channelId ?? "Unknown"}'),
                Text(
                  provider.username ?? '',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: _disconnect,
                tooltip: 'Leave Channel',
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Connection Status
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: provider.isConnected
                          ? Colors.green.withOpacity(0.2)
                          : Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: provider.isConnected ? Colors.green : Colors.orange,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          provider.isConnected
                              ? Icons.check_circle
                              : Icons.sync,
                          color: provider.isConnected ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          provider.isConnected
                              ? 'Connected'
                              : 'Connecting...',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // User List (if available)
                  if (provider.users.isNotEmpty) ...[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Users in channel:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: provider.users
                                .map((user) => Chip(
                                      label: Text(user),
                                      avatar: const Icon(Icons.person, size: 18),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  const Spacer(),

                  // Push-to-Talk Button
                  GestureDetector(
                    onTapDown: (_) => _onPressStart(),
                    onTapUp: (_) => _onPressEnd(),
                    onTapCancel: () => _onPressEnd(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: 200 + (_amplitude * 2).clamp(0.0, 50.0),
                      height: 200 + (_amplitude * 2).clamp(0.0, 50.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: provider.isRecording
                            ? Colors.red
                            : Theme.of(context).colorScheme.primary,
                        boxShadow: [
                          BoxShadow(
                            color: (provider.isRecording
                                    ? Colors.red
                                    : Theme.of(context).colorScheme.primary)
                                .withOpacity(0.5),
                            blurRadius: provider.isRecording ? 30 : 20,
                            spreadRadius: provider.isRecording ? 10 : 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        provider.isRecording ? Icons.mic : Icons.mic_none,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Status Text
                  Text(
                    provider.isRecording ? 'Recording...' : 'Hold to Talk',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    provider.isRecording ? 'Release to send' : 'Press and hold the button',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),

                  const Spacer(),

                  // Info
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Audio is streamed in real-time using WebRTC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


