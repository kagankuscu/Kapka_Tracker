import 'package:employees_salary_tracker/widgets/progress_widget.dart';
import 'package:flutter/material.dart';

import 'info_text_widget.dart';

class IsEmptyWidget extends StatelessWidget {
  final isEmpty;
  const IsEmptyWidget({Key? key, required this.isEmpty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEmpty == 1 ? InfoTextWidget() : ProgressWidget();
  }
}
