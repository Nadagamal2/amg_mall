// import 'package:fluentui_icons/fluentui_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'dart:ui' as ui;
//
// import '../components/app_style.dart';
//
// class AddAddressScreen extends StatefulWidget {
//   const AddAddressScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddAddressScreen> createState() => _AddAddressScreenState();
// }
//
// class _AddAddressScreenState extends State<AddAddressScreen> {
//   int _radioSelected = 1;
//   String _radioVal = "";
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: ui.TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Styles.defualtColorWhite,
//         body: SingleChildScrollView(
//             child:  Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.bottomCenter,
//                       height: 100.h,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(25.r),
//                             bottomRight: Radius.circular(25.r)),
//                       ),
//                       child: Padding(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 15.h, vertical: 28.h),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Get.back();
//                               },
//                               child: Container(
//                                   height: 20.h,
//                                   width: 20.h,
//                                   decoration: BoxDecoration(
//                                     color: Styles.defualtColorWhite,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.shade200,
//                                         spreadRadius: 1,
//                                         blurRadius: 3,
//                                         offset: Offset(
//                                             0, 1), // changes position of shadow
//                                       ),
//                                     ],
//                                     borderRadius: BorderRadius.circular(5.r),
//                                   ),
//                                   child: Icon(
//                                     Icons.keyboard_arrow_right_outlined,
//                                     size: 19.h,
//                                   )),
//                             ),
//                             Text(
//                               'إضافة عنوان جديد',
//                               style: TextStyle(
//                                 fontFamily: 'Tajawal2',
//                                 color: Styles.defualtColor2,
//                                 fontSize: 17.sp,
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.back();
//                               },
//                               child: Container(
//                                   height: 20.h,
//                                   width: 20.h,
//                                   decoration: BoxDecoration(
//                                     color: Colors.transparent,
//                                     borderRadius: BorderRadius.circular(5.r),
//                                   ),
//                                   child: Icon(
//                                     Icons.keyboard_arrow_right_outlined,
//                                     size: 19.h,
//                                     color: Colors.transparent,
//                                   )),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.h),
//                             child: SizedBox(
//                               height: 500.h,
//                               //    width: 400.h,
//                               child: Column(
//                                 children: [
//                                   TextFormField(
//                                     validator: (String? val) {
//                                       if (val!.isEmpty) {
//                                         return " ";
//                                       }
//                                     },
//                                     cursorColor: Colors.grey.shade400,
//                                     keyboardType: TextInputType.text,
//                                    // controller: passwordController,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.never,
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 3.h, horizontal: 15.h),
//                                       filled: true,
//                                       fillColor: Color(0xffF9F9F9),
//
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: .1.r, color: Colors.transparent),
//                                         borderRadius: BorderRadius.circular(5.r),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: .1.r, color: Colors.transparent),
//                                         borderRadius: BorderRadius.circular(5.r),
//                                       ),
//                                       labelText: "اسم العنوان",
//                                       hintText:  "اسم العنوان",
//                                       labelStyle: TextStyle(
//                                           fontFamily: 'Tajawal7',
//                                           fontSize: 13.sp,
//                                           color: Colors.grey.shade400),
//                                       hintStyle: TextStyle(
//                                           fontSize: 13.sp,
//                                           fontFamily: 'Tajawal7',
//                                           color: Colors.grey.shade400),
//                                     ),
//                                   ),
//                                   Gap(15.h),
//                                   TextFormField(
//                                     validator: (String? val) {
//                                       if (val!.isEmpty) {
//                                         return " ";
//                                       }
//                                     },
//                                     cursorColor: Colors.grey.shade400,
//                                     keyboardType: TextInputType.number,
//                                    // controller: passwordController,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.never,
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 3.h, horizontal: 15.h),
//                                       filled: true,
//                                       fillColor: Color(0xffF9F9F9),
//
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: .1.r, color: Colors.transparent),
//                                         borderRadius: BorderRadius.circular(5.r),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: .1.r, color: Colors.transparent),
//                                         borderRadius: BorderRadius.circular(5.r),
//                                       ),
//                                       labelText: "الهاتف",
//                                       hintText:   "الهاتف",
//                                       labelStyle: TextStyle(
//                                           fontFamily: 'Tajawal7',
//                                           fontSize: 13.sp,
//                                           color: Colors.grey.shade400),
//                                       hintStyle: TextStyle(
//                                           fontSize: 13.sp,
//                                           fontFamily: 'Tajawal7',
//                                           color: Colors.grey.shade400),
//                                     ),
//                                   ),
//                                   Gap(15.h),
//                                   TextFormField(
//                                     validator: (String? val) {
//                                       if (val!.isEmpty) {
//                                         return " ";
//                                       }
//                                     },
//                                     cursorColor: Colors.grey.shade400,
//                                     keyboardType: TextInputType.number,
//                                    // controller: passwordController,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.never,
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 3.h, horizontal: 15.h),
//                                       filled: true,
//                                       fillColor: Color(0xffF9F9F9),
//
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: .1.r, color: Colors.transparent),
//                                         borderRadius: BorderRadius.circular(5.r),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: .1.r, color: Colors.transparent),
//                                         borderRadius: BorderRadius.circular(5.r),
//                                       ),
//                                       labelText: "رقم المنزل",
//                                       hintText:  "رقم المنزل",
//                                       labelStyle: TextStyle(
//                                           fontFamily: 'Tajawal7',
//                                           fontSize: 13.sp,
//                                           color: Colors.grey.shade400),
//                                       hintStyle: TextStyle(
//                                           fontSize: 13.sp,
//                                           fontFamily: 'Tajawal7',
//                                           color: Colors.grey.shade400),
//                                     ),
//                                   ),
//                                   Gap(15.h),
//                                   TextFormField(
//                                     validator: (String? val) {
//                                       if (val!.isEmpty) {
//                                         return " ";
//                                       }
//                                     },
//                                     cursorColor: Colors.grey.shade400,
//                                     keyboardType: TextInputType.text,
//                                     // controller: passwordController,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.never,
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 3.h, horizontal: 15.h),
//                                       filled: true,
//                                       fillColor: Color(0xffF9F9F9),
//
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: .1.r, color: Colors.transparent),
//                                         borderRadius: BorderRadius.circular(5.r),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: .1.r, color: Colors.transparent),
//                                         borderRadius: BorderRadius.circular(5.r),
//                                       ),
//                                       labelText: "اسم الشارع او علامة مميزه",
//                                       hintText:   "اسم الشارع او علامة مميزه",
//                                       labelStyle: TextStyle(
//                                           fontFamily: 'Tajawal7',
//                                           fontSize: 13.sp,
//                                           color: Colors.grey.shade400),
//                                       hintStyle: TextStyle(
//                                           fontSize: 13.sp,
//                                           fontFamily: 'Tajawal7',
//                                           color: Colors.grey.shade400),
//                                     ),
//                                   ),
//                                   Gap(15.h),
//                                 ],
//                               )
//                             ))
//                       ],
//                     )
//                   ],
//                 ),
//                 InkWell(
//                   onTap: (){
//
//                   },
//                   child: Container(
//                     height: 40.h,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment(.8.h, -.7.h),
//                         end: Alignment(0.8.h, 1.h),
//                         colors: [
//                           const Color(0xFFF2DA75),
//                           const Color(0xFFCDA748),
//                         ],
//
//                         stops: [0.0, 1.0],
//                       ),
//                       borderRadius: BorderRadius.circular(5.r),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "أضف العنوان",
//                         style: TextStyle(
//                             color: Styles.defualtColorWhite
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//         ),
//       ),
//     );
//   }
// }
