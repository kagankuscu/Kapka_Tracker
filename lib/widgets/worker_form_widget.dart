import 'package:flutter/material.dart';
import 'package:employees_salary_tracker/constants.dart';
import 'package:employees_salary_tracker/model/worker.dart';
import 'package:employees_salary_tracker/utils/utils.dart';
import 'package:employees_salary_tracker/widgets/button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkerFormWidget extends StatefulWidget {
  final Worker? worker;
  final ValueChanged<Worker> onSavedWorker;
  const WorkerFormWidget({Key? key, required this.onSavedWorker, this.worker})
      : super(key: key);

  @override
  State<WorkerFormWidget> createState() => _WorkerFormWidgetState();
}

class _WorkerFormWidgetState extends State<WorkerFormWidget> {
  DateTime? _dateTime;
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerPrice;
  late TextEditingController controllerDate;

  @override
  void initState() {
    initWorker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            const SizedBox(
              height: 16,
            ),
            buildPrice(),
            const SizedBox(
              height: 16,
            ),
            Text(AppLocalizations.of(context).dateIsOptional),
            const SizedBox(height: 4),
            buildDate(),
            const SizedBox(
              height: 16,
            ),
            buildSubmit(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).name,
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? AppLocalizations.of(context).enterName : null,
      );

  Widget buildPrice() => TextFormField(
        controller: controllerPrice,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).dailySalary,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) =>
            value != null && value.isEmpty ? AppLocalizations.of(context).enterDailySalary : null,
      );

  Widget buildDate() => TextFormField(
        onTap: () => {
          showDatePicker(
            context: this.context,
            firstDate: google_sheet_start_date,
            initialDate: DateTime.now(),
            lastDate: DateTime.now(),
          ).then(
            (value) => {
              setState(() {
                _dateTime = value;
                controllerDate.text = _dateTime.toString();
              }),
            },
          )
        },
        controller: controllerDate,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).date,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.datetime,
      );

  Widget buildSubmit() => ButtonWidget(
        text: AppLocalizations.of(context).save,
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if (isValid) {
            final id = widget.worker == null ? null : widget.worker!.id;

            final worker = Worker(
                id: id,
                name: controllerName.text,
                price: controllerPrice.text,
                date: _dateTime == null
                    ? convertDateTimeToInt()
                    : convertDateTimeToInt(date: _dateTime));

            widget.onSavedWorker(worker);

            controllerName.clear();
            controllerPrice.clear();
            controllerDate.clear();
          }
        },
      );

  void initWorker() {
    final name = widget.worker == null ? '' : widget.worker!.name;
    final price = widget.worker == null ? '' : widget.worker!.price;
    final date =
        widget.worker == null ? '' : convertIntToDateTime(widget.worker!.date);

    setState(() {
      controllerName = TextEditingController(text: name);
      controllerPrice = TextEditingController(text: price.toString());
      controllerDate = TextEditingController(text: date.toString());
    });
  }

  @override
  void didUpdateWidget(covariant WorkerFormWidget oldWidget) {
    initWorker();
    super.didUpdateWidget(oldWidget);
  }
}
