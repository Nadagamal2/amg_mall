import 'package:amg_store/screens/privacy_policy.dart';
import 'package:amg_store/screens/profile_data_screen.dart';
import 'package:amg_store/screens/qrcode_screen.dart';
import 'package:amg_store/screens/rate_us.dart';
import 'package:amg_store/screens/sign_screen.dart';
import 'package:amg_store/screens/tems_And_condition.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

import '../components/app_style.dart';
import 'Favorite_Screen.dart';
import 'Requests_screen.dart';
import 'Suggestions_and_complaints.dart';
import 'about_app.dart';
import 'address_screen.dart';
import 'change_password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userData = GetStorage();
  //   shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55.r),bottomRight:Radius.circular(55.r) )
  //         ),
  //         toolbarHeight: 110.h,
  //         // leading: Builder(
  //         //   builder: (context)=>Padding(
  //         //     padding: EdgeInsets.only(right: 15.h,top: 43.h,bottom: 43.h,left: 15.h ),
  //         //     child:   InkWell(
  //         //       onTap: () {
  //         //         Get.back();
  //         //       },
  //         //       child: Container(
  //         //           height: 22.h,
  //         //           width: 22.h,
  //         //           decoration: BoxDecoration(
  //         //             color: Styles.defualtColorWhite,
  //         //             borderRadius: BorderRadius.circular(5.r),
  //         //           ),
  //         //           child: Icon(
  //         //
  //         //             Icons.keyboard_arrow_right_outlined,
  //         //             size: 19.h,
  //         //             color: Colors.black,
  //         //           )),
  //         //     ),
  //         //   ),
  //         // ),
  //         title:  Stack(
  //          // alignment: Alignment.bottomCenter,
  //           children: [
  //             Column(
  //               children: [
  //                 Text(
  //                   'حسابي',
  //                   style: TextStyle(
  //                     fontFamily: 'Tajawal2',
  //                     color: Styles.defualtColorWhite,
  //                     fontSize: 18.sp,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                   EdgeInsets.only(  right: 40.h, left: 40.h,top: 20.h),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       buildProfileStack1(
  //                           text: 'الطلبات',
  //                           icon: CupertinoIcons.cube,
  //                           onTap: () {
  //                             Get.to(RequestsScreen());
  //                           }),
  //                       buildProfileStack1(
  //                           text: 'المفضلة',
  //                           icon: FluentSystemIcons.ic_fluent_heart_regular,
  //                           onTap: () {
  //                             Get.to(FavoriteScreen());
  //                           }),
  //                       buildProfileStack1(
  //                           text: 'البروفايل',
  //                           icon: FluentSystemIcons.ic_fluent_person_regular,
  //                           onTap: () {
  //                             Get.to((ProfileDataScreen()));
  //                           }),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             )
  //
  //           ],
  //         ),
  //         centerTitle: true,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 150.h ),
      child:     Stack(
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
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Icon(Icons.keyboard_arrow_right_outlined,
                            size: 19.h, color: Colors.transparent)),
                  ),
                  Text(
                    'حسابي',
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
            EdgeInsets.only(top: 110.h, right: 40.h, left: 40.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildProfileStack1(
                    text: 'الطلبات',
                    icon: CupertinoIcons.cube,
                    onTap: () {
                      // Get.to(RequestsScreen());
                    }),
                buildProfileStack1(
                    text: 'المفضلة',
                    icon: FluentSystemIcons.ic_fluent_heart_regular,
                    onTap: () {
                      Get.to(FavoriteScreen());
                    }),
                buildProfileStack1(
                    text: 'البروفايل',
                    icon: FluentSystemIcons.ic_fluent_person_regular,
                    onTap: () {
                      Get.to((ProfileDataScreen()));
                    }),
              ],
            ),
          )
        ],
      ),



      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Gap(30.h),
              SingleChildScrollView(
                child: Column(
                  children: [
                    // buildProfileItem(
                    //     text: 'عناويني',
                    //     icon: FluentSystemIcons.ic_fluent_location_regular,
                    //     onTap: () {Get.to(AddressScreen());}),
                    // Gap(20.h),
                    buildProfileItem(
                        text: 'عن التطبيق',
                        icon: Icons.question_mark_sharp,
                        onTap: () {
                          Get.to(AboutAppScreen());
                        }),
                    Gap(20.h),
                    buildProfileItem(
                        text: 'الشروط والأحكام',
                        icon: Icons.checklist_rtl_sharp,
                        onTap: () {
                          Get.to(TermsAndConditionsScreen());
                        }),
                    Gap(20.h),
                    buildProfileItem(
                        text: 'سياسة الخصوصية',
                        icon: Icons.list_alt_sharp,
                        onTap: () {
                          Get.to(PrivacypolicyScreen());
                        }),
                    Gap(20.h),
                    buildProfileItem(
                        text: 'الاقتراحات والشكاوي',
                        icon: Icons.chat_bubble_outline,
                        onTap: () {
                          Get.to(SuggestionsAndComplaintsScreen());
                        }),
                    Gap(20.h),
                    buildProfileItem(
                        text: 'مشاركة التطبيق',
                        icon: FluentSystemIcons.ic_fluent_share_regular,
                        onTap: (){Get.to(QRCode());}),
                    Gap(20.h),
                    buildProfileItem(
                        text: 'تقيم التطبيق',
                        icon: FluentSystemIcons.ic_fluent_star_regular,
                        onTap: () {Get.to(Rate());}),
                    Gap(20.h),
                    buildProfileItem(
                        text: 'تغير كلمة المرور',
                        icon: FluentSystemIcons.ic_fluent_lock_regular,
                        onTap: () {
                          Get.to((ChangePassScreen()));
                        }),
                    Gap(20.h),
                    buildProfileItem(
                        text: 'تسجيل خروج',
                        icon: Icons.logout,
                        onTap: () {

                          userData.write('isLogged', false);

                          userData.remove('name');

                          userData.remove('Email');
                          userData.remove('PhoneNumber');
                          userData.remove('userName ');
                          userData.remove('token ');
                          userData.remove('Name ');
                          userData.remove('FullName ');
                          userData.remove('email');
                          userData.remove('password');

                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("تسجيل خروج"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "هل أنت متأكد من مغادرة التطبيق",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Get.offAll(() => SignScreen()),
                                      child: Text(
                                        "حسنا",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Styles.defualtColor
                                        ),
                                      )),
                                  TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        'إلغاء',
                                        style: TextStyle(
                                          fontSize: 18,
                                            color: Styles.defualtColor
                                        ),
                                      )),
                                ],
                              ));
                        }),
                    Gap(20.h),
                    Text('By Afnan',style: TextStyle(
                      color: Colors.grey.shade400,
                    ),),
                    Gap(20.h),
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

Widget buildProfileStack1({
  required String text,
  required IconData icon,
  required Function() onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.h),
        height: 65.h,
        width: 55.h,
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
              Icon(icon,color:  Colors.black),
              Text(
                text,
                style: TextStyle(fontSize: 12.sp,color:  Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
Widget buildProfileItem({
  required String text,
  required IconData icon,
  required Function() onTap,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 38.h,
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: Styles.defualtColorWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Styles.defualtColor,
                    size: 19.sp,
                  ),
                  Gap(10.h),
                  Text(
                    text,
                    style: TextStyle(fontSize: 13.sp),
                  )
                ],
              ),
              Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 15.sp,
                color: Colors.grey.shade400,
              )
            ],
          ),
        ),
      ),
    );
