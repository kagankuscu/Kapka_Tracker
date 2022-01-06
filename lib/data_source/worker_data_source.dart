import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:employees_salary_tracker/utils/utils.dart';

class WorkerDataSource extends DataGridSource {
  WorkerDataSource({required employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'name', value: capitializedFirstLetterWorker(e)),
              DataGridCell<String>(columnName: 'price', value: addPriceSymbol(e)),
              DataGridCell<String>(columnName: 'date', value: convertIntToDateTime(e.date)),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        },
      ).toList(),
    );
  }
}
