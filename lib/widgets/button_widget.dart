import 'package:employees_salary_tracker/utils/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({required this.text, required this.onClicked, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color[600],
      minimumSize: const Size.fromHeight(50),
      shape: const StadiumBorder(),
    ),
    child: FittedBox(
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: colorLightBlue),
      ),
    ),
    onPressed: onClicked,
  );
}
