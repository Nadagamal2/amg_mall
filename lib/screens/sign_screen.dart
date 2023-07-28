import 'dart:convert';

import 'package:amg_store/components/app_style.dart';
import 'package:amg_store/screens/signUp_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'dart:ui' as ui;

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../components/checkBox.dart';
import '../components/evaluated_Buttom.dart';
import 'bottomNav_screen.dart';
import 'forgetPass1.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final userNameSignUpController = new TextEditingController();
  final PhoneNumberSignUpController = new TextEditingController();
  final emailSignUpController = new TextEditingController();
  final passwordSignUpController = new TextEditingController();
  final AddressSignUpController = new TextEditingController();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _obscureText1 = true;
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  String? _password;
  bool selected = true;
  var formKey = GlobalKey<FormState>();
  final userData = GetStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? isChecked = false;
  void re(
    String FullName,
    PhoneNumber,
    email,
    password,
    String Address,
    bool agree,
  ) async {
    try {
      var response = await http.post(
          Uri.parse('http://eibtek2-001-site6.atempurl.com/api/Auth/Register'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "name": FullName,
            "phoneNumber": PhoneNumber,
            "title": Address,
            "email": email,
            "password": password,
            "isAgree": agree,
          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print(await response.body);
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        var log = json.decode(response.body);
        print('token${log['token']}');
        Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
        var tokenId = payload['Id'];
        var Email = payload['Email'];
        var PhoneNumbe = payload['PhoneNumbe'];
        var CountId = payload['CountId'];
        print('tokenId ${tokenId}');
        print('read token ${userData.read('token')}');
        print('read token ${userData.read('CountId')}');
        // print('read IsSubscriped ${userData.read('IsSubscriped')}');

        userData.write('IsSubscriped', payload['IsSubscriped']);

        userData.write('isLogged', true);
        userData.write('Email', payload['Email']);
        userData.write('PhoneNumber', payload['PhoneNumber']);
        userData.write('Name', payload['Name']);
        userData.write('token', payload['Id']);
        userData.write('Title', payload['Title']);
        userData.write('email', email);
        userData.write('password', password);
        //userData.write('confirmPassword', confirmPassword);
        //    userData.write('FullName', FullName);

        Get.offAll(BottomNavScreen());
      } else {
        Fluttertoast.showToast(
            msg: '${data['errors']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        print(await response.body);
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  void login(
    String email,
    String password,
  ) async {
    try {
      var response = await http.post(
          Uri.parse('http://eibtek2-001-site6.atempurl.com/api/auth/Login'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "email": email,
            "password": password,
          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print(data);
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        var log = json.decode(response.body);

        print('token${log['token']}');
        Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
        var tokenId = payload['Id'];
        var userName = payload['Name'];
        var Email = payload['Email'];
        var PhoneNumber = payload['PhoneNumber'];

        print('tokenId ${tokenId}');

        // print('read token ${userData.read('token')}');
        // print('read userName ${userData.read('userName')}');
        // print('read Email ${userData.read('Email')}');
        // print('read PhoneNumber ${userData.read('PhoneNumber')}');
        // print('read ImgUrl ${userData.read('ImgUrl')}');
        // print('read IsSubscriped ${userData.read('IsSubscriped')}');

        userData.write('isLogged', true);
        userData.write('token', payload['Id']);
        userData.write('Name', payload['Name']);
        userData.write('Email', payload['Email']);
        userData.write('Title', payload['Title']);
        userData.write('PhoneNumber', payload['PhoneNumber']);
        // userData.write('IsSubscriped', payload['IsSubscriped']);
        //  userData.write('ImgUrl', payload['ImgUrl']);

        userData.write('email', email);
        userData.write('password', password);
        Get.offAll(BottomNavScreen());

        //  return login.fromJson(jsonDecode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Faild");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    PhoneNumberSignUpController.dispose();
    userNameSignUpController.dispose();
    emailSignUpController.dispose();
    passwordSignUpController.dispose();
    AddressSignUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Rectangle 12835.png'),
                    fit: BoxFit.cover)),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(40.h),
                    selected
                        ? Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: Styles.defualtColorWhite,
                              fontSize: 17.sp,
                            ),
                          )
                        : Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              color: Styles.defualtColorWhite,
                              fontSize: 17.sp,
                            ),
                          ),
                    // SvgPicture.asset('assets/WhatsApp_Image_2023-03-16_at_7.25.03_PM-removebg-preview.svg',height: 260.h,width: 260.h,),
                    selected
                        ? Image(
                            height: 260.h,
                            width: 260.h,
                            image: AssetImage('assets/1.png'))
                        : Image(
                            height: 160.h,
                            width: 160.h,
                            image: AssetImage(
                                'assets/WhatsApp_Image_2023-03-16_at_7.25.03_PM-removebg-preview.png')),
                    selected
                        ? Container(
                            height: 363.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Styles.defualtColorWhite,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35.h),
                                    topRight: Radius.circular(35.h))),
                            child: Column(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Styles.defualtColorWhite,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(35.h),
                                      topLeft: Radius.circular(35.h),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selected = false;
                                                // Get.to(SignUpScreen());
                                              });
                                            },
                                            child: Container(
                                              height: 50.h,
                                              width: 164.h,
                                              decoration: BoxDecoration(
                                                color: selected
                                                    ? Styles.defualtColorWhite
                                                    : Color(0xffF9F9F9),
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(35.h),
                                                ),
                                                // boxShadow: [
                                                //   BoxShadow(
                                                //     color: Colors.grey.shade200,
                                                //     spreadRadius: 1,
                                                //     blurRadius: 7,
                                                //     offset: Offset(0, 3), // changes position of shadow
                                                //   ),
                                                // ],
                                              ),
                                              child: Center(
                                                child: Text("إنشاء حساب"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selected = true;
                                              });
                                            },
                                            child: Container(
                                              height: 50.h,
                                              width: 164.h,
                                              decoration: BoxDecoration(
                                                color: selected
                                                    ? Color(0xffF9F9F9)
                                                    : Styles.defualtColorWhite,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(35.h),
                                                ),
                                                // boxShadow: [
                                                //   BoxShadow(
                                                //     color: Colors.grey.shade200,
                                                //     spreadRadius: 1,
                                                //     blurRadius: 7,
                                                //     offset: Offset(0, 3),// changes position of shadow
                                                //   ),
                                                // ],
                                              ),
                                              child: Center(
                                                child: Text("تسجيل دخول"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(60.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.h),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          validator: (String? val) {
                                            if (val!.isEmpty) {
                                              return "من فضلك ادخل البريد الالكتروني";
                                            }
                                          },
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: emailController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10.h,
                                                    horizontal: 15.h),
                                            filled: true,
                                            fillColor: Color(0xffF9F9F9),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .1.r,
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .1.r,
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            labelText: 'البريد الالكتروني',
                                            hintText: 'البريد الالكتروني',
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
                                        Gap(20.h),
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
                                          controller: passwordController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 3.h,
                                                    horizontal: 15.h),
                                            filled: true,
                                            fillColor: Color(0xffF9F9F9),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .1.r,
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            suffixIcon: InkWell(
                                                onTap: _toggle,
                                                child: Icon(
                                                  _obscureText
                                                      ? FluentSystemIcons
                                                          .ic_fluent_eye_show_filled
                                                      : FluentSystemIcons
                                                          .ic_fluent_eye_hide_filled,
                                                  color: Colors.grey.shade400,
                                                )),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .1.r,
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
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
                                        Gap(10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(ForgetPassword1());
                                              },
                                              child: Text(
                                                'هل نسيت كلمة المرور ؟',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Tajawal7',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(20.h),
                                        MyElevatedButton(
                                          width: double.infinity,
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              login(
                                                  emailController.text
                                                      .toString(),
                                                  passwordController.text
                                                      .toString());
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          child: Text('تسجيل دخول'),
                                        ),
                                        // InkWell(
                                        //   onTap: (){
                                        //     if (formKey.currentState!.validate()) {
                                        //       login(emailController.text.toString(),
                                        //           passwordController.text.toString());
                                        //     }
                                        //   },
                                        //   child: Container(
                                        //     height: 40.h,
                                        //     width: double.infinity,
                                        //     decoration: BoxDecoration(
                                        //       gradient: LinearGradient(
                                        //         begin: Alignment(.8.h, -.7.h),
                                        //         end: Alignment(0.8.h, 1.h),
                                        //           colors: [
                                        //             const Color(0xFFF2DA75),
                                        //             const Color(0xFFCDA748),
                                        //           ],
                                        //
                                        //           stops: [0.0, 1.0],
                                        //          ),
                                        //       borderRadius: BorderRadius.circular(5.r),
                                        //     ),
                                        //     child: Center(
                                        //       child: Text(
                                        //           "تسجيل دخول",
                                        //         style: TextStyle(
                                        //           color: Styles.defualtColorWhite
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 463.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Styles.defualtColorWhite,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35.h),
                                    topRight: Radius.circular(35.h))),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selected = false;
                                              });
                                            },
                                            child: Container(
                                              height: 50.h,
                                              width: 164.h,
                                              decoration: BoxDecoration(
                                                color: selected
                                                    ? Styles.defualtColorWhite
                                                    : Color(0xffF8F8F8),
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(35.h),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text("إنشاء حساب"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selected = true;
                                                // Get.offAll(SignScreen());
                                              });
                                            },
                                            child: Container(
                                              height: 50.h,
                                              width: 164.h,
                                              decoration: BoxDecoration(
                                                color: selected
                                                    ? Color(0xffF8F8F8)
                                                    : Styles.defualtColorWhite,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(35.h),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text("تسجيل دخول"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(25.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.h),
                                    child: Form(
                                      key: formKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              validator: (String? val) {
                                                if (val!.isEmpty) {
                                                  return "من فضلك ادخل الاسم";
                                                }
                                              },
                                              cursorColor: Colors.grey.shade400,
                                              keyboardType: TextInputType.name,
                                              controller:
                                                  userNameSignUpController,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10.h,
                                                        horizontal: 15.h),
                                                filled: true,
                                                fillColor: Color(0xffF9F9F9),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                labelText: 'الاسم',
                                                hintText: 'الاسم',
                                                labelStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Tajawal7',
                                                    color:
                                                        Colors.grey.shade400),
                                                hintStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Tajawal7',
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                            ),
                                            Gap(10.h),
                                            TextFormField(
                                              validator: (String? val) {
                                                if (val!.isEmpty) {
                                                  return "من فضلك ادخل الهاتف";
                                                }
                                              },
                                              cursorColor: Colors.grey.shade400,
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  PhoneNumberSignUpController,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10.h,
                                                        horizontal: 15.h),
                                                filled: true,
                                                fillColor: Color(0xffF9F9F9),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                labelText: 'الهاتف',
                                                hintText: 'الهاتف',
                                                labelStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Tajawal7',
                                                    color:
                                                        Colors.grey.shade400),
                                                hintStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Tajawal7',
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                            ),
                                            Gap(10.h),
                                            TextFormField(
                                              validator: (String? val) {
                                                if (val!.isEmpty) {
                                                  return "من فضلك ادخل العنوان";
                                                }
                                              },
                                              cursorColor: Colors.grey.shade400,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              controller:
                                                  AddressSignUpController,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10.h,
                                                        horizontal: 15.h),
                                                filled: true,
                                                fillColor: Color(0xffF9F9F9),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                labelText: 'العنوان',
                                                hintText: 'العنوان',
                                                labelStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Tajawal7',
                                                    color:
                                                        Colors.grey.shade400),
                                                hintStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Tajawal7',
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                            ),
                                            Gap(10.h),
                                            TextFormField(
                                              validator: (String? val) {
                                                if (val!.isEmpty) {
                                                  return "من فضلك ادخل البريد الالكتروني";
                                                }
                                              },
                                              cursorColor: Colors.grey.shade400,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              controller: emailSignUpController,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10.h,
                                                        horizontal: 15.h),
                                                filled: true,
                                                fillColor: Color(0xffF9F9F9),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                labelText: 'البريد الالكتروني',
                                                hintText: 'البريد الالكتروني',
                                                labelStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Tajawal7',
                                                    color:
                                                        Colors.grey.shade400),
                                                hintStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Tajawal7',
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                            ),
                                            Gap(10.h),
                                            TextFormField(
                                              validator: (String? val) {
                                                if (val!.isEmpty) {
                                                  return "من فضلك ادخل كلمة المرور";
                                                }
                                              },
                                              onSaved: (val) => _password = val,
                                              obscureText: _obscureText1,
                                              cursorColor: Colors.grey.shade400,
                                              keyboardType: TextInputType.text,
                                              controller:
                                                  passwordSignUpController,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 3.h,
                                                        horizontal: 15.h),
                                                filled: true,
                                                fillColor: Color(0xffF9F9F9),
                                                suffixIcon: InkWell(
                                                    onTap: _toggle1,
                                                    child: Icon(
                                                      _obscureText1
                                                          ? FluentSystemIcons
                                                              .ic_fluent_eye_show_filled
                                                          : FluentSystemIcons
                                                              .ic_fluent_eye_hide_filled,
                                                      color:
                                                          Colors.grey.shade400,
                                                    )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1.r,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                labelText: "كلمة المرور",
                                                hintText: "كلمة المرور",
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Tajawal7',
                                                    fontSize: 13.sp,
                                                    color:
                                                        Colors.grey.shade400),
                                                hintStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Tajawal7',
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                            ),

                                            //  Row(
                                            //   mainAxisAlignment: MainAxisAlignment.start,
                                            //   crossAxisAlignment: CrossAxisAlignment.center,
                                            //   children: [
                                            //     Checkbox(
                                            //
                                            //       activeColor: Color(0xFFCDA748),
                                            //       side: BorderSide(color: Colors.grey.shade300,width: 1.5),
                                            //       value: isChecked,
                                            //       onChanged:(bool? value) {
                                            //         setState(() {
                                            //           isChecked = value!;
                                            //           userData.write('select', value);
                                            //           print(value);
                                            //         });
                                            //       },),
                                            //     Text(
                                            //       'الموافقة علي',
                                            //       style: TextStyle(
                                            //           fontSize: 12.sp,
                                            //           fontFamily: 'Tajawal7',
                                            //           color: Colors.grey.shade400
                                            //       ),
                                            //     ),
                                            //     Text(
                                            //       ' الشروط والأحكام',
                                            //       style: TextStyle(
                                            //         fontSize: 12.sp,
                                            //         fontFamily: 'Tajawal7',
                                            //         color: Styles.defualtColorBlack,
                                            //       ),
                                            //     )
                                            //   ],
                                            // ),
                                            CheckboxListTile(
                                              value: isChecked,
                                              onChanged: (val) {
                                                setState(() => isChecked = val);
                                                print(isChecked);
                                                userData.write(
                                                    'select', isChecked);
                                              },
                                              // subtitle: !isChecked!
                                              //     ? Text(
                                              //   'من فضلك وافق علي الشروط والأحكام',
                                              //   style: TextStyle(color: Colors.red,fontSize: 12.sp),
                                              // )
                                              //     : null,

                                              title: !isChecked!
                                                  ? Text(
                                                      'الموافقة علي الشروط والأحكام',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  : Text(
                                                      'أوافق علي الشروط والأحكام',
                                                      style: TextStyle(
                                                          fontSize: 12.sp),
                                                    ),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              activeColor: Color(0xFFCDA748),
                                            ),
                                            MyElevatedButton(
                                              width: double.infinity,
                                              onPressed: () {
                                                if (formKey.currentState!
                                                        .validate() &&
                                                    userData.read('select') ==
                                                        true) {
                                                  re(
                                                    userNameSignUpController
                                                        .text
                                                        .toString(),
                                                    PhoneNumberSignUpController
                                                        .text
                                                        .toString(),
                                                    emailSignUpController.text
                                                        .toString(),
                                                    passwordSignUpController
                                                        .text
                                                        .toString(),
                                                    AddressSignUpController.text
                                                        .toString(),
                                                    userData.read('select'),
                                                  );
                                                }
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              child: Text('إنشاء حساب'),
                                            ),

                                            // InkWell(
                                            //   onTap: (){
                                            //     if (formKey.currentState!.validate()&&userData.read('select')==true
                                            //
                                            //     ) {
                                            //       re(
                                            //           userNameSignUpController.text.toString(),
                                            //           PhoneNumberSignUpController.text.toString(),
                                            //           emailSignUpController.text.toString(),
                                            //           passwordSignUpController.text.toString(),AddressSignUpController.text.toString(),userData.read('select'),);
                                            //
                                            //     }
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
                                            //         "إنشاء حساب",
                                            //         style: TextStyle(
                                            //             color: Styles.defualtColorWhite
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
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
            )),
      ),
    );
  }
}
