// import 'dart:convert';
//
// import 'package:amg_store/components/app_style.dart';
// import 'package:amg_store/screens/sign_screen.dart';
// import 'package:amg_store/screens/verifySignUp_screen.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gap/gap.dart';
// import 'package:get_storage/get_storage.dart';
// import 'dart:ui' as ui;
// import 'package:http/http.dart' as http;
//
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:jwt_decode/jwt_decode.dart';
//
// import 'bottomNav_screen.dart';
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   bool selected=true;
//   bool _obscureText = true;
//   void _toggle() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }
//   String? _password;
//   var formKey = GlobalKey<FormState>();
//   final userNameController = new TextEditingController();
//   final PhoneNumberController = new TextEditingController();
//   final emailController = new TextEditingController();
//   final passwordController = new TextEditingController();
//   // final confirmPasswordController = new TextEditingController();
//   bool? isChecked = false;
//   final userData = GetStorage();
//   void re(
//       String FullName,
//       PhoneNumber,
//       email,
//       password,
//       bool agree,
//
//       ) async {
//     try {
//       var response = await http.post(
//           Uri.parse(
//               'http://eibtek2-001-site6.atempurl.com/api/Auth/Register'),
//           headers: {
//             "Content-Type": "application/json",
//           },
//           body: jsonEncode({
//             "name": FullName,
//             "phoneNumber": PhoneNumber,
//             "title": "string",
//             "email": email,
//             "password": password,
//              "isAgree": agree,
//           }));
//       var data = jsonDecode(response.body.toString());
//       if (response.statusCode == 200) {
//         print(await response.body);
//         var log = json.decode(response.body);
//         print('token${log['token']}');
//         Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
//         var tokenId = payload['Id'];
//         var Email = payload['Email'];
//         var PhoneNumbe = payload['PhoneNumbe'];
//         var CountId = payload['CountId'];
//         print('tokenId ${tokenId}');
//         print('read token ${userData.read('token')}');
//         print('read token ${userData.read('CountId')}');
//        // print('read IsSubscriped ${userData.read('IsSubscriped')}');
//
//         userData.write('IsSubscriped', payload['IsSubscriped']);
//
//         userData.write('isLogged', true);
//         userData.write('Email', payload['Email']);
//         userData.write('PhoneNumber', payload['PhoneNumber']);
//         userData.write('Name', payload['Name']);
//          userData.write('token', payload['Id']);
//         userData.write('email', email);
//         userData.write('password', password);
//          //userData.write('confirmPassword', confirmPassword);
//     //    userData.write('FullName', FullName);
//
//        Get.offAll(BottomNavScreen());
//       } else {
//         Fluttertoast.showToast(
//             msg: '${data['errors']}',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             textColor: Colors.white,
//             fontSize: 16.0);
//         print(await response.body);
//         print(response.reasonPhrase);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//   @override
//   void dispose() {
//     PhoneNumberController.dispose();
//     userNameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//
//     //confirmPasswordController.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection:ui.TextDirection.rtl,
//       child: Scaffold(
//         body: Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('assets/Rectangle 12835.png'),
//                     fit: BoxFit.cover
//                 )
//             ),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Gap(40.h),
//                     Text('إنشاء حساب',style: TextStyle(
//                       color: Styles.defualtColorWhite,
//                       fontSize: 17.sp,
//                     ),),
//                     Image(
//                         height: 160.h,
//                         width: 160.h,
//                         image: AssetImage('assets/WhatsApp_Image_2023-03-16_at_7.25.03_PM-removebg-preview.png')),
//                     Container(
//                       height: 463.h,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           color: Styles.defualtColorWhite,
//                           borderRadius: BorderRadius.only(topLeft: Radius.circular(35.h),topRight:  Radius.circular(35.h))
//                       ),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             IntrinsicHeight(
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//
//                                   Expanded(
//                                     child: InkWell(
//                                       onTap:(){
//                                         setState(() {
//                                           selected=true;
//                                         });
//                                       },
//                                       child: Container(
//                                         height: 50.h,
//                                         width: 164.h,
//                                         decoration: BoxDecoration(
//                                           color:selected?  Color(0xffF8F8F8):Styles.defualtColorWhite,
//                                           borderRadius: BorderRadius.only(topRight: Radius.circular(35.h),),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.grey.shade200,
//                                               spreadRadius: 1,
//                                               blurRadius: 7,
//                                               offset: Offset(0, 3), // changes position of shadow
//                                             ),
//                                           ],
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                               "إنشاء حساب"
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: InkWell(
//                                       onTap:(){
//                                         setState(() {
//                                           selected=false;
//                                           Get.offAll(SignScreen());
//                                         });
//                                       },
//                                       child: Container(
//                                         height: 50.h,
//                                         width: 164.h,
//                                         decoration: BoxDecoration(
//                                           color: selected? Styles.defualtColorWhite: Color(0xffF8F8F8),
//                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(35.h),),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.grey.shade200,
//                                               spreadRadius: 1,
//                                               blurRadius: 7,
//                                               offset: Offset(0, 3),// changes position of shadow
//                                             ),
//                                           ],
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                               "تسجيل دخول"
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Gap(25.h),
//                             Padding(
//                               padding:   EdgeInsets.symmetric(horizontal: 20.h),
//                               child: Form(
//                                 key: formKey,
//                                 child: Column(
//                                   children: [
//                                     TextFormField(
//                                       validator: (String? val) {
//                                         if (val!.isEmpty) {
//                                           return "من فضلك ادخل الاسم";
//                                         }
//                                       },
//                                       cursorColor: Colors.grey.shade400,
//                                       keyboardType: TextInputType.name,
//                                       controller: userNameController,
//                                       decoration: InputDecoration(
//                                         floatingLabelBehavior:
//                                         FloatingLabelBehavior.never,
//                                         contentPadding: EdgeInsets.symmetric(
//                                             vertical: 10.h, horizontal: 15.h),
//                                         filled: true,
//                                         fillColor: Color(0xffF9F9F9),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               width: .1.r, color: Colors.transparent),
//                                           borderRadius: BorderRadius.circular(5.r),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               width: .1.r, color: Colors.transparent),
//                                           borderRadius: BorderRadius.circular(5.r),
//                                         ),
//                                         labelText:  'الاسم' ,
//                                         hintText:  'الاسم' ,
//                                         labelStyle: TextStyle(
//                                             fontSize: 13.sp,
//                                             fontFamily: 'Tajawal7',
//                                             color: Colors.grey.shade400),
//                                         hintStyle: TextStyle(
//                                             fontSize: 13.sp,
//                                             fontFamily: 'Tajawal7',
//                                             color: Colors.grey.shade400),
//                                       ),
//                                     ),
//                                     Gap(20.h),
//                                     TextFormField(
//                                       validator: (String? val) {
//                                         if (val!.isEmpty) {
//                                           return "من فضلك ادخل الهاتف";
//                                         }
//                                       },
//                                       cursorColor: Colors.grey.shade400,
//                                       keyboardType: TextInputType.number,
//                                       controller: PhoneNumberController,
//                                       decoration: InputDecoration(
//                                         floatingLabelBehavior:
//                                         FloatingLabelBehavior.never,
//                                         contentPadding: EdgeInsets.symmetric(
//                                             vertical: 10.h, horizontal: 15.h),
//                                         filled: true,
//                                         fillColor: Color(0xffF9F9F9),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               width: .1.r, color: Colors.transparent),
//                                           borderRadius: BorderRadius.circular(5.r),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               width: .1.r, color: Colors.transparent),
//                                           borderRadius: BorderRadius.circular(5.r),
//                                         ),
//                                         labelText:  'الهاتف' ,
//                                         hintText: 'الهاتف' ,
//                                         labelStyle: TextStyle(
//                                             fontSize: 13.sp,
//                                             fontFamily: 'Tajawal7',
//                                             color: Colors.grey.shade400),
//                                         hintStyle: TextStyle(
//                                             fontSize: 13.sp,
//                                             fontFamily: 'Tajawal7',
//                                             color: Colors.grey.shade400),
//                                       ),
//                                     ),
//                                     Gap(20.h),
//                                     TextFormField(
//                                       validator: (String? val) {
//                                         if (val!.isEmpty) {
//                                           return "من فضلك ادخل البريد الالكتروني";
//                                         }
//                                       },
//                                       cursorColor: Colors.grey.shade400,
//                                       keyboardType: TextInputType.emailAddress,
//                                       controller: emailController,
//                                       decoration: InputDecoration(
//                                         floatingLabelBehavior:
//                                         FloatingLabelBehavior.never,
//                                         contentPadding: EdgeInsets.symmetric(
//                                             vertical: 10.h, horizontal: 15.h),
//                                         filled: true,
//                                         fillColor: Color(0xffF9F9F9),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               width: .1.r, color: Colors.transparent),
//                                           borderRadius: BorderRadius.circular(5.r),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               width: .1.r, color: Colors.transparent),
//                                           borderRadius: BorderRadius.circular(5.r),
//                                         ),
//                                         labelText:  'البريد الالكتروني' ,
//                                         hintText: 'البريد الالكتروني' ,
//                                         labelStyle: TextStyle(
//                                             fontSize: 13.sp,
//                                             fontFamily: 'Tajawal7',
//                                             color: Colors.grey.shade400),
//                                         hintStyle: TextStyle(
//                                             fontSize: 13.sp,
//                                             fontFamily: 'Tajawal7',
//                                             color: Colors.grey.shade400),
//                                       ),
//                                     ),
//                                     Gap(20.h),
//                                     TextFormField(
//                                       validator: (String? val) {
//                                         if (val!.isEmpty) {
//                                           return "من فضلك ادخل كلمة المرور";
//                                         }
//                                       },
//                                       onSaved: (val) => _password = val,
//                                       obscureText: _obscureText,
//                                       cursorColor: Colors.grey.shade400,
//                                       keyboardType: TextInputType.text,
//                                       controller: passwordController,
//                                       decoration: InputDecoration(
//                                         floatingLabelBehavior:
//                                         FloatingLabelBehavior.never,
//                                         contentPadding: EdgeInsets.symmetric(
//                                             vertical: 3.h, horizontal: 15.h),
//                                         filled: true,
//                                         fillColor: Color(0xffF9F9F9),
//                                         suffixIcon: InkWell(
//                                             onTap: _toggle,
//                                             child: Icon(_obscureText ?FluentSystemIcons.ic_fluent_eye_show_filled:FluentSystemIcons.ic_fluent_eye_hide_filled,color: Colors.grey.shade400,)),
//
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               width: .1.r, color: Colors.transparent),
//                                           borderRadius: BorderRadius.circular(5.r),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               width: .1.r, color: Colors.transparent),
//                                           borderRadius: BorderRadius.circular(5.r),
//                                         ),
//                                         labelText: "كلمة المرور",
//                                         hintText: "كلمة المرور",
//                                         labelStyle: TextStyle(
//                                             fontFamily: 'Tajawal7',
//                                             fontSize: 13.sp,
//                                             color: Colors.grey.shade400),
//                                         hintStyle: TextStyle(
//                                             fontSize: 13.sp,
//                                             fontFamily: 'Tajawal7',
//                                             color: Colors.grey.shade400),
//                                       ),
//                                     ),
//
//
//                                     Gap(15.h),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Checkbox(
//
//                                           activeColor: Color(0xFFCDA748),
//                                           side: BorderSide(color: Colors.grey.shade300,width: 1.5),
//                                           value: isChecked,
//                                           onChanged:(bool? value) {
//                                           setState(() {
//                                             isChecked = value!;
//                                             userData.write('select', value);
//                                             print(value);
//                                           });
//                                         },),
//                                         Text(
//                                            'الموافقة علي',
//                                           style: TextStyle(
//                                             fontSize: 12.sp,
//                                             fontFamily: 'Tajawal7',
//                                               color: Colors.grey.shade400
//                                           ),
//                                         ),
//                                         Text(
//                                           ' الشروط والأحكام',
//                                           style: TextStyle(
//                                             fontSize: 12.sp,
//                                             fontFamily: 'Tajawal7',
//                                             color: Styles.defualtColorBlack,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//
//                                     InkWell(
//                                       onTap: (){
//                                         if (formKey.currentState!.validate()&&userData.read('select')==true
//
//                                         ) {
//                                           re(
//                                               userNameController.text.toString(),
//                                               PhoneNumberController.text.toString(),
//                                               emailController.text.toString(),
//                                               passwordController.text.toString(),userData.read('select'));
//
//                                         }
//
//                                       },
//                                       child: Container(
//                                         height: 40.h,
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           gradient: LinearGradient(
//                                             begin: Alignment(.8.h, -.7.h),
//                                             end: Alignment(0.8.h, 1.h),
//                                             colors: [
//                                               const Color(0xFFF2DA75),
//                                               const Color(0xFFCDA748),
//                                             ],
//
//                                             stops: [0.0, 1.0],
//                                           ),
//                                           borderRadius: BorderRadius.circular(5.r),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             "إنشاء حساب",
//                                             style: TextStyle(
//                                                 color: Styles.defualtColorWhite
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                     )
//
//                   ],
//                 ),
//               ),
//             )
//
//         ),
//       ),
//     );
//   }
// }
