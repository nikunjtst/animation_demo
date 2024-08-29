import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class AnimatedScree extends StatefulWidget {
  const AnimatedScree({super.key});

  @override
  State<AnimatedScree> createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedScree> {
  void customToast(BuildContext context, {required String msg}) {
    showToast(msg,
        context: context,
        animation: StyledToastAnimation.slideToRight,
        duration: const Duration(seconds: 3),
        textStyle: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        toastHorizontalMargin: 25,
        position: StyledToastPosition.top,
        backgroundColor: Colors.greenAccent,
        fullWidth: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  customToast(context, msg: "Hello");
                },
                child: const Text("Custom Msg"))
          ],
        ),
      ),
    );
  }
}
