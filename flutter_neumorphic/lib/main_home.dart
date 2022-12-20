import 'package:flutter/material.dart';

import 'app/accessibility/neumorphic_accessibility.dart';
import 'app/playground/neumorphic_playground.dart';
import 'app/playground/text_playground.dart';
import 'app/samples/sample_home.dart';
import 'app/src/neumorphic_box_shape.dart';
import 'app/src/theme/neumorphic_theme.dart';
import 'app/src/widget/app.dart';
import 'app/src/widget/button.dart';
import 'app/tips/tips_home.dart';
import 'app/widgets/widgets_home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Neumorphic',
      home: FullSampleHomePage(),
    );
  }
}

class FullSampleHomePage extends StatelessWidget {
  const FullSampleHomePage({super.key});

  Widget _buildButton({required String text, required VoidCallback onClick}) {
    return NeumorphicButton(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        shape: NeumorphicShape.flat,
      ),
      onPressed: onClick,
      child: Center(child: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: const NeumorphicThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildButton(
                    text: "Neumorphic Playground",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return const NeumorphicPlayground();
                      }));
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildButton(
                    text: "Text Playground",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return NeumorphicTextPlayground();
                      }));
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildButton(
                      text: "Samples",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return SamplesHome();
                        }));
                      }),
                  const SizedBox(height: 24),
                  _buildButton(
                      text: "Widgets",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const WidgetsHome();
                        }));
                      }),
                  const SizedBox(height: 24),
                  _buildButton(
                      text: "Tips",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const TipsHome();
                        }));
                      }),
                  const SizedBox(height: 24),
                  _buildButton(
                      text: "Accessibility",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const NeumorphicAccessibility();
                        }));
                      }),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
