import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:kolazz_book/Models/Type_of_photography_model.dart';
import 'package:kolazz_book/Models/get_portfolio_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/colors.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:kolazz_book/Views/edit_profile/edit_profile.dart';
import 'package:kolazz_book/Views/portfolio/portfolio_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/edit_profile_controller.dart';
import 'my_portfolio.dart';

class AddPortfolioScreen extends StatefulWidget {
  final Portfolio? data;
  const AddPortfolioScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AddPortfolioScreen> createState() => _AddPortfolioScreenState();
}

class _AddPortfolioScreenState extends State<AddPortfolioScreen> {


  bool _isChecked = false;
  bool _isChecked1 = false;
  TextEditingController aboutController = TextEditingController();
  TextEditingController equipmentController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  List<Categories> typeofPhotographyEvent = [];

  getPhotographerType() async {
    print("working");
    var uri = Uri.parse(getPhotographerApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    // request.fields['type_id'] = "1";
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    // collectionModal = AllCateModel.fromJson(userData);
    typeofPhotographyEvent = TypeofPhotography.fromJson(userData).categories!;
    // print(
    //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
    print("this is photographer $typeofPhotographyEvent");
  }

  var photoGrapherType;
  File? coverImage;
  String? userId, coverPhoto;


  void requestPermission(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  getImageGallery(ImgSource.Gallery, context ,i);
                },
                child:  Container(
                  child: ListTile(
                      title:  Text("Gallery"),
                      leading: Icon(
                        Icons.image,
                        color: AppColors.primary,
                      )),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  getImage(ImgSource.Camera, context, i);
                },
                child: Container(
                  child: ListTile(
                      title:  Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: AppColors.primary,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );

    ///

  }

  Future getImage(ImgSource source, BuildContext context, int i) async {


    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      imageQuality: 1,
      maxHeight: 400,
      maxWidth: 2400,
      cameraIcon: const Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    if (i == 1) {
      setState(() {
        coverImage = File(image.path);
      });
      Navigator.pop(context);
    }

  }
  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.original
      ],
    );
    if (i == 1) {
      coverImage = File(croppedFile!.path);
    }
    setState(() {
    });
    Navigator.pop(context);
  }
  Future getImageGallery(ImgSource source, BuildContext context, int i) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: const Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    if (i == 1) {
      setState(() {
        coverImage = File(image.path);
      });
      Navigator.pop(context);
    }

  }


  updatePortfolioData(String isFreelancer) async {
    print("working here!!");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    // setBusy(true);

    var headers = {'Cookie': 'ci_session=cf2fmpq7vue0kthvj5s046uv4m2j5r11'};

    Map<String, String> body = {};
    body[RequestKeys.userId] = userId!;
    body['about'] = aboutController.text.trim();
    body['country_visited'] = countryController.text.trim();
    body['equipments'] = equipmentController.text.trim();
    body['category_id'] = photoGrapherType.toString();
    body['is_freelancer'] = isFreelancer;

    var request = http.MultipartRequest(
        'POST', Uri.parse(addPortfolioApi.toString()));
    request.fields.addAll(body);


    coverImage == null ? null : request.files.add(
        await http.MultipartFile.fromPath(
            'cover_image', coverImage!.path.toString()));



    print("ok++++++++======>>>>${request.fields} ${request.files}");
    request.headers.addAll(headers);

    var response = await request.send();


    print("this is response =========>>>> ${response.statusCode}");

    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var data = json.decode(str.toString());

      // if (jsonResponse.status == "success") {

        Fluttertoast.showToast(msg: data['message'] ?? '');
        Navigator.pop(context, true);
        setState(() {
        });
        // Get.to(DashBoard());

      // } else {
      //   ShowMessage.showSnackBar('Server Res', jsonResponse.message ?? '');
      //
      // }
    } else {
      Fluttertoast.showToast(msg: "Error during communication : server error");
      print(response.reasonPhrase);
    }
  }

  getUserData(){
    if(widget.data != null) {
      setState(() {
        aboutController.text = widget.data!.about.toString();
        equipmentController.text = widget.data!.equipments.toString();
        countryController.text = widget.data!.countryVisited.toString();
        coverPhoto = widget.data!.coverImage.toString();
        _isChecked = true;
      });
      if (widget.data!.categoryId != null || widget.data!.categoryId != '') {
        setState(() {
          photoGrapherType = widget.data!.categoryId.toString();
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotographerType();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff575656),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                color: const Color(0xff303030),
                child: GetBuilder(
                    init: EditProfileController(),
                    builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.AppbtnColor,
                              )),
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(EditProfileScreen());
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfilePage()));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius:
                                        BorderRadius.circular(40)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: controller.profilePic == null ||
                                            controller.profilePic == ''
                                            ? ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(40),
                                            child: controller.imageFile !=
                                                null
                                                ? Image.file(
                                              controller.imageFile!,
                                              fit: BoxFit.cover,
                                              height: 40,
                                              width: 40,
                                            )
                                                : Image.asset(
                                              "assets/images/loginlogo.png",
                                              fit: BoxFit.fill,
                                              height: 40,
                                              width: 40,
                                            ))
                                            : ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(40),
                                            child:
                                            // rcImage != null ?
                                            Image.network(
                                              controller.profilePic
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              height: 40,
                                              width: 40,
                                            ))),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    controller.profiledata != null ||
                                        controller.profiledata == ""
                                        ? Text(
                                      "${controller.profiledata!.fname} ${controller.profiledata!.lname} ",
                                      style: const TextStyle(
                                          color: AppColors.AppbtnColor,
                                          fontSize: 15),
                                    )
                                        : const CircularProgressIndicator(),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddPortfolioScreen()));
                                        },
                                        child: const Text(
                                          "My Portfolio",
                                          style: TextStyle(
                                              color: AppColors.whit,
                                              decoration:
                                              TextDecoration.underline),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only( top: 10),
                  child: Text(
                    "My Portfolio",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Checkbox(
                        value: _isChecked,
                        activeColor: AppColors.teamcard2,
                        checkColor: AppColors.AppbtnColor,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                    ),
                  ),
                 const  Text(
                    "Freelancer",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),

              Visibility(
                visible: _isChecked,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 10, bottom: 5),
                        child: Text(
                          "Category",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width/1.0,
                        child: Card(
                          color: Color(0xff6D6A6A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                dropdownColor: AppColors.cardclr,
                                // Initial Value
                                value: photoGrapherType,
                                isExpanded: true,
                                hint: const Text(
                                  "Type Of Photography",
                                  style: TextStyle(
                                      color: AppColors.textclr),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.textclr,
                                ),
                                // Array list of items
                                items: typeofPhotographyEvent
                                    .map((Categories items) {
                                  return DropdownMenuItem(
                                    value: items.resId,
                                    child: Text(
                                      items.resName.toString(),
                                      style: const TextStyle(
                                          color: AppColors.textclr),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (newValue) {
                                  photoGrapherType =
                                      newValue.toString();

                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 10, bottom: 5),
                        child: Text(
                          "About",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/1.0,
                        height: 100,
                        child: Card(
                          color: Color(0xff6D6A6A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            maxLines: 4,
                            controller: aboutController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                hintText: 'About',
                                hintStyle: TextStyle(color: AppColors.whit),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10, top: 15)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 10, bottom: 5),
                        child: Text(
                          "Equipments/Camera Kit Details",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width/1.0,
                        height: 100,
                        child: Card(
                          color: Color(0xff6D6A6A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: equipmentController,
                            keyboardType: TextInputType.name,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                hintText: 'Equipments/Camera Kit Details',
                                hintStyle: TextStyle(color: AppColors.whit),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10, top: 25)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 10, bottom: 5),
                        child: Text(
                          "How Many Country You Visited?",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width/1.0,
                        height: 80,
                        child: Card(
                          color: Color(0xff6D6A6A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: countryController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                hintText: 'Enter Country Names',
                                hintStyle: TextStyle(color: AppColors.whit),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 10, bottom: 5),
                        child: Text(
                          "Upload Cover Photo",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          requestPermission(context, 1);
                        },
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width/1.0,
                          child: Card(
                              color: const Color(0xff6D6A6A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              child:
                              coverPhoto == null || coverPhoto == '' ?
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: coverImage != null
                                      ? Image.file(coverImage!, fit: BoxFit.cover, height: 90,width: 95,)
                                      : const Center(child: Text("Upload Cover Photo",style: TextStyle(fontSize: 18,
                                  color: AppColors.whit),))
                                // Image.asset("assets/images/loginlogo.png",fit: BoxFit.fill,height: 90,width: 95,)
                              )
                            : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:
                            // rcImage != null ?
                            Image.network(coverPhoto.toString(), fit: BoxFit.cover, height: 90,width: 95,)
                            )

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10),
              //   child: Row(
              //     children: [
              //       Checkbox(
              //         activeColor: AppColors.teamcard2,
              //         checkColor: AppColors.AppbtnColor,
              //         value: _isChecked1,
              //         onChanged: (bool? value) {
              //           setState(() {
              //             _isChecked1 = value!;
              //           });
              //         },
              //       ),
              //      const Text(
              //         "Who can search you with your free dates",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                   if(_isChecked){
                     if(aboutController.text.isEmpty || equipmentController.text.isEmpty || countryController.text.isEmpty ||  photoGrapherType == null
                     ) {
                       Fluttertoast.showToast(msg: "Please select all required field!");
                     }else{
                       updatePortfolioData('1');
                     }
                   }else{
                     updatePortfolioData('0');
                   }

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => MyPortfolioScreen(
                    //           data: ,
                    //         )));
                  },
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Update",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
