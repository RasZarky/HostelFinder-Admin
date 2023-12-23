import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hostel_finder_admin/constants.dart';

class AdminViewUsers extends StatefulWidget {
  const AdminViewUsers({super.key});

  @override
  State<AdminViewUsers> createState() => _AdminViewUsersState();
}

class _AdminViewUsersState extends State<AdminViewUsers> {

  Query dbRef1 = FirebaseDatabase.instance.ref().child('managers');
  Query dbRef2 = FirebaseDatabase.instance.ref().child('users');

  Widget listItem( {required Map pending}){
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      color: bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pending['id'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(width: 50,),
          Text(
            pending['password'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(width: 50,),
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
                  FirebaseDatabase.instance.ref().child('managers').child(pending['key']).remove();
                  var snackBar = const SnackBar(
                    content: Text( "Manager Deleted",
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
    );
  }

  Widget listItem2( {required Map processing}){
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      color: bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            processing['first name']+' '+processing['last name'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            processing['email'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     GestureDetector(
          //       onTap: (){
          //         // AlertDialog(
          //         //     title: const Center(
          //         //       child: Column(
          //         //         children: [
          //         //           Icon(Icons.warning_outlined,
          //         //               size: 36, color: Colors.red),
          //         //           SizedBox(height: 20),
          //         //           Text("Confirm order update"),
          //         //         ],
          //         //       ),
          //         //     ),
          //         //     content: Container(
          //         //       //color: secondaryColor,
          //         //       height: 110,
          //         //       child: Column(
          //         //         children: [
          //         //           Text(
          //         //               "Are you sure want to complete '${processing['orderId']}'?"),
          //         //           SizedBox(
          //         //             height: 16,
          //         //           ),
          //         //           Row(
          //         //             mainAxisAlignment: MainAxisAlignment.center,
          //         //             children: [
          //         //               ElevatedButton.icon(
          //         //                   icon: Icon(
          //         //                     Icons.close,
          //         //                     size: 14,
          //         //                   ),
          //         //                   style: ElevatedButton.styleFrom(
          //         //                       primary: Colors.grey),
          //         //                   onPressed: () {
          //         //                     Navigator.of(context).pop();
          //         //                   },
          //         //                   label: Text("Cancel")),
          //         //               SizedBox(
          //         //                 width: 20,
          //         //               ),
          //         //               ElevatedButton.icon(
          //         //                   icon: Icon(
          //         //                     Icons.delete,
          //         //                     size: 14,
          //         //                   ),
          //         //                   style: ElevatedButton.styleFrom(
          //         //                       primary: Colors.red),
          //         //                   onPressed: () {},
          //         //                   label: Text("Complete"))
          //         //             ],
          //         //           )
          //         //         ],
          //         //       ),
          //         //     ));
          //         FirebaseDatabase.instance.ref().child('users').child(processing['key']).remove();
          //         var snackBar = const SnackBar(
          //           content: Text( "Order status updated",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(fontSize: 15),
          //           ),
          //         );
          //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //       },
          //       child: Text(
          //         'Complete',
          //         style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25,
          //             backgroundColor: Colors.green),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.pending_actions),
                  text: 'Managers',
                ),
                Tab(icon: Icon(Icons.update),
                  text: 'Users',
                ),
              ]
          ),
          title: const Text('All Users'),
        ),

        body: TabBarView(
          children: [
            Container(
              child: FirebaseAnimatedList(
                query: dbRef1,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

                  Map pending = snapshot.value as Map;
                  pending['key'] = snapshot.key;

                  return  listItem(pending: pending);
                },

              ),
            ),
            Container(
              child: FirebaseAnimatedList(
                query: dbRef2,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

                  Map processing = snapshot.value as Map;
                  processing['key'] = snapshot.key;

                  return  listItem2(processing: processing);
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
