import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/app_initializer.dart';
import 'providers/walkie_talkie_provider.dart';
import 'screens/channel_entry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.initialize();
  runApp(const WalkieTalkieApp());
}

class WalkieTalkieApp extends StatelessWidget {
  const WalkieTalkieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WalkieTalkieProvider(),
      child: MaterialApp(
        title: 'Walkie Talkie',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const ChannelEntryScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

