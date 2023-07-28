import 'package:amg_store/components/app_style.dart';
import 'package:amg_store/screens/signUp_screen.dart';
import 'package:amg_store/screens/sign_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'dart:ui' as ui;

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool selected=true;
  // var formKey = GlobalKey<FormState>();
  //
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  bool? isChecked = false;
  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/m.png'),
                  fit: BoxFit.cover
              )
          ),

          child: Padding(
            padding:   EdgeInsets.all(15.h),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      children: [
                        Text('تحديد الموقع',style: TextStyle(
                          color: Styles.defualtColorBlack,
                          fontSize: 17.sp,
                        ),),
                        Directionality(
                          textDirection: ui.TextDirection.rtl,
                          child: TextFormField(

                            cursorColor: Colors.grey.shade400,
                            keyboardType: TextInputType.emailAddress,
                            // controller: emailController,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 15.h),
                              filled: true,
                              fillColor: Color(0xffffffff),
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
                              labelText:  'بحث' ,
                              hintText: 'بحث' ,
                              prefixIcon: Icon(FluentSystemIcons.ic_fluent_search_regular,color: Colors.grey.shade300,),
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
                        ),
                      ],
                    ),
                    Gap(460.h),
                    InkWell(
                      onTap: (){
                        Get.offAll(SignScreen());
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.my_location,color: Color(0xFFCDA748),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Text(
                                'تخطي',
                                style: TextStyle(

                                  fontSize: 16.sp,
                                ),
                              ),
                              Stack(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 17.h,

                                  ),
                                  Positioned(
                                      left: 4.h,
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 17.h,

                                      )),
                                ],
                              ),


                              // Icon(Icons.arrow_forward_ios_outlined,size:17.h,color: Styles.defualtColorWhite,),
                            ],
                          ),

                        ],
                      ),
                    ),
                    Gap(20.h),
                    Container(
                      height: 40.h,
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
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Center(
                        child: Text(
                          "تحديد الموقع",
                          style: TextStyle(
                              color: Styles.defualtColorWhite
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
