import 'package:employees_salary_tracker/model/worker.dart';
import 'package:gsheets/gsheets.dart';

class WorkerSheetsApi {
  static const _credential = r'''
{
  "type": "service_account",
  "project_id": "gsheet2-329320",
  "private_key_id": "93aac697b904a46db999e2c31ec23a34439546bf",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZeu6mPQ96DLF3\n1+YEH2Qvym61N5PH04nJKDE9ycksPGxTsfdayCskeNYIFlytrmre4AIymjCiNxNI\nAjm39Hg+X4JVlaN6naqOikai6L9Za/S4DR4TWEYu3UI5z1Ir0chGTTyl2AdkdLSl\nKnjGGkRKEUvPC+EahvvDttxEg+tZrflTzYZTWxWp+ZQFNtlQwOl/zTH6SRuF40Jt\nb6TcIcJSC67pxCqsdzSyURUdz7E0yzE7cwA3SNtf6A4pnz5mUtH8nQouKcDq1Eu6\nX92TPFn5fBU2UxEEDvo8totvhqZRU/+hzq3Vu9pTHGVZJ8abIzmxHVC5qsFVqB+k\nXcW+QSfNAgMBAAECggEASSKNFLxd8wZHu+yPvn0r/OJPfoN1H/LkWBA7FvM/wq+D\nIlYrv4ym7XnxSAD1I7cO22prcsblafepdULCVDlTIm6N7ugGdNqGm66meGxaxOCI\nCEjo/0plN6dSeQxeLrw6ZGHe7kqKmd6hTRXOTZhRtLLCUptFFN2l1rgstKHESICY\n8yL7cj5cG9tGjQriC6STakuwK4wkob547bd4Agt0k1dGQ6v+G+BIhzOtQGVlmgyt\nqB74XakK4fP8PckKj54TlM331DURl9W+he4OFMifpSCoJi1Ujly0SKHO6jL2kTWh\nLjMHi8QkUu/N4kvHVO/XUK/C+9mvEOmA0nsu3pD3xQKBgQD5QXTb/NBYOWht3kLn\nz33EwLxRaWYDeaTUTJ0ZtUuhK4eBTWOYjX5QElwBrEDF5Zn562LMe/PZ+p+Prj56\nW7YzmrePIM230ygZRlAbMREEK3Nx5qbmR3KIIfL5dMlas9+e886CAR+pg1U/TaqG\n6qgTli7WD/uFcy+HQG8mfq7LrwKBgQDfXV+X3clhODbjxqQ5Kwr1Fpzgb3n7EVqF\nW4kZqN6gAjgBq0QCmRiNjxm37Az5O0Ge9m2/9i82ibBEYeyvc131/Wza6kT7A+kJ\nTW6x5BVgWtYtAarDuFVfeAyUo64+ecHNyeNAOuzrUz5l8Sv9OiwirCOx4Im9OyCt\nt5PFYsT3QwKBgCfSAz9Z5lcR5NMYnQu3pFoYiH1hH0ES3/hivP5sbkazU5Sernii\nsjlMlZJW2IpFIhJBPql4a/65AWDM74JQwI0B/K1LClKB03gmOYn+jr9hybG6rZNA\netWwxsZ/l+N7tRAJ10YBs/M63hWc7M9dEbj/V0AvkXlCa6dp7dfyiS5VAoGAFh2v\nrmDGZLrlLG5pqkNpxVSk2dAP2t0gAl5K1+CRknRFyVyE0mEIPlPx7vUPX8oPOEcc\nHMqqaBMAAfVUMxcQMaATHCXgCJ6df09Ma46y0ySLWk908gYZZeeED1+ZjBQQLWkU\n+DIdbTuDzSIxAdS1tAUpT5505Oiq1qh7mCqsZ/MCgYEA2WGTPV60ysmZM7onEfTc\nCsBrSmxtTvHiRWtPaH2PP5ZIxh4mM/L9LbbXdR/oCijyvBWNaVl1JIbVGobo3SG2\ndM3yevumnVFK03ZuEwrue9U9AsYYzzznsrhZEXWAuMrd6zkWhZMPp62Ep/UQy0p1\nB9S142xPeBLBFINmQJDxB5A=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheet2-329320.iam.gserviceaccount.com",
  "client_id": "107480856911816379821",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheet2-329320.iam.gserviceaccount.com"
}

  ''';
  // ignore: prefer_const_declarations
  static final _spreadsheetId = '1hFvbaa6jwciVBGulswjgcmM2h1C-7RamuAeoDtcYMvo';

  static final _gsheets = GSheets(_credential);
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
