import 'package:flutter/material.dart';

class NavigateWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClickedNext;
  final VoidCallback onClickedPrevious;

  const NavigateWidget(
      {Key? key,
      required this.text,
      required this.onClickedNext,
      required this.onClickedPrevious})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 48,
            onPressed: onClickedPrevious,
            icon: const Icon(Icons.navigate_before),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(
            iconSize: 48,
            onPressed: onClickedNext,
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      );
}
