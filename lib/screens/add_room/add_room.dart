
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../constants.dart';
import '../add_hostel/components/customTextField.dart';


class AddRoom extends StatefulWidget {
  final String id;
  const AddRoom({super.key, required this.id});

  @override
  State<AddRoom> createState() => _AddRoomState(id: id);
}

class _AddRoomState extends State<AddRoom> {
  final String id;
  _AddRoomState({required this.id});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  final _nameTextEditingController = TextEditingController();
  final _peopleTextEditingController = TextEditingController();
  final _hostelTextEditingController = TextEditingController();
  final _idTextEditingController = TextEditingController();
  final _priceTextEditingController = TextEditingController();

  bool _loading = true;
  bool _loading2 = true;
  bool _loading3 = true;

  ImagePicker picker = ImagePicker();
  late File _image;
  late File _image2;
  late File _image3;

  final databaseRef = FirebaseDatabase.instance.ref();
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool isLoading = false;

  String userImage = "";
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("hostel 1"), value: "hostel 1",),
      DropdownMenuItem(child: Text("hostel 2"), value: "hostel 2",),
      DropdownMenuItem(child: Text("hostel 3"), value: "hostel 3",),
      DropdownMenuItem(child: Text("hostel 4"), value: "hostel 4",),
      DropdownMenuItem(child: Text("hostel 5"), value: "hostel 5",),
      DropdownMenuItem(child: Text("hostel 6"), value: "hostel 6",),
    ];
    return menuItems;
  }
  String selectedValue = "hostel 1 ";

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
              "Enter Room details below",
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

                const SizedBox(height: 25),

                GestureDetector(
                  onTap: pickGalleryImage2,
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
                                  image:_loading2 == true
                                      ?const AssetImage('assets/icons/drop_box.svg')
                                      :FileImage(_image2) as ImageProvider,
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

                const SizedBox(height: 25),

                GestureDetector(
                  onTap: pickGalleryImage3,
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
                                  image:_loading3 == true
                                      ?const AssetImage('assets/icons/drop_box.svg')
                                      :FileImage(_image3) as ImageProvider,
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
                        data: Icons.local_print_shop,
                        hintText: "Room Name",
                        labelText: "Room Name",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _peopleTextEditingController,
                        textInputType: TextInputType.number,
                        data: Icons.people,
                        hintText: "People in a room",
                        labelText: "People in a room",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _priceTextEditingController,
                        textInputType: TextInputType.number,
                        data: Icons.monetization_on,
                        hintText: "Price per semester",
                        labelText: "Price per semester",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10,),

                      CustomTextField(
                        controller: _hostelTextEditingController,
                        textInputType: TextInputType.text,
                        data: Icons.lock_outline,
                        hintText: "Hostel Name",
                        labelText: "Hostel ",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10,),

                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 16),
                      //   child: DropdownButtonFormField(
                      //       items: dropdownItems,
                      //       decoration: InputDecoration(
                      //         enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(color: secondaryColor, width: 2),
                      //           borderRadius: BorderRadius.circular(20)
                      //         ),
                      //         border: OutlineInputBorder(
                      //           borderSide: BorderSide(color: secondaryColor),
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         filled: true,
                      //         fillColor: secondaryColor,
                      //       ),
                      //       validator: (value) => value == null?"select a hostel":null,
                      //       dropdownColor: secondaryColor,
                      //       value: selectedValue,
                      //       onChanged: (String? newValue){
                      //         setState(() {
                      //           selectedValue = newValue!;
                      //         });
                      //       }
                      //   ),
                      // ),


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
                      backgroundColor: MaterialStatePropertyAll(Color(0xFF4FBE9F)),
                    ),

                    onPressed: () async {
                      //-------------Internet Connectivity--------------------//


                      //----------------checking textfield--------------------//
                      if (_nameTextEditingController.text.length < 1) {
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
                      if (_peopleTextEditingController.text.isEmpty) {
                        var snackBar = const SnackBar(
                          content: Text( "people cant be empty",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // showSnackBar("Please provide a valid email address");
                        return;
                      }

                      if (_hostelTextEditingController.text.isEmpty) {
                        var snackBar = const SnackBar(
                          content: Text( "Hostel cant be empty",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Password must be at least 8 characters");
                        return;
                      }

                      if (_loading == true){
                        var snackBar = const SnackBar(
                          content: Text( "Select at least three images",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Confirm Password is not match");
                        return;
                      }

                      if (_loading2 == true){
                        var snackBar = const SnackBar(
                          content: Text( "Select at least three images",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Confirm Password is not match");
                        return;
                      }
                      if (_loading3 == true){
                        var snackBar = const SnackBar(
                          content: Text( "Select at least three images",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Confirm Password is not match");
                        return;
                      }

                      setState(() {
                        isLoading = true;
                      });

                      final storageRef = storage.ref().child('images').child(_image.path);
                      await storageRef.putFile(_image);
                      final storageRef2 = storage.ref().child('images').child(_image2.path);
                      await storageRef2.putFile(_image2);
                      final storageRef3 = storage.ref().child('images').child(_image3.path);
                      await storageRef3.putFile(_image3);

                      final downloadUrl = await storageRef.getDownloadURL();
                      final downloadUrl2 = await storageRef2.getDownloadURL();
                      final downloadUrl3 = await storageRef3.getDownloadURL();

                      databaseRef.child("rooms").child(_nameTextEditingController.text.trim().
                      replaceAll(RegExp('[^A-Za-z]'), '')
                          + _hostelTextEditingController
                              .text.trim().replaceAll(RegExp('[^A-Za-z0-9]'), '')).set({
                        'name': _nameTextEditingController.text.trim(),
                        'people': _peopleTextEditingController.text.trim(),
                        'hostel': _hostelTextEditingController.text.trim(),
                        'price': _priceTextEditingController.text.trim(),
                        'managerId': id,
                        'image1': downloadUrl,
                        'image2': downloadUrl2,
                        'image3': downloadUrl3,
                      });

                      setState(() {
                        isLoading = false;
                      });

                      var snackBar = const SnackBar(
                        content: Text( "Room added successfully",
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
    ]
      ),
            )
      )
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


  pickGalleryImage2() async {
    //this function to grab the image from gallery
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image2 = File(image.path);
      _loading2 = false;
    });
  }


  pickGalleryImage3() async {
    //this function to grab the image from gallery
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image3 = File(image.path);
      _loading3 = false;
    });
  }
}
