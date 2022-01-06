import 'package:intl/intl.dart';
import 'package:employees_salary_tracker/utils/constants.dart';
import 'package:employees_salary_tracker/model/worker.dart';

String capitializedFirstLetterList(List<Worker> workers, int index) {
  return "${workers[index].name[0].toUpperCase()}${workers[index].name.substring(1)}";
}

String capitializedFirstLetterWorker(Worker worker) {
  return "${worker.name[0].toUpperCase()}${worker.name.substring(1)}";
}

String addPriceSymbol(Worker worker) {
  return "${worker.price} ${bulgarianLev}";
}

int convertDateTimeToInt({DateTime? date}) {
  int days = 0;
  if (date == null) {
    DateTime now = new DateTime.now();
    days = now.difference(google_sheet_start_date).inDays;
  } else {
    days = date.difference(google_sheet_start_date).inDays + 1;
  }
  return days;
}

String convertIntToDateTime(int days) {
  DateTime addingTime = google_sheet_start_date.add(Duration(days: days));
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(addingTime);
}
