import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;

import '../components/app_style.dart';
import '../components/evaluated_Buttom.dart';
import 'EditProfileAddressScreen.dart';
import 'EditProfileEmailScreen.dart';
import 'EditProfilePhoneScreen.dart';
import 'edit_profile_data.dart';

class EditProfileData1Screen extends StatelessWidget {
  EditProfileData1Screen({Key? key}) : super(key: key);

  final userData = GetStorage();

  @override
  Widget build(BuildContext context) {
    return   Directionality(
      textDirection:ui.TextDirection.rtl,

      child: Scaffold(
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

                      Text(  'تعديل بياناتي الشخصية', style: TextStyle(
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
                        MyElevatedButton(
                          width: double.infinity,
                          onPressed: () {
                            Get.to(EditProfileNameScreen());



                          },
                          borderRadius: BorderRadius.circular(5.r),
                          child: Text( "تعديل الإسم",),
                        ),


                        Gap(20.h),
                        MyElevatedButton(
                          width: double.infinity,
                          onPressed: () {
                            Get.to(EditProfileEmailScreen());



                          },
                          borderRadius: BorderRadius.circular(5.r),
                          child: Text(  "تعديل البريد الالكتروني",),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     Get.to(EditProfileEmailScreen());
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
                        //         "تعديل البريد الالكتروني",
                        //         style: TextStyle(
                        //             color: Styles.defualtColorWhite
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Gap(20.h),
                        MyElevatedButton(
                          width: double.infinity,
                          onPressed: () {
                            Get.to(EditProfileAddressScreen());



                          },
                          borderRadius: BorderRadius.circular(5.r),
                          child: Text(  "تعديل العنوان",),
                        ),

                        Gap(20.h),
                        MyElevatedButton(
                          width: double.infinity,
                          onPressed: () {
                            Get.to(EditProfilePhoneScreen());



                          },
                          borderRadius: BorderRadius.circular(5.r),
                          child: Text(   "تعديل الهاتف",),
                        ),

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
