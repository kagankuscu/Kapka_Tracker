import 'package:employees_salary_tracker/utils/colors.dart';
import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  final String text;
  final bool isDelete;
  const SnackBarWidget({
    Key? key,
    required this.text,
    this.isDelete = false,
  }) : super(key: key);

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      content: ListTile(
        title: Text(this.text),
        leading: Icon(Icons.check),
        textColor: colorWhite,
        iconColor: colorWhite,
      ),
      backgroundColor:
          this.isDelete != true ? colorGreen : colorRed,
    );
  }
}
