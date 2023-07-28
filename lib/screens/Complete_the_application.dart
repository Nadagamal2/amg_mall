import 'dart:convert';

import 'package:amg_store/screens/pay_screen.dart';
import 'package:amg_store/screens/productHome.dart';
import 'package:amg_store/screens/product_fav_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;

import '../components/app_style.dart';
import 'package:http/http.dart' as http;

import 'cart_done.dart';
class CompleteTheApplicationScreen extends StatefulWidget {
  const CompleteTheApplicationScreen({Key? key}) : super(key: key);

  @override
  State<CompleteTheApplicationScreen> createState() => _CompleteTheApplicationScreenState();
}

class _CompleteTheApplicationScreenState extends State<CompleteTheApplicationScreen> {
  final userData = GetStorage();
  void cart() async {

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://eibtek2-001-site6.atempurl.com/api/ConfirmOrderApi/ConfirmOrder'));
    request.body = json.encode({
      "value": userData.read('totalPrice'),

    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.offAll(CartDoneScreen());

    }
    else {
      print(response.reasonPhrase);
    }


  }
  int _radioSelected = 1;
  String _radioVal = "";
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

                      Text( 'تكملة الطلب', style: TextStyle(
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

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('شحن الي',style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),),
                        // TextButton(onPressed: () {  }, child: Text('تغيير العنوان',style: TextStyle(
                        //   color: Colors.grey.shade400
                        // ),), ),
                      ],
                    ),
                    Gap(5.h),
                    Center(
                      child: Container(
                        height: 80.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(5.r),
                            border: Border.all(
                                color: Colors.grey.shade400,
                                width: .5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FluentSystemIcons
                                      .ic_fluent_location_regular,
                                  color: Styles.defualtColor,
                                  size: 20.sp,
                                ),
                                Gap(10.h),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('المنزل',style: TextStyle(
                                    //     fontWeight: FontWeight.w600,
                                    //     color: Styles.defualtColor
                                    // ),),
                                    Text('توصيل الي : ${userData.read('Title')}',style: TextStyle(

                                    ),),
                                    Gap(5.h),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 7.r,
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.phone,color: Styles.defualtColorWhite,size: 7.sp,
                                          ),
                                        ),Gap(5.h),
                                        Text('${userData.read('PhoneNumber')}',style: TextStyle(fontSize: 10.h,color: Colors.grey.shade400),)
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    Gap(15.h),
                    Text('طريقة للدفع',style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),),
                    Gap(10.h),
                    // Container(
                    //   height: 35.h,
                    //   width: double.infinity,
                    //   padding: EdgeInsets.symmetric(horizontal: 5.h),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(5.r),
                    //   ),
                    //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Radio(
                    //             splashRadius: 10.r,
                    //             value: 1,
                    //             autofocus: true,
                    //             groupValue: _radioSelected,
                    //             activeColor: Styles.defualtColor,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 _radioSelected = value!;
                    //
                    //
                    //               });
                    //             },
                    //           ),
                    //           Text('مدي'),
                    //
                    //         ],
                    //
                    //       ),
                    //       Image(image: AssetImage('assets/2560px-Mada_Logo.svg.png'),height: 10.h,fit: BoxFit.cover,)
                    //     ],
                    //   ),
                    // ),
                    // Gap(10.h),
                    // Container(
                    //   height: 35.h,
                    //   width: double.infinity,
                    //   padding: EdgeInsets.symmetric(horizontal: 5.h),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(5.r),
                    //   ),
                    //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Radio(
                    //             splashRadius: 10.r,
                    //             value: 2,
                    //             autofocus: true,
                    //             groupValue: _radioSelected,
                    //             activeColor: Styles.defualtColor,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 _radioSelected = value!;
                    //
                    //
                    //               });
                    //             },
                    //           ),
                    //           Text('فيزا'),
                    //
                    //         ],
                    //
                    //       ),
                    //       Image(image: AssetImage('assets/Visa-Card-Logo-PNG-Photo-Clip-Art-Image.png',),height: 10.h,fit: BoxFit.cover,)
                    //       // Icon(FluentSystemIcons.ic_fluent_)
                    //     ],
                    //   ),
                    // ),
                    // Gap(10.h),
                    Container(
                      height: 35.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                splashRadius: 10.r,
                                value: 1,
                                autofocus: true,
                                groupValue: _radioSelected,
                                activeColor: Styles.defualtColor,
                                onChanged: (value) {
                                  setState(() {
                                    _radioSelected = value!;


                                  });
                                },
                              ),
                              Text('دفع عند الاستلام'),

                            ],

                          ),
                          SvgPicture.asset('assets/building-bold.svg',  ),

                        ],
                      ),
                    ),
                    Gap(20.h),
                    Container(
                      height: 220.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Padding(
                           padding:   EdgeInsets.all(10.0),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('تكلفة الطلب',style: TextStyle(
                                 fontWeight: FontWeight.w600,
                               ),),
                               Gap(15.h),
                               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [

                                   Text(
                                     'التكلفة الجزئية',
                                     style: TextStyle(
                                       fontSize: 11.h,
                                     ),
                                   ),
                                   Text(
                                     '${userData.read('totalPrice')} رس',
                                     style: TextStyle(
                                         fontSize: 11.h,fontWeight: FontWeight.w600
                                     ),
                                   ),
                                 ],
                               ),
                               Gap(10.h),
                               // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               //   children: [
                               //
                               //     Text(
                               //       'تكلفة التوصيل',
                               //       style: TextStyle(
                               //         fontSize: 11.h,
                               //       ),
                               //     ),
                               //     Text(
                               //       '777 رس',
                               //       style: TextStyle(
                               //           fontSize: 11.h,fontWeight: FontWeight.w600
                               //       ),
                               //     ),
                               //   ],
                               // ),
                               // Gap(10.h),
                               // // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               //   children: [
                               //
                               //     Text(
                               //       'الضريبة المضافة',
                               //       style: TextStyle(
                               //         fontSize: 11.h,
                               //       ),
                               //     ),
                               //     Text(
                               //       '777 رس',
                               //       style: TextStyle(
                               //           fontSize: 11.h,fontWeight: FontWeight.w600
                               //       ),
                               //     ),
                               //   ],
                               // ),
                               // Gap(10.h),
                               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [

                                   Text(
                                     'التكلفة الكلية',
                                     style: TextStyle(
                                       fontSize: 13.h,
                                       color: Colors.green,
                                       fontWeight: FontWeight.w600
                                     ),
                                   ),
                                   Text(
                                     '${userData.read('totalPrice')} رس',
                                     style: TextStyle(
                                         fontSize: 13.h,fontWeight: FontWeight.w600,
                                       color: Colors.green,


                                     ),
                                   ),
                                 ],
                               ),

                             ],
                           ),
                         ),
                          Divider(
                            height: 20.h,
                            thickness: .5,
                            color: Colors.grey.shade400,
                          ),
                          Padding(
                            padding:   EdgeInsets.symmetric(horizontal: 10.h),
                            child: InkWell(
                              onTap: (){
                                cart();

                              },
                              child: Container(
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
                                    "تأكيد الاوردر",
                                    style: TextStyle(
                                        color: Styles.defualtColorWhite
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

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
