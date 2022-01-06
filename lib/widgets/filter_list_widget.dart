import 'package:flutter/material.dart';
import 'package:employees_salary_tracker/constants.dart';
import 'package:employees_salary_tracker/model/worker.dart';

class FilterListWidget extends StatelessWidget {
  final List<Worker> workers;
  final int index;
  const FilterListWidget({
    Key? key,
    required this.workers,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(
        marginListLeft,
        marginListTop,
        marginListRight,
        marginListBottom,
      ),
      child: ListTile(
        title: Center(
          child: Row(
            children: [
              Expanded(child: Text(capitializedFirstLetter(),textAlign: TextAlign.center,)),
              Expanded(child: Text(addPriceSymbol(),textAlign: TextAlign.center,)),
              Expanded(child: Text(workers[index].date.toString(),textAlign: TextAlign.center,)),
            ],
          ),
        ),
      ),
    );
  }
  String capitializedFirstLetter(){
    return "${workers[index].name[0].toUpperCase()}${workers[index].name.substring(1)}";
  }

  String addPriceSymbol() {
    return "${workers[index].price} ${bulgarianLev}";
  }
}
