import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hostel_finder_admin/screens/add_manager/addManager.dart';
import 'package:hostel_finder_admin/screens/view_users/admin_view_users.dart';

import '../../add_hostel/addHostel.dart';
import '../../view_hostels/view_hostels.dart';
import '../../view_rooms/view_rooms.dart';

class SideMenu2 extends StatelessWidget {
  const SideMenu2({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/profile_pic.png"),
          ),

          DrawerListTile(
            title: "Add Hostel Manager",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddManager()));
            },
          ),

          DrawerListTile(
            title: "View Hostels",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ViewHostels()));
            },
          ),
          DrawerListTile(
            title: "View Rooms",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ViewRooms()));
            },
          ),
          DrawerListTile(
            title: "View Users",
            svgSrc: "assets/icons/pdf_file.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AdminViewUsers()));
            },
          ),

        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}