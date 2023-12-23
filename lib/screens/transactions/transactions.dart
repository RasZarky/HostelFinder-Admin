import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key, required this.id});

  final String id;
  @override
  State<Transactions> createState() => _TransactionsState(id: id);
}

class _TransactionsState extends State<Transactions> {

  final String id;
  _TransactionsState( {required this.id});

  Query dbRef1 = FirebaseDatabase.instance.ref().child('bookings').orderByChild('status').equalTo('pending');
  Query dbRef2 = FirebaseDatabase.instance.ref().child('bookings').orderByChild('status').equalTo('processing');
  Query dbRef3 = FirebaseDatabase.instance.ref().child('bookings').orderByChild('status').equalTo('completed');

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

  Widget listItem2( {required Map processing}){
    return processing['manager'] == id ? Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            processing['hostel'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            processing['room'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            processing['duration']+' semester(s)',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            '${'GHC '+processing['price']} per semester',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            processing['user email'],
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
                  FirebaseDatabase.instance.ref().child('bookings').child(processing['key']).update({
                    'status': 'completed'
                  });
                  var snackBar = const SnackBar(
                    content: Text( "Order Completed",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text(
                  'Payment Received',
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

  Widget listItem3( {required Map completed}){
    return completed['manager'] == id ? Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            completed['hostel'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            completed['room'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            completed['duration']+' semester(s)',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            '${'GHC '+completed['price']} per semester',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            completed['user email'],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),

        ],
      ),
    ) : Container();
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
                  text: 'Pending',
                ),
                Tab(icon: Icon(Icons.update),
                  text: 'Processing',
                ),
                Tab(icon: Icon(Icons.done_all),
                  text: 'Completed',
                ),
              ]
          ),
          title: const Text('Bookings'),
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
            Container(
              child: FirebaseAnimatedList(
                query: dbRef3,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

                  Map completed = snapshot.value as Map;
                  completed['key'] = snapshot.key;

                  return  listItem3(completed: completed);
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
