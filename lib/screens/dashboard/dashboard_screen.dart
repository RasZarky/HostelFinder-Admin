import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:hostel_finder_admin/responsive.dart';
import 'package:hostel_finder_admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {

  final String id;
  DashboardScreen( {required this.id});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState(id: id);
}

class _DashboardScreenState extends State<DashboardScreen> {

  final String id;
  _DashboardScreenState( {required this.id});

  Query dbRef1 = FirebaseDatabase.instance.ref().child('bookings').orderByChild('status').equalTo('pending');

  Widget listItem( {required Map pending}){
    return pending['manager'] == id ? Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pending['hostel'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            pending['room'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            pending['duration']+' semester(s)',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            '${'GHC '+pending['price']} per semester',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            pending['user email'],
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
                  //                   label: Text("Cancel order"))
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ));
                  FirebaseDatabase.instance.ref().child('bookings').child(pending['key']).update({
                    'status': 'processing'
                  });
                  var snackBar = const SnackBar(
                    content: Text( "Order Accepted",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text(
                  'Accept Order',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25,
                      backgroundColor: Colors.red),
                ),
              )
            ],
          )
        ],
      ),
    ) : Container() ;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      //MyFiles(),
                      SizedBox(height: defaultPadding),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: FirebaseAnimatedList(
                          query: dbRef1,
                          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

                            Map pending = snapshot.value as Map;
                            pending['key'] = snapshot.key;

                            return  listItem(pending: pending);
                          },

                        ),
                      ),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      // if (Responsive.isMobile(context))
                      //   //StorageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                // if (!Responsive.isMobile(context))
                //   // Expanded(
                //   //   flex: 2,
                //   //   //child: StorageDetails(),
                //   // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
