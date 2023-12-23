
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hostel_finder_admin/constants.dart';

import '../view_rooms/components/view_rooms_model.dart';



class ManagerViewRooms extends StatefulWidget {
  const ManagerViewRooms({super.key, required this.id});

  final String id;
  @override
  State<ManagerViewRooms> createState() => _ManagerViewRoomsState(id: id);
}

class _ManagerViewRoomsState extends State<ManagerViewRooms> {

  final String id;
  _ManagerViewRoomsState( {required this.id});

  Query dbRef = FirebaseDatabase.instance.ref().child('rooms');

  Widget listItem( {required Map users}){
    return users['managerId'] == id ? Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            users['name'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            users['people'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            users['managerId'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            users['price'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            users['hostel'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  // AlertDialog(
                  //     title: const Center(
                  //       child: Column(
                  //         children: [
                  //           Icon(Icons.warning_outlined,
                  //               size: 36, color: Colors.red),
                  //           SizedBox(height: 20),
                  //           Text("Confirm order update"),
                  //         ],
                  //       ),
                  //     ),
                  //     content: Container(
                  //       //color: secondaryColor,
                  //       height: 110,
                  //       child: Column(
                  //         children: [
                  //           Text(
                  //               "Are you sure want to process '${pending['orderId']}'?"),
                  //           SizedBox(
                  //             height: 16,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               ElevatedButton.icon(
                  //                   icon: Icon(
                  //                     Icons.close,
                  //                     size: 14,
                  //                   ),
                  //                   style: ElevatedButton.styleFrom(
                  //                       primary: Colors.grey),
                  //                   onPressed: () {
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                   label: Text("Cancel")),
                  //               SizedBox(
                  //                 width: 20,
                  //               ),
                  //               ElevatedButton.icon(
                  //                   icon: Icon(
                  //                     Icons.delete,
                  //                     size: 14,
                  //                   ),
                  //                   style: ElevatedButton.styleFrom(
                  //                       primary: Colors.red),
                  //                   onPressed: () {},
                  //                   label: Text("Process"))
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ));
                  FirebaseDatabase.instance.ref().child('rooms').child(users['key']).remove();
                  var snackBar = const SnackBar(
                    content: Text( "Hostel Deleted",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25,
                      backgroundColor: Colors.red),
                ),
              )
            ],
          )
        ],
      ),
    ) : Container();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Center(
              child: const Text(
                "All Rooms",

              ),
            ),
          ),
          body:  SizedBox(
              width: double.infinity,
              child: Container(
                child: FirebaseAnimatedList(
                  query: dbRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

                    Map users = snapshot.value as Map;
                    users['key'] = snapshot.key;

                    return  listItem(users: users);
                  },

                ),
              )
          ),
        )

    );
  }
}

