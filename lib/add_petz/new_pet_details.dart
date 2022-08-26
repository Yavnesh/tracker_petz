import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracker_kidz/database/myPets.dart';

class AddPet extends StatefulWidget {
  const AddPet({Key? key}) : super(key: key);

  @override
  _AddPetState createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  Color kPrimaryColor = Color(0xFFEA5C2B);
  Color kPrimaryLightColor = Color(0xFFFFC6A9);
  File? _imageFile;
  String dateOfBirth = "";
  DateTime selectedDate = DateTime.now();
  var _gender = [
    'Select Gender',
    'Male',
    'Female',
  ];
  var _type = [
    'Select Type',
    'Cat',
    'Dog',
    'Fish',
  ];

  String? _currentGenderItemSelected = 'Select Gender';
  String? _currentTypeItemSelected = 'Select Type';
  String uploadedPath = "";
  late XFile _image;
  ImagePicker imagePicker = ImagePicker();
  bool _isLoading = false;

  //select image from source
  selectImage() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) =>
                  Column(mainAxisSize: MainAxisSize.min, children: [
                ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.of(context).pop();
                      imagePickerMethod(ImageSource.camera);
                    }),
                ListTile(
                    leading: Icon(Icons.filter),
                    title: Text("Gallery"),
                    onTap: () {
                      Navigator.of(context).pop();
                      imagePickerMethod(ImageSource.gallery);
                    })
              ]),
              onClosing: () {},
            ));
  }

  imagePickerMethod(ImageSource source) async {
    var pic = await imagePicker.pickImage(source: source);
    if (pic != null) {
      setState(() {
        _image = XFile(pic.path);
      });
    }
    uploadImage(); // image upload function
  }

  void uploadImage() {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Images').child(imageFileName);
    final UploadTask uploadTask = storageReference.putFile(File(_image.path));
    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        _isLoading = true;
      });
    });
    uploadTask.then((TaskSnapshot taskSnapshot) async {
      uploadedPath = await uploadTask.snapshot.ref.getDownloadURL();
      print(uploadedPath);

      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {});
  }

  void saveData() {
    MyPetsDatabase.addPet(
        userId: userId,
        pet_name: pet_nameController.text,
        pet_species: pet_speciesController.text,
        pet_description: pet_descriptionController.text,
        pet_weight: pet_weightController.text,
        pet_gender: _currentGenderItemSelected,
        pet_type: _currentTypeItemSelected,
        pet_dob: selectedDate,
        pet_image: uploadedPath,
    );
  }

  final TextEditingController pet_nameController = TextEditingController();
  final TextEditingController pet_speciesController = TextEditingController();
  final TextEditingController pet_descriptionController = TextEditingController();
  final TextEditingController pet_weightController = TextEditingController();

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Add Your Pet",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () async {
                saveData();
                // clearText();
                Fluttertoast.showToast(
                    msg: "Pet added successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM);
                Navigator.pop(context);
              },
              icon: Icon(Icons.save_rounded),
              color: Colors.white)
        ],
      ),
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return Container(
      color: kPrimaryLightColor,
      child: Column(
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              _imageFile != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: Card(
                        elevation: 2,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .3,
                          child: _isLoading == false
                              ? Container(
                                  child: uploadedPath == ""
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cloud_upload_outlined,
                                              color: kPrimaryColor,
                                              size: 100,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Text(
                                                "Upload Image",
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Text(
                                                  "click here for upload image"),
                                            )
                                          ],
                                        )
                                      : Image(
                                          image: NetworkImage(uploadedPath)),
                                )
                              : CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                        ),
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextField(
                  controller: pet_nameController,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.pets_rounded,
                      color: kPrimaryColor,
                    ),
                    hintText: "Name of your pet",
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: pet_speciesController,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.category,
                      color: kPrimaryColor,
                    ),
                    hintText: "Species",
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: pet_descriptionController,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.assignment_outlined,
                      color: kPrimaryColor,
                    ),
                    hintText: "Description",
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: pet_weightController,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.approval,
                      color: kPrimaryColor,
                    ),
                    hintText: "Weight",
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                      items: _gender.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? _newGenderValueSelected) {
                        setState(() {
                          _currentGenderItemSelected = _newGenderValueSelected;
                        });
                      },
                      value: _currentGenderItemSelected),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                      items: _type.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? _newTypeValueSelected) {
                        setState(() {
                          _currentTypeItemSelected = _newTypeValueSelected;
                        });
                      },
                      value: _currentTypeItemSelected),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  leading: InkWell(
                    onTap: (){
                      _selectDate(context);
                    },
                      child: Icon(
                        Icons.calendar_today,
                        color: kPrimaryColor,)
                  ),
                  title: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                ),
              ],
            ),
          ),


          //_buildImagesGrid()
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  Widget buildDropdownButton(List<String> items, String selectedValue) {
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedValue,
      onChanged: (_) {},
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildImagesGrid() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Image.network(
            "",
            height: 80,
          ),
          SizedBox(
            width: 20.0,
          ),
          Image.network(
            "",
            height: 80,
          ),
          SizedBox(
            width: 20.0,
          ),
          Image.network(
            "",
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              onPressed: () {},
              child: Text("Add Pet"),
              color: Color(0xFFEA5C2B),
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
