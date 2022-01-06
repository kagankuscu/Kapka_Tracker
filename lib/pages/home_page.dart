import 'package:employees_salary_tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'create_page.dart';
import 'filter_page.dart';
import 'modify_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  static final _kTabPages = [
    CreatePage(),
    ModifyPage(),
    FilterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: _kTabPages,
      ),
      bottomNavigationBar: Material(
        color: Colors.grey[400],
        child: TabBar(
          indicatorColor: Colors.black,
          overlayColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.grey[600]!;
              } else if (states.contains(MaterialState.hovered)) {
                return Colors.grey[300]!;
              }

              return Colors.transparent;
            },
          ),
          tabs: [
            Tab(
              text: AppLocalizations.of(context).createPage,
            ),
            Tab(
              text: AppLocalizations.of(context).modifyPage,
            ),
            Tab(
              text: AppLocalizations.of(context).filterPage,
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
