import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:ui' as ui;

import '../components/app_style.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({Key? key}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  int _radioSelected = 1;
  String _radioVal = "";
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

                      Text( 'الدفع', style: TextStyle(
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

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "من فضلك ادخل كلمة المرور";
                        }
                      },
                      cursorColor: Colors.grey.shade400,
                      keyboardType: TextInputType.text,
                     // controller: passwordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior:
                        FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 10.h),
                        filled: true,
                        fillColor: Colors.grey.shade100,

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
                        labelText: "ادخل المبلغ المراد شحنه",
                        hintText: "ادخل المبلغ المراد شحنه",
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
                    Container(
                      height: 35.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                splashRadius: 10.r,
                                value: 1,
                                autofocus: true,
                                groupValue: _radioSelected,
                                activeColor: Styles.defualtColor,
                                onChanged: (value) {
                                  setState(() {
                                    _radioSelected = value!;


                                  });
                                },
                              ),
                              Text('مدي'),

                            ],

                          ),
                          Image(image: AssetImage('assets/2560px-Mada_Logo.svg.png'),height: 10.h,fit: BoxFit.cover,)
                        ],
                      ),
                    ),
                    Gap(10.h),
                    Container(
                      height: 35.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                splashRadius: 10.r,
                                value: 2,
                                autofocus: true,
                                groupValue: _radioSelected,
                                activeColor: Styles.defualtColor,
                                onChanged: (value) {
                                  setState(() {
                                    _radioSelected = value!;


                                  });
                                },
                              ),
                              Text('فيزا'),

                            ],

                          ),
                          Image(image: AssetImage('assets/Visa-Card-Logo-PNG-Photo-Clip-Art-Image.png',),height: 10.h,fit: BoxFit.cover,)
                          // Icon(FluentSystemIcons.ic_fluent_)
                        ],
                      ),
                    ),
                    Gap(10.h),
                    Container(
                      height: 35.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                splashRadius: 10.r,
                                value: 3,
                                autofocus: true,
                                groupValue: _radioSelected,
                                activeColor: Styles.defualtColor,
                                onChanged: (value) {
                                  setState(() {
                                    _radioSelected = value!;


                                  });
                                },
                              ),
                              Text('ماستر كارد'),

                            ],

                          ),
                          Image(image: AssetImage('assets/Mastercard-logo.svg.png',),height: 22.h,fit: BoxFit.cover,)

                        ],
                      ),
                    ),
                    Gap(30.h),
                    TextFormField(
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "من فضلك ادخل كلمة المرور";
                        }
                      },
                      cursorColor: Colors.grey.shade400,
                      keyboardType: TextInputType.text,
                      // controller: passwordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior:
                        FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 10.h),
                        filled: true,
                        fillColor: Colors.grey.shade100,

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
                        labelText: "رقم البطاقة",
                        hintText: "رقم البطاقة",
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
                    Gap(10.h),
                    TextFormField(
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "من فضلك ادخل كلمة المرور";
                        }
                      },
                      cursorColor: Colors.grey.shade400,
                      keyboardType: TextInputType.text,
                      // controller: passwordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior:
                        FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 10.h),
                        filled: true,
                        fillColor: Colors.grey.shade100,

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
                        labelText: "الاسم علي البطاقة",
                        hintText:  "الاسم علي البطاقة",
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
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.h,
                          width: 130.h,
                          child: TextFormField(
                            // validator: (String? val) {
                            //   if (val!.isEmpty) {
                            //     return "من فضلك ادخل كلمة المرور";
                            //   }
                            // },
                            cursorColor: Colors.grey.shade400,
                            keyboardType: TextInputType.text,
                            //  controller: passwordController,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 3.h, horizontal: 15.h),
                              filled: true,
                              fillColor: Colors.grey.shade100,
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
                              labelText: "تاريخ الانتهاء",
                              hintText:"تاريخ الانتهاء",
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
                        SizedBox(height: 40.h,
                          width: 130.h,
                          child: TextFormField(
                            // validator: (String? val) {
                            //   if (val!.isEmpty) {
                            //     return "من فضلك ادخل كلمة المرور";
                            //   }
                            // },
                            cursorColor: Colors.grey.shade400,
                            keyboardType: TextInputType.text,
                            //  controller: passwordController,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 3.h, horizontal: 15.h),
                              filled: true,
                              fillColor: Colors.grey.shade100,
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
                              labelText: "CCV",
                              hintText:"CCV",
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
                      ],
                    ),
                    Gap(150.h),
                    InkWell(
                      onTap: (){

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
                            "ادفع الان",
                            style: TextStyle(
                                color: Styles.defualtColorWhite
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              )

            ],
          ),
        ),

      ),
    );
  }
}
