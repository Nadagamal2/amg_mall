import 'package:amg_store/screens/bottomNav_screen.dart';
import 'package:amg_store/screens/sign_screen.dart';
import 'package:amg_store/screens/veriy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:ui' as ui;
import '../components/app_style.dart';
import '../components/evaluated_Buttom.dart';

class ComplaintDone extends StatelessWidget {
  const ComplaintDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Styles.defualtColorWhite,
        body: Column(
          children: [

            Padding(
              padding:  EdgeInsets.only(top: 100.h,left: 15.h,right: 15.h),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'تم ارسال الرسالة الخاصة بك الي فريق العمل بنجاح سيتم التواصل معك قريبا علي البريد الإلكتروني او رقم الهاتف الذي قمت بإدخاله',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600

                      ),),
                    Gap(20.h),

                    Image(image: AssetImage('assets/91068-message-sent-successfully-plane.png'),

                      height: 220.h,
                      width: 220.h,),


                    Gap(50.h),
                    MyElevatedButton(
                      width: double.infinity,
                      onPressed: () {
                        Get.offAll(BottomNavScreen());



                      },
                      borderRadius: BorderRadius.circular(5.r),
                      child: Text('تم'),
                    ),
                    // InkWell(
                    //   onTap: (){
                    //     Get.offAll(BottomNavScreen());
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
                    //         "تم",
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
            )

          ],
        ),
      ),
    );
  }
}
