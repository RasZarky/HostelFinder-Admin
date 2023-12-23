import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../add_hostel/components/customTextField.dart';

class AddManager extends StatefulWidget {
  const AddManager({super.key});

  @override
  State<AddManager> createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  final _idTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldkey,
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
              "Enter Manager details below",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Brand-Bold',
                letterSpacing: 1,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height: 50),

                const SizedBox(height: 50),

                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _idTextEditingController,
                        textInputType: TextInputType.text,
                        data: Icons.location_city,
                        hintText: "Login ID",
                        labelText: "Login ID",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _passwordTextEditingController,
                        textInputType: TextInputType.text,
                        data: Icons.location_on_outlined,
                        hintText: "Password",
                        labelText: "Password",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),


                      const SizedBox(height: 10,),

                    ],
                  ),
                ),

                const SizedBox(height: 15),

                //--------------------Create Button-----------------------//
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll( Color(0xFF4FBE9F) ),
                    ),

                    onPressed: () async {
                      //-------------Internet Connectivity--------------------//


                      //----------------checking textfield--------------------//
                      if (_idTextEditingController.text.length < 4) {
                        var snackBar = const SnackBar(
                          content: Text( "ID must be at least 4 characters",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Name must be at least 4 characters");
                        return;
                      }

                      if (_passwordTextEditingController.text.length < 8) {
                        var snackBar = const SnackBar(
                          content: Text( "Password must be at least 8 characters",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Password must be at least 8 characters");
                        return;
                      }


                      databaseRef.child("managers").child(_idTextEditingController.text.trim() ).set({
                        'id': _idTextEditingController.text.trim(),
                        'password': _passwordTextEditingController.text.trim(),
                      });

                      var snackBar = const SnackBar(
                        content: Text( "Manager created successfully",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    },
                    child: Text(
                      "Create".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),


                const SizedBox(height: 10),
              ],
            ),
          )
      ),
    );
  }
}
