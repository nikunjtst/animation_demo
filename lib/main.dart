import 'package:animation_demo/tween_example.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AnimatedContainerApp());

class AnimatedContainerApp extends StatefulWidget {
  const AnimatedContainerApp({super.key});

  @override
  State<AnimatedContainerApp> createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> widthAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    widthAnimation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TweenExample(),
                    ),
                  );
                },
                child: const Text("Custom Msg"),
              ),
              Container(
                color: Colors.white,
                height: 100, // Fixed height
                width: widthAnimation.value, // Animated width
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ToastMsg.showSuccess(
                    message: "Response Data of API",
                    controller: controller, // Pass the controller
                  );
                },
                child: const Text("Show Animated Toast"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.forward(from: 0);
          },
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}

class ToastMsg {
  static void showSuccess({
    required String message,
    required AnimationController controller, // Use the existing controller
    int duration = 3,
  }) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: duration),
      toastBuilder: (CancelFunc? cancelFunc) {
        // Show the icon on the left side
        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            controller.forward(from: 0);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check, size: 50, color: Colors.green),
                const SizedBox(width: 10),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    double width = Tween<double>(begin: 0, end: 300)
                        .animate(controller)
                        .value;
                    return Container(
                      color: Colors.white,
                      height: 100, // Fixed height
                      width: width, // Animated width
                      child: const Center(
                        child: Text("Response Data of API"),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
