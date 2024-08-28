import 'dart:math';
import 'package:animation_demo/toast_list_tile.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AnimatedContainerApp());

class AnimatedContainerApp extends StatefulWidget {
  const AnimatedContainerApp({super.key});

  @override
  State<AnimatedContainerApp> createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedContainer Demo'),
        ),
        body: Center(
          child: ValueListenableBuilder(
            valueListenable: ToastMsg.widthNotifier,
            builder: (context, width, child) => ValueListenableBuilder(
              valueListenable: ToastMsg.heightNotifier,
              builder: (context, height, child) => AnimatedContainer(
                width: ToastMsg.widthNotifier.value,
                height: ToastMsg.heightNotifier.value,
                decoration: BoxDecoration(
                  color: ToastMsg.color,
                  borderRadius: ToastMsg.borderRadius,
                ),
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: ValueListenableBuilder(
                  valueListenable: ToastMsg.textStyleNotifier,
                  builder: (context, textStyle, child) => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Response Data of API"),
                        Text("Header Data of API"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Update the ValueNotifier values
            ToastMsg.widthNotifier.value = 300;
            ToastMsg.heightNotifier.value = 80;
            ToastMsg.textStyleNotifier.value =
            const TextStyle(fontSize: 24, color: Colors.black);
            ToastMsg.borderRadius = BorderRadius.circular(20);

            // Show the animated toast message
            ToastMsg.showSuccess(message: 'Animation Success');
          },
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}

class ToastMsg {
  static final ValueNotifier<double> widthNotifier = ValueNotifier(50);
  static final ValueNotifier<double> heightNotifier = ValueNotifier(50);
  static final ValueNotifier<TextStyle> textStyleNotifier =
  ValueNotifier(const TextStyle(fontSize: 8, color: Colors.white));
  static Color color = Colors.green;
  static BorderRadiusGeometry borderRadius = BorderRadius.circular(8);

  static void showSuccess({required String message, int duration = 3}) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: duration),
      toastBuilder: (CancelFunc? cancelFunc) => ValueListenableBuilder(
        valueListenable: widthNotifier,
        builder: (context, width, child) => ValueListenableBuilder(
          valueListenable: heightNotifier,
          builder: (context, height, child) => AnimatedContainer(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius,
            ),
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: ValueListenableBuilder(
              valueListenable: textStyleNotifier,
              builder: (context, textStyle, child) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Response Data of API", style: textStyle),
                    Text("Header Data of API", style: textStyle),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
