import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../components/app_style.dart';
import '../components/evaluated_Buttom.dart';
import 'complaint_done.dart';

class SuggestionsAndComplaintsScreen extends StatefulWidget {
  const SuggestionsAndComplaintsScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionsAndComplaintsScreen> createState() => _SuggestionsAndComplaintsScreenState();
}

class _SuggestionsAndComplaintsScreenState extends State<SuggestionsAndComplaintsScreen> {
  final compliantController=new TextEditingController();
  void compliant(String  compliant)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://eibtek2-001-site6.atempurl.com/api/Complaints_SuggestionsApi/Create'));
    request.body = json.encode({
      "id": 0,
      "details": compliant
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.to(ComplaintDone());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  void dispose(){
    compliantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height=350.h;
    return   Directionality(

      textDirection:ui.TextDirection.rtl,

      child: Scaffold(
        backgroundColor: Styles.defualtColorWhite,
        body: SingleChildScrollView(
          child: Column(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      Text( 'الاقتراحات والشكاوي', style: TextStyle(
                        fontFamily: 'Tajawal2',
                        color: Styles.defualtColor2,
                        fontSize: 17.sp,
                      ),),
                      InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                            height: 20.h,
                            width: 20.h,

                            decoration: BoxDecoration(
                              color: Colors.transparent,

                              borderRadius: BorderRadius.circular(5.r),

                            ),
                            child:  Icon(Icons.keyboard_arrow_right_outlined,size: 19.h, color: Colors.transparent,)
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20.h),
                        // SizedBox(height: 40.h,
                        //
                        //   child: TextFormField(
                        //     // validator: (String? val) {
                        //     //   if (val!.isEmpty) {
                        //     //     return "من فضلك ادخل كلمة المرور";
                        //     //   }
                        //     // },
                        //     cursorColor: Colors.grey.shade400,
                        //     keyboardType: TextInputType.number,
                        //     //  controller: passwordController,
                        //     decoration: InputDecoration(
                        //       floatingLabelBehavior:
                        //       FloatingLabelBehavior.never,
                        //       contentPadding: EdgeInsets.symmetric(
                        //           vertical: 3.h, horizontal: 15.h),
                        //       filled: true,
                        //       fillColor: Color(0xffF9F9F9),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             width: .1.r, color: Colors.transparent),
                        //         borderRadius: BorderRadius.circular(5.r),
                        //       ),
                        //       border: OutlineInputBorder(),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             width: .1.r, color: Colors.transparent),
                        //         borderRadius: BorderRadius.circular(5.r),
                        //       ),
                        //       labelText: "الاسم",
                        //       hintText: "الاسم",
                        //       labelStyle: TextStyle(
                        //           fontFamily: 'Tajawal7',
                        //           fontSize: 13.sp,
                        //           color: Colors.grey.shade400),
                        //       hintStyle: TextStyle(
                        //           fontSize: 13.sp,
                        //           fontFamily: 'Tajawal7',
                        //           color: Colors.grey.shade400),
                        //     ),
                        //   ),
                        // ),
                        // Gap(20.h),
                        // SizedBox(height: 40.h,
                        //
                        //   child: TextFormField(
                        //     // validator: (String? val) {
                        //     //   if (val!.isEmpty) {
                        //     //     return "من فضلك ادخل كلمة المرور";
                        //     //   }
                        //     // },
                        //     cursorColor: Colors.grey.shade400,
                        //     keyboardType: TextInputType.number,
                        //     //  controller: passwordController,
                        //     decoration: InputDecoration(
                        //       floatingLabelBehavior:
                        //       FloatingLabelBehavior.never,
                        //       contentPadding: EdgeInsets.symmetric(
                        //           vertical: 3.h, horizontal: 15.h),
                        //       filled: true,
                        //       fillColor: Color(0xffF9F9F9),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             width: .1.r, color: Colors.transparent),
                        //         borderRadius: BorderRadius.circular(5.r),
                        //       ),
                        //       border: OutlineInputBorder(),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             width: .1.r, color: Colors.transparent),
                        //         borderRadius: BorderRadius.circular(5.r),
                        //       ),
                        //       labelText: "البريد الإلكتروني",
                        //       hintText:  "البريد الإلكتروني",
                        //       labelStyle: TextStyle(
                        //           fontFamily: 'Tajawal7',
                        //           fontSize: 13.sp,
                        //           color: Colors.grey.shade400),
                        //       hintStyle: TextStyle(
                        //           fontSize: 13.sp,
                        //           fontFamily: 'Tajawal7',
                        //           color: Colors.grey.shade400),
                        //     ),
                        //   ),
                        // ),
                        // Gap(20.h),
                        SizedBox(
                          height: height,
                          child: TextFormField(
                            cursorColor: Colors.grey.shade400,
                            maxLines: height ~/20.h,

                            controller: compliantController,
                            keyboardType: TextInputType.text,

                            decoration: InputDecoration(
                              floatingLabelAlignment: FloatingLabelAlignment.start,
                              alignLabelWithHint: true,
                              helperMaxLines: 10,
                              filled: true,
                              fillColor: Color(0xffF9F9F9),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              contentPadding:
                              EdgeInsets.fromLTRB(10.h, 2.h, 10.h, 10.h),
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
                              labelText: "اكتب شكوتك هنا بوضوح حتي نستطيع مساعدتك بشكل أفضل",
                              hintText: "اكتب شكوتك هنا بوضوح حتي نستطيع مساعدتك بشكل أفضل",
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
                        Gap(30.h),
                        MyElevatedButton(
                          width: double.infinity,
                          onPressed: () {
                            compliant(compliantController.text.toString());



                          },
                          borderRadius: BorderRadius.circular(5.r),
                          child: Text('ارسال'),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     compliant(compliantController.text.toString());
                        //
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
                        //
                        //         stops: [0.0, 1.0],
                        //       ),
                        //       borderRadius: BorderRadius.circular(5.r),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "ارسال",
                        //         style: TextStyle(
                        //             color: Styles.defualtColorWhite
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),

      ),
    );
  }
}
