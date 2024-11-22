import 'package:flutter/material.dart';
import 'package:my_sqflite/screens/sqflite_screen.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Local Sqf Lite',
            ),
            Tab(
              text: 'Connection api',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MySqfLite(),
          Content2(),
        ],
      ),
    );
  }
}

class Content2 extends StatelessWidget {
  const Content2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Content2'),
    );
  }
}
