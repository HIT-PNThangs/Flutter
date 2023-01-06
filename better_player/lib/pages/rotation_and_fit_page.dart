import 'package:flutter/material.dart';

import '../better_player/configuration/better_player_configuration.dart';
import '../better_player/configuration/better_player_data_source.dart';
import '../better_player/configuration/better_player_data_source_type.dart';
import '../better_player/core/better_player.dart';
import '../better_player/core/better_player_controller.dart';
import '../constants.dart';

class RotationAndFitPage extends StatefulWidget {
  const RotationAndFitPage({super.key});

  @override
  _RotationAndFitPageState createState() => _RotationAndFitPageState();
}

class _RotationAndFitPageState extends State<RotationAndFitPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 1.0,
      fit: BoxFit.fill,
      rotation: 90,
    );
    BetterPlayerDataSource dataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, Constants.forBiggerBlazesUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rotation and fit"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Player with different rotation and fit.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          AspectRatio(
            aspectRatio: 1.0,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
        ],
      ),
    );
  }
}
