import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:ui' as ui;
import '../components/app_style.dart';
import 'bottomNav_screen.dart';
import 'editPass1.dart';
TextEditingController? CodeController;
class VerifySignScreen extends StatelessWidget {
  const VerifySignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
                      Gap(90.h),
                      Text( 'تفعيل الحساب', style: TextStyle(
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
                      Text('ادخل كود التأكيد المرسل \n علي رقم الهاتف \n 0111111111',
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          fontSize: 16.sp,
                        ),),
                      Gap(10.h),

                      Padding(
                        padding: EdgeInsets.all(15.h),

                        child: Form(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                verifyTextField(context,
                                  onChanged:(value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },

                                  width: 48,inputList:
                                  [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,

                                  ],
                                ),
                                verifyTextField(context,
                                  onChanged:(value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },width: 48,inputList:
                                  [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],),
                                verifyTextField(context,
                                  onChanged:(value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },width: 48,inputList:
                                  [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],),
                                verifyTextField(context,
                                  onChanged:(value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },width: 48,inputList:
                                  [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],),


                              ],
                            )),
                      ),
                      Gap(50.h),
                      InkWell(
                        onTap: (){
                          Get.offAll(BottomNavScreen());
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
                      Gap(20.h),
                      InkWell(
                        onTap: (){

                        },
                        child: Text('لم أستلم الكود (3:00) ',
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey.shade400
                          ),),
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
Widget verifyTextField(context,{

  required  double width,

  List<TextInputFormatter>? inputList,
  void Function(String)? onChanged,
}) => SizedBox(
  height: 45,
  width: width,
  child: TextFormField(
      controller: CodeController,
      cursorColor: Colors.grey.shade400,
      cursorHeight: 30,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey.shade100,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color:Colors.transparent),
          borderRadius: BorderRadius.circular(6),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 3),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color:Colors.transparent),
          borderRadius: BorderRadius.circular(6),
        ),

      ),
      onChanged: onChanged,
      //     (value) {
      //   if (value.length == 1) {
      //     FocusScope.of(context).nextFocus();
      //   }
      // },
      style: Theme.of(context).textTheme.headline6,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters:  inputList
  ),
);