import 'package:amg_store/screens/veriy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:ui' as ui;
import '../components/app_style.dart';
import 'editPassSuccessful_screen.dart';

class EditPassword1 extends StatelessWidget {
  const EditPassword1({Key? key}) : super(key: key);

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
              padding:  EdgeInsets.only(top: 40.h,left: 15.h,right: 15.h),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 45.h),
                      child: Text(
                        'من فضلك قم بكتابة كلمة مرور جديدة مع التأكد من عدم علم اي شخص بها ',
                        textAlign: TextAlign.center,

                        style: TextStyle(
                        fontSize: 16.sp,

                      ),),
                    ),
                    Gap(60.h),

                    TextFormField(
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "من فضلك ادخل كلمة المرور";
                        }
                      },
                      cursorColor: Colors.grey.shade400,
                      keyboardType: TextInputType.text,
                      //controller: passwordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior:
                        FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 15.h),
                        filled: true,
                        fillColor: Color(0xffF9F9F9),
                        suffixIcon: Icon(Icons.remove_red_eye_rounded,color: Colors.grey.shade400,),

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
                        labelText: "كلمة المرور",
                        hintText: "كلمة المرور",
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
                    Gap(20.h),
                    TextFormField(
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "من فضلك ادخل كلمة المرور مره اخري";
                        }
                      },
                      cursorColor: Colors.grey.shade400,
                      keyboardType: TextInputType.text,
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
                        labelText: "تأكيد كلمة المرور",
                        hintText: "تأكيد كلمة المرور",
                        suffixIcon: Icon(Icons.remove_red_eye_rounded,color: Colors.grey.shade400,),
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
                    Gap(50.h),
                    InkWell(
                      onTap: (){
                        Get.to(EditPasswordSuccess1());
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
