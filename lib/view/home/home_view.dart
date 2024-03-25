import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:windows_calender_app/view/home/home_view_model.dart';
import 'package:windows_calender_app/view/home/widgets/drawer_list_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel vm = HomeViewModel();
  Function()? listener;

  List<Widget> pageList = [
    Container(
      color: Colors.white,
      child: Center(
        child: Text("Page1"),
      ),
    ),
    Container(
      color: Colors.white,
      child: Center(
        child: Text("Page2"),
      ),
    ),
    Container(
      color: Colors.white,
      child: Center(
        child: Text("Page3"),
      ),
    ),
    Container(
      color: Colors.white,
      child: Center(
        child: Text("Page4"),
      ),
    ),
    Container(
      color: Colors.white,
      child: Center(
        child: Text("Page5"),
      ),
    ),
    Container(
      color: Colors.white,
      child: Center(
        child: Text("Page6"),
      ),
    ),
    Container(
      color: Colors.blue,
      child: Center(
        child: Text("Page7"),
      ),
    ),
    Container(
      color: Colors.red,
      child: Center(
        child: Text("Page8"),
      ),
    ),
  ];

  @override
  void initState() {
    listener = () {
      if (mounted) {
        setState(() {});
      }
    };
    vm.addListener(listener!);
    super.initState();
  }

  @override
  void dispose() {
    vm.removeListener(listener!);
    listener = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text("김래렁"),
              ),
              DrawerListTile(
                title: "Dashboard",
                press: () {
                  vm.movePage(0);
                },
              ),
              DrawerListTile(
                title: "Transaction",
                press: () {
                  vm.movePage(1);
                },
              ),
              DrawerListTile(
                title: "Task",
                press: () {
                  vm.movePage(2);
                },
              ),
              DrawerListTile(
                title: "Documents",
                press: () {
                  vm.movePage(3);
                },
              ),
              DrawerListTile(
                title: "Store",
                press: () {
                  vm.movePage(4);
                },
              ),
              DrawerListTile(
                title: "Notification",
                press: () {
                  vm.movePage(5);
                },
              ),
              DrawerListTile(
                title: "Profile",
                press: () {
                  vm.movePage(6);
                },
              ),
              DrawerListTile(
                title: "Settings",
                press: () {
                  vm.movePage(7);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: vm.selectedIndex,
            children: pageList,
          ),
        )
      ],
    ));
  }
}
