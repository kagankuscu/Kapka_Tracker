import 'package:employees_salary_tracker/widgets/isEmpty_widget.dart';
import 'package:flutter/material.dart';
import 'package:employees_salary_tracker/api/sheet/worker_sheet_api.dart';
import 'package:employees_salary_tracker/utils/constants.dart';
import 'package:employees_salary_tracker/data_source/worker_data_source.dart';
import 'package:employees_salary_tracker/model/worker.dart';
import 'package:employees_salary_tracker/widgets/worker_data_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<Worker>? workers = [];
  List<Worker>? replaceWorkers = [];
  int _isEmpty = 0;

  @override
  void initState() {
    getWorkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(padding8),
      child: Column(
        children: [
          SizedBox(height: 8),
          buildSearchField(),
          SizedBox(height: 8),
          // ListTile(
          //     title: Text(
          //   "Results",
          //   textAlign: TextAlign.center,
          // )),
          Divider(
            thickness: 4,
          ),
          buildList(),
        ],
      ),
    );
  }

  Widget buildList() => Expanded(
        child: workers!.length != 0
            ? WorkerDataList(
                workerDataSource: WorkerDataSource(employeeData: workers),
              )
            : IsEmptyWidget(
              isEmpty: _isEmpty,
            ),
      );

  Widget buildSearchField() => TextFormField(
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).searchName,
          border: OutlineInputBorder(),
        ),
        validator: (value) => value != null && value.isEmpty
            ? AppLocalizations.of(context).enterName
            : null,
        onChanged: (value) {
          List<Worker>? filteredWorker = [];

          for (int i = 0; i < workers!.length; i++) {
            if (value.toLowerCase() == workers![i].name.toLowerCase()) {
              filteredWorker.add(workers![i]);
            }
          }

          setState(() {
            if (!value.isEmpty && !filteredWorker.isEmpty) {
              workers!.clear();
              workers!.addAll(filteredWorker);
            } else {
              workers!.clear();
              workers!.addAll(replaceWorkers!);
            }
          });
        },
      );

  Future getWorkers({index = 0}) async {
    final workers = await WorkerSheetsApi.getAll();
    var reversedOrder = workers.reversed.toList();
    replaceWorkers!.addAll(reversedOrder);

    if (workers.length == 0) _isEmpty = await WorkerSheetsApi.getValue();

    setState(() {
      this.workers = reversedOrder.toList();
    });
  }
}
