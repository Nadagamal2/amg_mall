import 'package:amg_store/screens/complaint_done.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

import '../components/app_style.dart';
import '../components/evaluated_Buttom.dart';
import 'bottomNav_screen.dart';
import 'done_screen.dart';

class EditProfileAddressScreen extends StatefulWidget {
  const EditProfileAddressScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileAddressScreen> createState() => _EditProfileAddressScreenState();
}

class _EditProfileAddressScreenState extends State<EditProfileAddressScreen> {
  var formKey = GlobalKey<FormState>();
  final userNameController = new TextEditingController();
  final PhoneController = new TextEditingController();
  final EmailController = new TextEditingController();
  final AddressController = new TextEditingController();
  final userData = GetStorage();
  void Edit (
      // String Name,
      // String email,
        String  title,
      // String PhoneNumber,
      )async{
    var request = http.MultipartRequest('POST', Uri.parse('http://eibtek2-001-site6.atempurl.com/api/Auth/EditeAccount/${userData.read('token')}'));
    request.fields.addAll({
      'id': '${userData.read('token')}',
      'Name': '${userData.read('Name')}',
      'Email':  '${userData.read('Email')}',
      'Title': title,
      'PhoneNumber': '${userData.read('PhoneNumber')}'
    });


    var streamedResponse  = await request.send();
    var response   = await http.Response.fromStream(streamedResponse);
    final result = jsonDecode(response .body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      print(result);
      print(result['token']);
      Map<String, dynamic> payload = Jwt.parseJwt(result['token']);
      userData.write('Name', payload['Name']);
      userData.write('Email', payload['Email']);
      userData.write('Title', payload['Title']);
      userData.write('PhoneNumber', payload['Phone']);
      Get.offAll(DoneScreen());

    }
    else {
      print(response.reasonPhrase);
    }

  }
  // void edit(
  //   String Name,
  //   email,
  //   title,
  //   PhoneNumber,
  // ) async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://eibtek2-001-site6.atempurl.com/api/Auth/EditeAccount/${userData.read('token')}'),
  //         body: jsonEncode({
  //           "Id": '${userData.read('token')}',
  //           "Name": Name,
  //           "Email": email,
  //           "Title": title,
  //           "PhoneNumber": PhoneNumber,
  //         }));
  //     var data = jsonDecode(response.body.toString());
  //     if (response.statusCode == 200) {
  //       print(await response.body);
  //       var log = json.decode(response.body);
  //       print('token${log['token']}');
  //       Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
  //       var tokenId = payload['Id'];
  //       print('tokenId ${tokenId}');
  //
  //       userData.write('Name', payload['Name']);
  //       userData.write('Email', payload['Email']);
  //       userData.write('PhoneNumber', payload['PhoneNumber']);
  //       userData.write('Title', payload['Title']);
  //       userData.write('Name', payload['Name']);
  //
  //        Get.offAll(BottomNavScreen());
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: '${data['message']}',
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       print(await response.body);
  //       print(response.reasonPhrase);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void dispose() {
    userNameController.dispose();
    PhoneController.dispose();
    EmailController.dispose();
    AddressController.dispose();

    //confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Styles.defualtColorWhite,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r)),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15.h, vertical: 28.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              height: 20.h,
                              width: 20.h,
                              decoration: BoxDecoration(
                                color: Styles.defualtColorWhite,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: 19.h,
                              )),
                        ),
                        Text(
                          'تعديل العنوان',
                          style: TextStyle(
                            fontFamily: 'Tajawal2',
                            color: Styles.defualtColor2,
                            fontSize: 17.sp,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              height: 20.h,
                              width: 20.h,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: 19.h,
                                color: Colors.transparent,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20.h),
                        Text('العنوان'),
                        Gap(5.h),
                        SizedBox(
                          height: 40.h,
                          child: TextFormField(

                            cursorColor: Colors.grey.shade400,
                            keyboardType: TextInputType.text,
                            controller: AddressController,
                            //  controller: passwordController,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 3.h, horizontal: 15.h),
                              filled: true,
                              fillColor: Color(0xffF9F9F9),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: .1.r, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: .1.r, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              labelText: "العنوان",
                              hintText: "العنوان",
                              labelStyle: TextStyle(
                                  fontFamily: 'Tajawal7',
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade400),
                              hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                        Gap(50.h),
                        MyElevatedButton(
                          width: double.infinity,
                          onPressed: () {
                            Edit(

                              AddressController.text.toString(),


                            );



                          },
                          borderRadius: BorderRadius.circular(5.r),
                          child: Text( "حفظ",),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Edit(
                        //     //  userNameController.text.toString(),
                        //       // EmailController.text.toString(),
                        //        AddressController.text.toString(),
                        //       // PhoneController.text.toString(),
                        //
                        //     );
                        //   },
                        //   child: Container(
                        //     height: 40.h,
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         begin: Alignment(.8.h, -.7.h),
                        //         end: Alignment(0.8.h, 1.h),
                        //         colors: [
                        //           const Color(0xFFF2DA75),
                        //           const Color(0xFFCDA748),
                        //         ],
                        //         stops: [0.0, 1.0],
                        //       ),
                        //       borderRadius: BorderRadius.circular(5.r),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "حفظ",
                        //         style:
                        //         TextStyle(color: Styles.defualtColorWhite),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
