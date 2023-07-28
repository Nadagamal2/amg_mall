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
import 'edit_profile1_screen.dart';
import 'edit_profile_data.dart';

class ProfileDataScreen extends StatefulWidget {
  const ProfileDataScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {
  final userData = GetStorage();
  SearchScreen() {

    _selectvalueCity2 = _itemsCity2[0];

  }

  final _itemsCity2 = ['المنطقه',  'جدة',  'الرياض', 'مكة'];

  String? _selectvalueCity2 = 'المنطقه';
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

                      Text( 'بياناتي الشخصية', style: TextStyle(
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
                         // Row(
                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         //   crossAxisAlignment: CrossAxisAlignment.center,
                         //   children: [
                         //     Column(
                         //       mainAxisAlignment: MainAxisAlignment.start,
                         //       crossAxisAlignment: CrossAxisAlignment.start,
                         //       children: [
                         //         Text('الاسم الأول'),
                         //         Container(
                         //           height: 40.h,
                         //           width: 135.h,
                         //           padding: EdgeInsets.only(left: 10.h,right: 10.h),
                         //           decoration: BoxDecoration(
                         //             color: Styles.defualtColorWhite,
                         //             borderRadius: BorderRadius.circular(5.r),
                         //             boxShadow: [
                         //               BoxShadow(
                         //                 color: Colors.grey.shade200,
                         //                 spreadRadius: 2,
                         //                 blurRadius: 7,
                         //                 offset: Offset(0, 3), // changes position of shadow
                         //               ),
                         //             ],
                         //           ),
                         //           child: Center(
                         //             child: Text(
                         //               '${userData.read(key)}'
                         //             ),
                         //           ),
                         //         )
                         //       ],
                         //     ),
                         //     Column(
                         //       mainAxisAlignment: MainAxisAlignment.start,
                         //       crossAxisAlignment: CrossAxisAlignment.start,
                         //       children: [
                         //         Text('اسم العائلة'),
                         //         Container(
                         //           height: 40.h,
                         //           width: 135.h,
                         //           padding: EdgeInsets.only(left: 10.h,right: 10.h),
                         //           decoration: BoxDecoration(
                         //             color: Styles.defualtColorWhite,
                         //             borderRadius: BorderRadius.circular(5.r),
                         //             boxShadow: [
                         //               BoxShadow(
                         //                 color: Colors.grey.shade200,
                         //                 spreadRadius: 2,
                         //                 blurRadius: 7,
                         //                 offset: Offset(0, 3), // changes position of shadow
                         //               ),
                         //             ],
                         //           ),
                         //           child: Center(
                         //             child: Text(
                         //                 'name'
                         //             ),
                         //           ),
                         //
                         //         )
                         //       ],
                         //     ),
                         //   ],
                         // ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('الإسم'),
                             Container(
                                 height: 40.h,
                                 width:double.infinity,
                                 padding: EdgeInsets.only(left: 10.h,right: 10.h),
                                 decoration: BoxDecoration(
                                   color: Styles.defualtColorWhite,
                                   borderRadius: BorderRadius.circular(5.r),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.grey.shade200,
                                       spreadRadius: 2,
                                       blurRadius: 7,
                                       offset: Offset(0, 3), // changes position of shadow
                                     ),
                                   ],
                                 ),
                                 child:  Row(
                                   children: [
                                     Icon(FluentSystemIcons.ic_fluent_person_regular,color: Styles.defualtColor,),
                                     Gap(10.h),
                                     Text(
                                         '${userData.read('Name')}'
                                     ),

                                   ],
                                 )
                             )
                           ],
                         ),
                         Gap(20.h),

                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('الهاتف'),
                             Container(
                               height: 40.h,
                               width:double.infinity,
                               padding: EdgeInsets.only(left: 10.h,right: 10.h),
                               decoration: BoxDecoration(
                                 color: Styles.defualtColorWhite,
                                 borderRadius: BorderRadius.circular(5.r),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey.shade200,
                                     spreadRadius: 2,
                                     blurRadius: 7,
                                     offset: Offset(0, 3), // changes position of shadow
                                   ),
                                 ],
                               ),
                               child:  Row(
                                 children: [
                                   Icon(FluentSystemIcons.ic_fluent_phone_regular,color: Styles.defualtColor,),
                                   Gap(10.h),
                                   Text(
                                     '${userData.read('PhoneNumber')}'
                                 ),

                                 ],
                               )
                             )
                           ],
                         ),
                         Gap(20.h),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('البريد الإلكتروني'),
                             Container(
                               height: 40.h,
                               width:double.infinity,
                               padding: EdgeInsets.only(left: 10.h,right: 10.h),
                               decoration: BoxDecoration(
                                 color: Styles.defualtColorWhite,
                                 borderRadius: BorderRadius.circular(5.r),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey.shade200,
                                     spreadRadius: 2,
                                     blurRadius: 7,
                                     offset: Offset(0, 3), // changes position of shadow
                                   ),
                                 ],
                               ),
                               child:  Row(
                                 children: [
                                   Icon(FluentSystemIcons.ic_fluent_mail_regular,color: Styles.defualtColor,),
                                   Gap(10.h),
                                   Text(
                                       '${userData.read('Email')}'
                                 ),

                                 ],
                               )
                             )
                           ],
                         ),
                         Gap(20.h),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('العنوان'),
                             Container(
                                 height: 40.h,
                                 width:double.infinity,
                                 padding: EdgeInsets.only(left: 10.h,right: 10.h),
                                 decoration: BoxDecoration(
                                   color: Styles.defualtColorWhite,
                                   borderRadius: BorderRadius.circular(5.r),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.grey.shade200,
                                       spreadRadius: 2,
                                       blurRadius: 7,
                                       offset: Offset(0, 3), // changes position of shadow
                                     ),
                                   ],
                                 ),
                                 child:  Row(
                                   children: [
                                     Icon(FluentSystemIcons.ic_fluent_location_regular,color: Styles.defualtColor,),
                                     Gap(10.h),
                                     Text(
                                         '${userData.read('Title')}'
                                     ),

                                   ],
                                 )
                             )
                             // Container(
                             //   height: 40.h,
                             //   width:double.infinity,
                             //   padding: EdgeInsets.only(left: 10.h,right: 10.h),
                             //   decoration: BoxDecoration(
                             //     color: Styles.defualtColorWhite,
                             //     borderRadius: BorderRadius.circular(5.r),
                             //     boxShadow: [
                             //       BoxShadow(
                             //         color: Colors.grey.shade200,
                             //         spreadRadius: 2,
                             //         blurRadius: 7,
                             //         offset: Offset(0, 3), // changes position of shadow
                             //       ),
                             //     ],
                             //   ),
                             //   child:  Row(
                             //     children: [
                             //       Icon(FluentSystemIcons.ic_fluent_location_regular,color: Styles.defualtColor,),
                             //       Gap(10.h),
                             //       Text(
                             //           'منزلي- الرياض-السعوديه'
                             //     ),
                             //
                             //     ],
                             //   )
                             // )
                             // Container(
                             //   decoration: BoxDecoration(
                             //     color: Styles.defualtColorWhite,
                             //     borderRadius: BorderRadius.circular(5.r),
                             //     boxShadow: [
                             //       BoxShadow(
                             //         color: Colors.grey.shade200,
                             //         spreadRadius: 2,
                             //         blurRadius: 7,
                             //         offset: Offset(0, 3), // changes position of shadow
                             //       ),
                             //     ],
                             //   ),
                             //
                             //   child: DropdownButtonFormField(
                             //     hint: Text('choose'),
                             //     value: _selectvalueCity2,
                             //     items:_itemsCity2.map((e) {
                             //       return DropdownMenuItem<String>(
                             //
                             //           value:e  ,
                             //           child: Text(e)
                             //
                             //       );
                             //     }).toList(),
                             //     onChanged:(val){
                             //       setState(() {
                             //         _selectvalueCity2=val!;
                             //
                             //
                             //
                             //       });
                             //     },
                             //
                             //
                             //     icon: Align(
                             //       alignment: Alignment.center,
                             //       child: Icon(
                             //         Icons.keyboard_arrow_down_rounded,
                             //         color: Colors.transparent,
                             //       ),
                             //     ),
                             //     decoration: InputDecoration(
                             //       fillColor: Styles.defualtColorWhite,
                             //       filled: true,
                             //       floatingLabelBehavior:
                             //       FloatingLabelBehavior.never,
                             //       focusedBorder: OutlineInputBorder(
                             //         borderSide:
                             //         BorderSide(color: Colors.transparent),
                             //         borderRadius: BorderRadius.circular(8.r),
                             //       ),
                             //       border: OutlineInputBorder(),
                             //       isDense: true,
                             //       contentPadding:
                             //       EdgeInsets.symmetric(horizontal: 15.h,vertical: 8.5.h),
                             //       //EdgeInsets.fromLTRB(24.h, 10.h, 20.h, 0.h),
                             //       enabledBorder: OutlineInputBorder(
                             //         borderSide:
                             //         BorderSide(color: Colors.transparent),
                             //         borderRadius: BorderRadius.circular(8.r),
                             //       ),
                             //
                             //     ),
                             //   ),
                             // ),
                           ],
                         ),
                        Gap(190.h),
                         MyElevatedButton(
                           width: double.infinity,
                           onPressed: () {
                             Get.to(EditProfileData1Screen());



                           },
                           borderRadius: BorderRadius.circular(5.r),
                           child: Text('تعديل'),
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
