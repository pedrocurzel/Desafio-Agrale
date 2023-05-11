import 'package:agrale/Screens/Home/home_screen.dart';
import 'package:agrale/Screens/Menu/menu_screen.dart';
import 'package:agrale/Screens/Chassi/consulta_chassi_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../consts/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const List<Map<String, dynamic>> navBottomItems = [
    {
      "icon": Icons.home,
      "label": "Tela Inicial",
    },
    {
      "icon": Icons.search,
      "label": "Consulta Chassi",
    },
    {
      "icon": Icons.menu,
      "label": "Menu",
    },
  ];

  late TabController tabController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: navBottomItems.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: Text(
            navBottomItems[tabController.index]['label'],
            style: TextStyle(color: Color(0xff4D4D4D)),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            ),
          ),
        ),
        backgroundColor: Color(backgroundWhite),
        body: SafeArea(
          child: DefaultTabController(
            length: navBottomItems.length,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  HomeScreen(
                    changePageFunction: changePage,
                  ),
                  ConsultaChassiScreen(),
                  MenuScreen(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 63,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1, color: Colors.grey))),
          child: BottomNavigationBar(
            iconSize: 30,
            currentIndex: tabController.index,
            selectedItemColor: Color(baseRed),
            onTap: (index) {
              changePage(index);
            },
            items: [
              for (var navItem in navBottomItems)
                BottomNavigationBarItem(
                  icon: Icon(navItem["icon"] as IconData),
                  label: navItem["label"] as String,
                )
            ],
          ),
        ));
  }

  void changePage(int index) {
    setState(() {
      tabController.animateTo(index);
    });
  }
}
