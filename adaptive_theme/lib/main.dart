import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cupertino_example.dart';
import 'material_example.dart';
import 'src/adaptive_theme.dart';
import 'src/adaptive_theme_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isMaterial = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: isMaterial
          ? MaterialExample(
              savedThemeMode: widget.savedThemeMode,
              onChanged: () => setState(() => isMaterial = false))
          : CupertinoExample(
              savedThemeMode: widget.savedThemeMode,
              onChanged: () => setState(() => isMaterial = true)),
    );
  }
}
