import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/MenuAppController.dart';
import '../../responsive.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/dashboard_screen2.dart';
import 'components/side_menu.dart';
import 'components/side_menu2.dart';

class MainScreen2 extends StatelessWidget {
  const MainScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu2(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu2(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen2(),
            ),
          ],
        ),
      ),
    );;
  }
}
