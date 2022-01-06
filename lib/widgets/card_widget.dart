import 'package:employees_salary_tracker/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:employees_salary_tracker/utils/constants.dart';
import 'package:employees_salary_tracker/widgets/snackbar_widget.dart';
import 'package:employees_salary_tracker/widgets/worker_form_widget.dart';
import 'package:employees_salary_tracker/api/sheet/worker_sheet_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool _isInsert = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding8),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(cardWidgetRound),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                paddingUserFormLeft,
                paddingUserFormTop,
                paddingUserFormRight,
                paddingUserFormBottom),
            child: WorkerFormWidget(
              onSavedWorker: (worker) async {
                final id = await WorkerSheetsApi.getRowCount() + 1;
                final newWorker = worker.copy(id: id);

                _isInsert = await WorkerSheetsApi.insert([newWorker.toJson()]);

                if (_isInsert) {
                  final snackBar = SnackBarWidget(text: AppLocalizations.of(context).saved,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar.build(context));
                }
              },
            ),
          ),
          color: colorBlue,
        ),
      ),
    );
  }
}
