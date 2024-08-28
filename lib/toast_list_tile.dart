import 'package:flutter/material.dart';

class ToastListTile extends StatelessWidget {
  final IconData iconData;
  final Widget textWidget;
  final Color bgColor;

  const ToastListTile(
      {super.key,
      required this.iconData,
      required this.textWidget,
      required this.bgColor});

  @override
  Padding build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          elevation: 15,
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: textWidget,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
