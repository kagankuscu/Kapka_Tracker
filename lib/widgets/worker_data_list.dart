import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:employees_salary_tracker/data_source/worker_data_source.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkerDataList extends StatefulWidget {
  final WorkerDataSource workerDataSource;
  WorkerDataList({Key? key, required this.workerDataSource}) : super(key: key);

  @override
  State<WorkerDataList> createState() => _WorkerDataListState();
}

class _WorkerDataListState extends State<WorkerDataList> {
  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: widget.workerDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      allowSorting: true,
      allowMultiColumnSorting: true,
      allowTriStateSorting: true,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'name',
          label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).name),
          ),
        ),
        GridColumn(
          columnName: 'price',
          label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context).salary,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'date',
          label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context).date,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}