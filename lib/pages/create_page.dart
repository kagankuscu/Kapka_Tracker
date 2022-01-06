import 'package:flutter/material.dart';
import 'package:employees_salary_tracker/widgets/card_widget.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SingleChildScrollView(child: const CardWidget()));
  }
}
