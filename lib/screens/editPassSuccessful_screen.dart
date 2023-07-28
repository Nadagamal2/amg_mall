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

class EditPasswordSuccess1 extends StatelessWidget {
  const EditPasswordSuccess1({Key? key}) : super(key: key);

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
                    Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 45.h),
                      child: Text(
                        'تم تغير كلمة المرور بنجاح',
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          fontSize: 17.sp,

                        ),),
                    ),

                    Image(image: AssetImage('assets/Secure data-pana.png'),

                    height: 220.h,
                    width: 220.h,),


                    Gap(50.h),
                    MyElevatedButton(
                      width: double.infinity,
                      onPressed: () {
                        Get.offAll(SignScreen());



                      },
                      borderRadius: BorderRadius.circular(5.r),
                      child: Text('تم'),
                    ),
                    // InkWell(
                    //   onTap: (){
                    //     Get.offAll(SignScreen());
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
