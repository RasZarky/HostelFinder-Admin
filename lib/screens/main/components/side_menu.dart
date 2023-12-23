import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hostel_finder_admin/screens/add_room/add_room.dart';
import 'package:hostel_finder_admin/screens/dashboard/dashboard_screen.dart';
import 'package:hostel_finder_admin/screens/view_rooms/manager_view_rooms.dart';
import 'package:hostel_finder_admin/screens/view_rooms/view_rooms.dart';

import '../../add_hostel/addHostel.dart';
import '../../transactions/transactions.dart';
import '../../view_hostels/manager_view_hostels.dart';
import '../../view_hostels/view_hostels.dart';
import '../main_screen.dart';

class SideMenu extends StatelessWidget {

  final String id;
  const SideMenu({
    Key? key, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/profile_pic.png"),
          ),

          DrawerListTile(
            title: "Add Hostel",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AddHostel(id: id,)));
            },
          ),
          DrawerListTile(
            title: "Add Room",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AddRoom(id: id,)));
            },
          ),
          DrawerListTile(
            title: "View My Hostels",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => ManagerViewHostels(id: id,)));
              },
          ),
          DrawerListTile(
            title: "View My Rooms",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ManagerViewRooms(id: id,)));
            },
          ),

          DrawerListTile(
            title: "Bookings",
            svgSrc: "assets/icons/one_drive.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Transactions(id: id,)));
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
