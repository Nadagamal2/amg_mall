import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../components/app_style.dart';
import '../components/evaluated_Buttom.dart';
import 'editPassSuccessful_screen.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final userData =GetStorage();
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }
  String? _password;
  String? _password1;
  String? _password2;

  final OldPaasswordController=TextEditingController();
  final NewPasswordController=TextEditingController();
  final ConfirmNewPasswordController=TextEditingController();
  void changePassword({
    required dynamic OldPaassword,
    required dynamic NewPassword,
    required dynamic ConfirmNewPassword,
  }) async {
    var response = await http.post(
        Uri.parse('http://eibtek2-001-site6.atempurl.com/api/Auth/EditePassword/${userData.read('token')}'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "id": '${userData.read('token')}',
          "oldPaassword": OldPaassword,
          "newPassword": NewPassword,
          "confirmNewPassword": ConfirmNewPassword
        }
        ));
    if (response.statusCode == 200) {
      var data=jsonDecode(response.body.toString());

      print('done');
      userData.write("isChanged", true);
      userData.write('NewPassword', NewPassword);
      userData.write('ConfirmNewPassword', ConfirmNewPassword);
      Get.to(EditPasswordSuccess1());
      print( data);

    } else {
      print('fail');
    }


  }
  @override
  void dispose() {
    OldPaasswordController.dispose();
    NewPasswordController.dispose();
    ConfirmNewPasswordController.dispose();


    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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

                      Text( 'تغير كلمة المرور', style: TextStyle(
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
                        Text(
                          'يجب ان يكون الرقم السري الخاص بك مكون من 8 حروف وأرقام ورمز واحد علي الأقل',
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600

                          ),),
                         Gap(30.h),
                        TextFormField(
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "من فضلك ادخل كلمة المرور";
                            }
                          },
                          onSaved: (val) => _password = val,
                          obscureText: _obscureText,
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.text,
                          controller: OldPaasswordController,
                         // controller: passwordController,
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 15.h),
                            filled: true,
                            fillColor: Color(0xffF9F9F9),
                            suffixIcon: InkWell(
                                onTap: _toggle,
                                child: Icon(_obscureText ?FluentSystemIcons.ic_fluent_eye_show_filled:FluentSystemIcons.ic_fluent_eye_hide_filled,color: Colors.grey.shade400,)),
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
                            labelText: "أدخل كلمة المرور الحالية",
                            hintText: "أدخل كلمة المرور الحالية",
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
                          onSaved: (val) => _password1 = val,
                          obscureText: _obscureText1,
                          controller: NewPasswordController,
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.text,
                          // controller: passwordController,
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 15.h),
                            filled: true,
                            fillColor: Color(0xffF9F9F9),
                            suffixIcon: InkWell(
                                onTap: _toggle1,
                                child: Icon(_obscureText1 ?FluentSystemIcons.ic_fluent_eye_show_filled:FluentSystemIcons.ic_fluent_eye_hide_filled,color: Colors.grey.shade400,)),
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
                            labelText: "كلمة المرور الجديدة",
                            hintText: "كلمة المرور الجديدة",
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
                          onSaved: (val) => _password2 = val,
                          obscureText: _obscureText2,
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.text,
                          controller: ConfirmNewPasswordController,
                          // controller: passwordController,
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 15.h),
                            filled: true,
                            fillColor: Color(0xffF9F9F9),
                            suffixIcon: InkWell(
                                onTap: _toggle2,
                                child: Icon(_obscureText2 ?FluentSystemIcons.ic_fluent_eye_show_filled:FluentSystemIcons.ic_fluent_eye_hide_filled,color: Colors.grey.shade400,)),
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
                            labelText: "تأكيد كلمة المرور الجديدة",
                            hintText: "تأكيد كلمة المرور الجديدة",
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


                        Gap(100.h),
                        MyElevatedButton(
                          width: double.infinity,
                          onPressed: () {
                            changePassword(OldPaassword: OldPaasswordController.text.toString(), NewPassword: NewPasswordController.text.toString(), ConfirmNewPassword: ConfirmNewPasswordController.text.toString());



                          },
                          borderRadius: BorderRadius.circular(5.r),
                          child: Text('تغير كلمة المرور'),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     changePassword(OldPaassword: OldPaasswordController.text.toString(), NewPassword: NewPasswordController.text.toString(), ConfirmNewPassword: ConfirmNewPasswordController.text.toString());
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
                        //         "تغير كلمة المرور",
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
