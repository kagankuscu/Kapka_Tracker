import 'package:employees_salary_tracker/model/worker.dart';
import 'package:employees_salary_tracker/utils/credentials.dart';
import 'package:gsheets/gsheets.dart';

class WorkerSheetsApi {
  // ignore: prefer_const_declarations
  static final _spreadsheetId = '1hFvbaa6jwciVBGulswjgcmM2h1C-7RamuAeoDtcYMvo';

  static final _gsheets = GSheets(credential);
  // ignore: unused_field
  static Worksheet? _workerSheet;

  static Future init() async {
    try {
      final spreadSheet = await _gsheets.spreadsheet(_spreadsheetId);
      _workerSheet = await _getWorkSheet(spreadSheet, title: 'Users');

      final firstRow = WorkerFields.getFields();
      _workerSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<int> getValue() async {
    if (_workerSheet == null) return -1;

    final lastRow = await _workerSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 1;
  }

  static Future<int> getRowCount() async {
    if (_workerSheet == null) return 0;

    final lastRow = await _workerSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<Worker?> getById(int id) async {
    if (_workerSheet == null) return null;

    final json = await _workerSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Worker.fromJson(json);
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadSheet,
      {required String title}) async {
    try {
      return await spreadSheet.addWorksheet(title);
    } catch (e) {
      return spreadSheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_workerSheet == null) return;

    return _workerSheet!.values.map.appendRows(rowList);
  }

  static Future<List<Worker>> getAll() async {
    if (_workerSheet == null) return <Worker>[];

    final workers = await _workerSheet!.values.map.allRows();
    return workers == null ? <Worker>[] : workers.map(Worker.fromJson).toList();
  }

  static Future<bool> update(int id, Map<String, dynamic> user) async {
    if (_workerSheet == null) return false;

    return _workerSheet!.values.map.insertRowByKey(id, user);
  }

  static Future<bool> deleteById(int id) async {
    if (_workerSheet == null) return false;

    final index = await _workerSheet!.values.rowIndexOf(id);

    return _workerSheet!.deleteRow(index);
  }

  //  static Future<List<Worker>> getWorkerByName(String name) async {
  //   if (_workerSheet == null) return <Worker>[];

  //   final workers = await getAll();

  //   return workers;
  // }
}
