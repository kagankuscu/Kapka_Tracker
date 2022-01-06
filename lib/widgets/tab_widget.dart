import 'package:flutter/material.dart';
import 'package:employees_salary_tracker/pages/create_page.dart';
import 'package:employees_salary_tracker/pages/filter_page.dart';
import 'package:employees_salary_tracker/pages/modify_page.dart';

class TabWidget extends StatefulWidget {
  final tabController;
  const TabWidget({Key? key, required this.tabController}) : super(key: key);

  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {

  static final _kTabPages = [
    CreatePage(),
    ModifyPage(),
    FilterPage(),
  ];

  @override
  void initState() {
    // _tabController = TabController(length: _kTabPages.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: _kTabPages,
    );
  }
}
