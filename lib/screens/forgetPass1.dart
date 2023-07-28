import 'dart:convert';

import 'package:amg_store/screens/veriy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../components/app_style.dart';
import 'checkemail.dart';

class ForgetPassword1 extends StatefulWidget {
  const ForgetPassword1({Key? key}) : super(key: key);

  @override
  State<ForgetPassword1> createState() => _ForgetPassword1State();
}

class _ForgetPassword1State extends State<ForgetPassword1> {
  final emailController = TextEditingController();
  final userData =GetStorage();
  void forget(String email)async{
    try{
      var request = http.Request('POST', Uri.parse('http://eibtek2-001-site6.atempurl.com/api/auth/ForgetPassword/${email}'));


      var streamedResponse  = await request.send();
      var response   = await http.Response.fromStream(streamedResponse);
      final result = jsonDecode(response .body) as Map<String, dynamic>;
      print(result['isSuccess']);
      if (result['isSuccess']==true) {
        print(result);
        Get.to(CheckEmail());

      }else {
        print('response.reasonPhrase');
      }


    }catch(e){
      print(e.toString());
    }
  }
  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Styles.defualtColorWhite,
        body: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r),bottomRight: Radius.circular(25.r)),
              ),
              child: Padding(
                padding:   EdgeInsets.symmetric(horizontal: 15.h,vertical: 28.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
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
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5.r),

                          ),
                          child:  Icon(Icons.keyboard_arrow_right_outlined,size: 19.h,)
                      ),
                    ),
                    Gap(75.h),
                    Text( 'نسيت كلمة المرور', style: TextStyle(
                      fontFamily: 'Tajawal2',
                      color: Styles.defualtColor2,
                      fontSize: 18.sp,
                    ),),

                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 100.h,left: 15.h,right: 15.h),
              child: Center(
                child: Column(
                  children: [
                    Text('ادخل بريد إلكتروني تستطيع تلقي الرسائل عليه',style: TextStyle(
                      fontSize: 16.sp,
                    ),),
                    Gap(25.h),

                    TextFormField(
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "من فضلك ادخل البريد الالكتروني";
                        }
                      },
                      cursorColor: Colors.grey.shade400,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        floatingLabelBehavior:
                        FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 15.h),
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
                        labelText:  'البريد الالكتروني' ,
                        hintText: 'البريد الالكتروني' ,
                        labelStyle: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'Tajawal7',
                            color: Colors.grey.shade400),
                        hintStyle: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'Tajawal7',
                            color: Colors.grey.shade400),
                      ),
                    ),
                    Gap(50.h),
                    InkWell(
                      onTap: (){
                        forget(emailController.text.toString());
                      },
                      child: Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(.8.h, -.7.h),
                            end: Alignment(0.8.h, 1.h),
                            colors: [
                              const Color(0xFFF2DA75),
                              const Color(0xFFCDA748),
                            ],

                            stops: [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                          child: Text(
                            "التالي",
                            style: TextStyle(
                                color: Styles.defualtColorWhite
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
