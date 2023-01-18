import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const targetMinutes = 5;
  int totalSeconds = targetMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    setState(() {});
    if (totalSeconds == 0) {
      totalPomodoros++;
      isRunning = false;
      totalSeconds = targetMinutes;
      timer.cancel();
    } else {
      totalSeconds--;
    }
  }

  void onStartPressed() {
    setState(() {});
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    isRunning = true;
  }

  void onPausePressed() {
    setState(() {});
    timer.cancel();
    isRunning = false;
  }

  void onStopPressed() {
    setState(() {});
    timer.cancel();
    isRunning = false;
    totalSeconds = targetMinutes;
  }

  void onResetPressed() {
    setState(() {});
    totalPomodoros = 0;
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 80,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline),
                  ),
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: onStopPressed,
                    icon: const Icon(Icons.stop_circle_outlined),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: IconButton(
                                iconSize: 35,
                                onPressed: onResetPressed,
                                icon: const Icon(Icons.restart_alt_outlined),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
