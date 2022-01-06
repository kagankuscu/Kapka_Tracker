import 'package:employees_salary_tracker/widgets/isEmpty_widget.dart';
import 'package:flutter/material.dart';
import 'package:employees_salary_tracker/api/sheet/worker_sheet_api.dart';
import 'package:employees_salary_tracker/constants.dart';
import 'package:employees_salary_tracker/model/worker.dart';
import 'package:employees_salary_tracker/widgets/button_widget.dart';
import 'package:employees_salary_tracker/widgets/navigate_widget.dart';
import 'package:employees_salary_tracker/widgets/snackbar_widget.dart';
import 'package:employees_salary_tracker/widgets/worker_form_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModifyPage extends StatefulWidget {
  const ModifyPage({Key? key}) : super(key: key);

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  bool _isUpdate = false;
  bool _isDeleted = false;
  List<Worker>? workers = [];
  int index = 0;
  int _isEmpty = 0;

  @override
  void initState() {
    getWorkers();
    super.initState();
  }

  Future getWorkers({index = 0}) async {
    final workers = await WorkerSheetsApi.getAll();
    if (workers.length == 0) _isEmpty = await WorkerSheetsApi.getValue();

    setState(() {
      this.workers = workers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return workers!.length != 0
        ? buildForm()
        : IsEmptyWidget(
            isEmpty: _isEmpty,
          );
  }

  Widget buildForm() => Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(padding8),
            child: buildCardWidget(),
          ),
        ),
      );

  Widget buildCardWidget() => Card(
        color: Colors.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: paddingListView(),
      );

  Widget paddingListView() => Padding(
        padding: const EdgeInsets.fromLTRB(
          paddingUserFormLeft,
          paddingUserFormTop,
          paddingUserFormRight,
          paddingUserFormBottom,
        ),
        child: buildListView(),
      );

  Widget buildListView() => ListView(
        shrinkWrap: true,
        children: [
          WorkerFormWidget(
            worker: workers!.isEmpty ? null : workers![index],
            onSavedWorker: (worker) async {
              _isUpdate =
                  await WorkerSheetsApi.update(worker.id!, worker.toJson());
              await getWorkers();

              if (_isUpdate) {
                final snackBar =
                    SnackBarWidget(text: AppLocalizations.of(context).updated);
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar.build(context));
              }
            },
          ),
          SizedBox(
            height: 16,
          ),
          buildControls(),
        ],
      );

  Widget buildControls() => Column(
        children: [
          ButtonWidget(
              text: AppLocalizations.of(context).delete, onClicked: deleteUser),
          NavigateWidget(
            text:
                "${index + 1}/${workers!.length} ${AppLocalizations.of(context).workers}",
            onClickedNext: () {
              final nextIndex = index >= workers!.length - 1 ? 0 : index + 1;

              setState(() {
                index = nextIndex;
              });
            },
            onClickedPrevious: () {
              final previousIndex =
                  index <= 0 ? workers!.length - 1 : index - 1;

              setState(() {
                index = previousIndex;
              });
            },
          ),
        ],
      );
  Future deleteUser() async {
    final worker = workers![index];
    _isDeleted = await WorkerSheetsApi.deleteById(worker.id!);

    if (_isDeleted) {
      final snackBar = SnackBarWidget(
        text: AppLocalizations.of(context).deleted,
        isDelete: true,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar.build(context));
    }

    // just for update UI
    final newIndex = index > 0 ? index - 1 : 0;
    await getWorkers(index: newIndex);
  }
}
