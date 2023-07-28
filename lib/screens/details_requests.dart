import 'package:amg_store/screens/privacy_policy.dart';
import 'package:amg_store/screens/profile_data_screen.dart';
import 'package:amg_store/screens/sign_screen.dart';
import 'package:amg_store/screens/tems_And_condition.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:ui' as ui;

import '../components/app_style.dart';
import 'Suggestions_and_complaints.dart';
import 'about_app.dart';
import 'change_password.dart';

class RequestsDetailsScreen extends StatelessWidget {
  const RequestsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                //  alignment: Alignment.center,
                children: [
                  Container(
                    // alignment: Alignment.bottomCenter,
                    height: 140.h,
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
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(55.r),
                          bottomRight: Radius.circular(55.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.h, vertical: 28.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                height: 22.h,
                                width: 22.h,
                                decoration: BoxDecoration(
                                  color: Styles.defualtColorWhite,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 19.h,
                                )),
                          ),
                          Text(
                            'تفاصيل الطلب',
                            style: TextStyle(
                              fontFamily: 'Tajawal2',
                              color: Styles.defualtColorWhite,
                              fontSize: 18.sp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                height: 22.h,
                                width: 22.h,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Icon(Icons.keyboard_arrow_right_outlined,
                                    size: 19.h, color: Colors.transparent)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 100.h, right: 15.h, left: 15.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            height: 580.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Styles.defualtColorWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.1),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'طلب رقم - 111111111111',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'تم حجزه يوم 2/11/2022 5:30م',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 20.h,
                                    thickness: .5,
                                    color: Colors.grey.shade300,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'عنوان التوصيل',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Gap(5.h),
                                        Row(
                                          children: [
                                            Icon(
                                              FluentSystemIcons
                                                  .ic_fluent_location_regular,
                                              size: 16.sp,
                                              color: Styles.defualtColor,
                                            ),
                                            Gap(3.h),
                                            Text(
                                              'منزلي-الرياض -السعودية',
                                              style: TextStyle(
                                                fontSize: 11.h,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 20.h,
                                    thickness: .5,
                                    color: Colors.grey.shade300,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'رقم الهاتف',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ), Gap(5.h),
                                        Row(
                                          children: [
                                            Icon(
                                              FluentSystemIcons
                                                  .ic_fluent_phone_regular,
                                              size: 16.sp,
                                              color: Styles.defualtColor,
                                            ),
                                            Gap(3.h),
                                            Text(
                                              '111111111',
                                              style: TextStyle(
                                                fontSize: 11.h,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 20.h,
                                    thickness: .5,
                                    color: Colors.grey.shade300,
                                  ),
                                  Padding(
                                    padding:   EdgeInsets.symmetric(horizontal: 10.h),                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/Secure data-pana.png'),
                                              height: 80.h,
                                              width: 80.h,
                                            ),
                                            Gap(10.h),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 100.h,
                                                  child: Text(
                                                    'اسم المنتج المن تجالمنتج المنتج المنتجا لمنت جالمنتج',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Gap(10.h),
                                                Text(
                                                  'تم التوصيل',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(10.h),
                                  Padding(
                                    padding:   EdgeInsets.symmetric(horizontal: 10.h),                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 20.h,
                                          width: 75.h,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          child: Center(
                                            child: Text(
                                              'قيم المتجر',
                                              style: TextStyle(
                                                fontSize: 11.h,
                                                color: Styles.defualtColor

                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 20.h,
                                          width: 75.h,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                              BorderRadius.circular(5.r)),
                                          child: Center(
                                            child: Text(
                                              'قيم المتجر',
                                              style: TextStyle(
                                                  fontSize: 11.h,
                                                  color: Styles.defualtColor

                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 20.h,
                                          width: 75.h,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                              BorderRadius.circular(5.r)),
                                          child: Center(
                                            child: Text(
                                              'قيم المتجر',
                                              style: TextStyle(
                                                  fontSize: 11.h,
                                                  color: Styles.defualtColor

                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 20.h,
                                    thickness: .5,
                                    color: Colors.grey.shade300,
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10.h),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'طريقة الدفع',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ), Gap(5.h),
                                        Row(
                                          children: [
                                            Icon(
                                              FluentSystemIcons
                                                  .ic_fluent_payment_regular,
                                              size: 16.sp,
                                              color: Styles.defualtColor,
                                            ),
                                            Gap(3.h),
                                            Text(
                                              'دفع عن طريق باي بال',
                                              style: TextStyle(
                                                fontSize: 11.h,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 20.h,
                                    thickness: .5,
                                    color: Colors.grey.shade300,
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10.h),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'قيمة الدفع',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ), Gap(5.h),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Text(
                                              'التكلفة الجزئية',
                                              style: TextStyle(
                                                fontSize: 11.h,
                                              ),
                                            ),   
                                            Text(
                                              '777 رس',
                                              style: TextStyle(
                                                fontSize: 11.h,fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(10.h),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Text(
                                              'تكلفة التوصيل',
                                              style: TextStyle(
                                                fontSize: 11.h,
                                              ),
                                            ),
                                            Text(
                                              '777 رس',
                                              style: TextStyle(
                                                  fontSize: 11.h,fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(10.h),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Text(
                                              'الضريبة المضافة',
                                              style: TextStyle(
                                                fontSize: 11.h,
                                              ),
                                            ),
                                            Text(
                                              '777 رس',
                                              style: TextStyle(
                                                  fontSize: 11.h,fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(10.h),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Text(
                                              'التكلفة الكلية',
                                              style: TextStyle(
                                                fontSize: 11.h,
                                              ),
                                            ),
                                            Text(
                                              '777 رس',
                                              style: TextStyle(
                                                  fontSize: 11.h,fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildProfileStack1({
  required String text,
  required IconData icon,
  required Function() onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.h),
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Styles.defualtColorWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(5.h),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon),
              Text(
                text,
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ),
    );
