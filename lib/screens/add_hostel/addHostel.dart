import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import 'components/customTextField.dart';

class AddHostel extends StatefulWidget {
  final String id;
  const AddHostel({super.key, required this.id});

  @override
  State<AddHostel> createState() => _AddHostelState(id: id);
}

class _AddHostelState extends State<AddHostel> {
  final String id;
  _AddHostelState({required this.id});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  final _nameTextEditingController = TextEditingController();
  final _locationTextEditingController = TextEditingController();
  final _coordinatesTextEditingController = TextEditingController();
  final _coordinatesTextEditingController2 = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();
  final _priceTextEditingController = TextEditingController();
  final _idTextEditingController = TextEditingController();
  String userImage = "";

  bool _loading = true;
  late List _output;
  ImagePicker picker = ImagePicker();
  late File _image;

  final databaseRef = FirebaseDatabase.instance.ref();
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          key: scaffoldkey,
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
              "Enter Hostel details below",
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

                GestureDetector(
                  onTap: pickGalleryImage,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 2,
                                blurRadius: 10
                            )
                          ]
                      ),

                      child: Stack(
                        children: [
                          SizedBox(
                            height: 350,
                            width: double.infinity,
                            child: Container(

                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(30),
                                image:  DecorationImage(
                                  image:_loading == true
                                      ?const AssetImage('assets/icons/drop_box.svg')
                                      :FileImage(_image) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          const Positioned(bottom: 15,
                            right: 15,
                            child: Icon(Icons.image_sharp,size: 55.0,color: Colors.black,),)
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameTextEditingController,
                        textInputType: TextInputType.text,
                        data: Icons.location_city,
                        hintText: "Hotel Name",
                        labelText: "Hotel Name",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _locationTextEditingController,
                        textInputType: TextInputType.text,
                        data: Icons.location_on,
                        hintText: "Location",
                        labelText: "Location",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _coordinatesTextEditingController,
                        textInputType: TextInputType.text,
                        data: Icons.location_on_outlined,
                        hintText: "Location latitude",
                        labelText: "Location latitude",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10,),

                      CustomTextField(
                        controller: _coordinatesTextEditingController2,
                        textInputType: TextInputType.text,
                        data: Icons.location_on_outlined,
                        hintText: "Location longitude",
                        labelText: "Location longitude",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10,),

                      CustomTextField(
                        controller: _priceTextEditingController,
                        textInputType: TextInputType.text,
                        data: Icons.attach_money,
                        hintText: "Price per semester",
                        labelText: "Price per semester ",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10,),

                      CustomTextField(
                        controller: _descriptionTextEditingController,
                        textInputType: TextInputType.multiline,
                        data: Icons.lock_outline,
                        hintText: "Hostel Description",
                        labelText: "Hostel Description",
                        isObsecure: false,
                        maxlines: 20,
                        minlines: 10,
                      ),
                    ],
                  ),
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
                            color: Colors.blue[200],
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
                      if (_nameTextEditingController.text.length < 4) {
                        var snackBar = const SnackBar(
                          content: Text( "Name must be at least 4 characters",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Name must be at least 4 characters");
                        return;
                      }
                      if (_locationTextEditingController.text.length < 0) {
                        var snackBar = const SnackBar(
                          content: Text( "Location cant be empty",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // showSnackBar("Please provide a valid email address");
                        return;
                      }

                      if (_coordinatesTextEditingController.text.length < 4) {
                        var snackBar = const SnackBar(
                          content: Text( "coordinates must be at least 4 characters",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Password must be at least 8 characters");
                        return;
                      }

                      if (_coordinatesTextEditingController2.text.length < 4) {
                        var snackBar = const SnackBar(
                          content: Text( "coordinates must be at least 4 characters",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Password must be at least 8 characters");
                        return;
                      }

                      if (_loading == true) {
                        var snackBar = const SnackBar(
                          content: Text( "Select an image",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // showSnackBar("Please provide a valid email address");
                        return;
                      }

                      setState(() {
                        isLoading = true;
                      });
                      String datetime = DateTime.now().toString();

                      final storageRef = storage.ref().child('images').child(_image.path);
                      await storageRef.putFile(_image);

                      final downloadUrl = await storageRef.getDownloadURL();

                      databaseRef.child("hotels").child(_nameTextEditingController.text.trim().
                      replaceAll(RegExp('[^A-Za-z]'), '')
                          + id.replaceAll(RegExp('[^A-Za-z]'), '')).set({
                        'name': _nameTextEditingController.text.trim(),
                        'location': _locationTextEditingController.text.trim(),
                        'latitude': _coordinatesTextEditingController.text.trim(),
                        'longitude': _coordinatesTextEditingController2.text.trim(),
                        'price': _priceTextEditingController.text.trim(),
                        'managerId': id,
                        'description': _descriptionTextEditingController.text.trim(),
                        'date': datetime,
                        'image': downloadUrl,
                      });

                      setState(() {
                        isLoading = false;
                      });

                      var snackBar = const SnackBar(
                        content: Text( "Hostel  created successfully",
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

  pickGalleryImage() async {
    //this function to grab the image from gallery
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
      _loading = false;
    });
  }
}
