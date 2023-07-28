// import 'package:fluentui_icons/fluentui_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'dart:ui' as ui;
//
// import '../components/app_style.dart';
// import 'Add_address.dart';
//
// class AddressScreen extends StatefulWidget {
//   const AddressScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }
//
// class _AddressScreenState extends State<AddressScreen> {
//   int _radioSelected = 1;
//   String _radioVal = "";
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: ui.TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Styles.defualtColorWhite,
//         body: SingleChildScrollView(
//           child:  Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.bottomCenter,
//                     height: 100.h,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(25.r),
//                           bottomRight: Radius.circular(25.r)),
//                     ),
//                     child: Padding(
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 15.h, vertical: 28.h),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                                 height: 20.h,
//                                 width: 20.h,
//                                 decoration: BoxDecoration(
//                                   color: Styles.defualtColorWhite,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.shade200,
//                                       spreadRadius: 1,
//                                       blurRadius: 3,
//                                       offset: Offset(
//                                           0, 1), // changes position of shadow
//                                     ),
//                                   ],
//                                   borderRadius: BorderRadius.circular(5.r),
//                                 ),
//                                 child: Icon(
//                                   Icons.keyboard_arrow_right_outlined,
//                                   size: 19.h,
//                                 )),
//                           ),
//                           Text(
//                             'عناويني',
//                             style: TextStyle(
//                               fontFamily: 'Tajawal2',
//                               color: Styles.defualtColor2,
//                               fontSize: 17.sp,
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                                 height: 20.h,
//                                 width: 20.h,
//                                 decoration: BoxDecoration(
//                                   color: Colors.transparent,
//                                   borderRadius: BorderRadius.circular(5.r),
//                                 ),
//                                 child: Icon(
//                                   Icons.keyboard_arrow_right_outlined,
//                                   size: 19.h,
//                                   color: Colors.transparent,
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20.h),
//                           child: SizedBox(
//                             height: 500.h,
//                             //    width: 400.h,
//                             child: ListView.separated(
//                               //|padding: EdgeInsets.all(10.h),
//                                 itemBuilder: (context, index) => Center(
//                                   child: Container(
//                                     height: 90.h,
//                                     width: double.infinity,
//                                     alignment: Alignment.center,
//                                     padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.h),
//                                     decoration: BoxDecoration(
//                                         borderRadius:
//                                         BorderRadius.circular(5.r),
//                                         border: Border.all(
//                                             color: Colors.grey.shade400,
//                                             width: .5)),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                           children: [
//                                             Icon(
//                                               FluentSystemIcons
//                                                   .ic_fluent_location_regular,
//                                               color: Styles.defualtColor,
//                                               size: 20.sp,
//                                             ),
//                                             Gap(10.h),
//                                             Column(
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text('المنزل',style: TextStyle(
//                                                     fontWeight: FontWeight.w600,
//                                                     color: Styles.defualtColor
//                                                 ),),
//                                                 Text('توصيل الي : شارع المعز ,الرياض,السعوديه',style: TextStyle(
//
//                                                 ),),
//                                                 Gap(5.h),
//                                                 Row(
//                                                   children: [
//                                                     CircleAvatar(
//                                                       radius: 5.r,
//                                                       backgroundColor: Colors.green,
//                                                       child: Icon(
//                                                         Icons.check,color: Styles.defualtColorWhite,size: 7.sp,
//                                                       ),
//                                                     ),Gap(5.h),
//                                                     Text('111111111',style: TextStyle(fontSize: 10.h,color: Colors.grey.shade400),)
//                                                   ],
//                                                 )
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                         Radio(
//                                           value: 1,
//                                           autofocus: true,
//                                           groupValue: _radioSelected,
//                                           activeColor: Styles.defualtColor,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               _radioSelected != value!;
//
//
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 separatorBuilder: (context, index) => Gap(20.h),
//                                 itemCount: 1),
//                           ))
//                     ],
//                   )
//                 ],
//               ),
//               InkWell(
//                 onTap: (){
//                   Get.to(AddAddressScreen());
//
//                 },
//                 child: Container(
//                   height: 40.h,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment(.8.h, -.7.h),
//                       end: Alignment(0.8.h, 1.h),
//                       colors: [
//                         const Color(0xFFF2DA75),
//                         const Color(0xFFCDA748),
//                       ],
//
//                       stops: [0.0, 1.0],
//                     ),
//                     borderRadius: BorderRadius.circular(5.r),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "أضف عنوان جديد",
//                       style: TextStyle(
//                           color: Styles.defualtColorWhite
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ),
//       ),
//     );
//   }
// }
