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
        textColor: Colors.white70,
        iconColor: Colors.white70,
      ),
      backgroundColor:
          this.isDelete != true ? Colors.green[400] : Colors.red[400],
    );
  }
}
