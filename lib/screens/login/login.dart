import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_finder_admin/constants.dart';
import 'package:hostel_finder_admin/screens/main/main_screen.dart';

import '../add_hostel/components/customTextField.dart';
import '../main/main_sreen2.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final _idController = TextEditingController();

  bool _isManager = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor, // set the background color here

      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),

                Image.asset('assets/images/introduction2.png'),

                const SizedBox(height: 20,),

                CustomTextField(
                  controller: _idController,
                  data: Icons.perm_identity,
                  hintText: 'ID',
                  isObsecure: false,
                  textInputType: TextInputType.text,
                  labelText: 'ID',
                  maxlines: null, minlines: null,

                ),

                const SizedBox(height: 20.0),

                CustomTextField(
                  controller: _passwordController,
                  data: Icons.lock,
                  hintText: 'Password',
                  isObsecure: true,
                  textInputType: TextInputType.text,
                  labelText: 'Password',
                  maxlines: 1, minlines: 1,
                ),

                const SizedBox(height: 15),

                Center(child: Visibility(visible: isLoading,
                  child: Stack(
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          color: bgColor,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          width: 300.0,
                          height: 200.0,
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 50.0,
                                  width: 50.0,
                                  child: CircularProgressIndicator(
                                    value: null,
                                    strokeWidth: 7.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Center(
                                  child: Text(
                                    "Please wait ...",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),)),

                const SizedBox(height: 15),

                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isManager,
                      onChanged: (value) {
                        setState(() {
                          _isManager = value!;
                        });
                      },
                    ),
                    const Text('Login as a Shop manager'),
                  ],
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {

                      String password = _passwordController.text.trim();
                      String id = _idController.text.trim();
                      final databaseRef = FirebaseDatabase.instance.ref().child('managers').child(id).child('password');

                      setState(() {
                        isLoading = true;
                      });

                      if (_isManager) {


                        final snapshot = await databaseRef.get();
                        if(snapshot.exists && snapshot.value.toString() == password){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  MainScreen(id: id)),
                          );
                        }else {
                          var snackBar = const SnackBar(
                            content: Text( "Wrong details provided",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        setState(() {
                          isLoading = false;
                        });
                      } else {

                        if(password == 'admin12345' && id == 'admin'){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen2()),
                          );
                        } else{
                          var snackBar = const SnackBar(
                            content: Text( "Wrong details provided",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        setState(() {
                          isLoading = false;
                        });

                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Text('Log In'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
