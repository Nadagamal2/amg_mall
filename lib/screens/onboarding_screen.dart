import 'package:amg_store/screens/sign_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/app_style.dart';
import 'location_screen.dart';

class BoardingModel {
  final String image;
  // final String title;
  final String body;

  BoardingModel({
    required this.image,
    // required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/Payment Information-bro.svg',
      // title: "Search Doctor".tr(),
      body: 'جميع مستلزماتك الشرائية بارخص الاسعار ولاتنسي زيارة صفحة العروض',
    ),
    BoardingModel(
      image: 'assets/Delivery address-rafiki.svg',
      // title: "Book Appointment ".tr(),
      body: 'اطلبها ونوصلها بنتابع كل طلبياتك لحد متوصلك بكل عنايه',
    ),
    // BoardingModel(
    //   image: 'assets/online-shop _2_.svg',
    //   // title: "Book Appointment ".tr(),
    //   body: 'تسوق الآن',
    // ),
  ];
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/2.png'))),
      child: Column(
        children: [
          Gap(40.h),

          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 15.h),
            child: InkWell(
              onTap: (){
                Get.offAll(SignScreen());
              },
              child:
// if( currentIndex == boarding.length - 3)

              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [

                  Text(
                    'تخطي',
                    style: TextStyle(
                      color: Styles.defualtColorWhite,
                      fontSize: 16.sp,
                    ),
                  ),
                  Stack(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 17.h,
                        color: Styles.defualtColorWhite,
                      ),
                      Positioned(
                          left: 5.h,
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 17.h,
                            color: Styles.defualtColorWhite,
                          )),
                    ],
                  ),

                  // Icon(Icons.arrow_forward_ios_outlined,size:17.h,color: Styles.defualtColorWhite,),
                ],
              )
            ),
          ),
          // Gap(40.h),
          //
          // InkWell(
          //   onTap: (){
          //     Get.offAll(SignScreen());
          //   },
          //   child:     currentIndex == boarding.length - 2?
          //
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //
          //     children: [
          //
          //       Text(
          //         'تخطي',
          //         style: TextStyle(
          //           color: Styles.defualtColorWhite,
          //           fontSize: 16.sp,
          //         ),
          //       ),
          //       Stack(
          //         children: [
          //           Icon(
          //             Icons.arrow_forward_ios_outlined,
          //             size: 17.h,
          //             color: Styles.defualtColorWhite,
          //           ),
          //           Positioned(
          //               left: 5.h,
          //               child: Icon(
          //                 Icons.arrow_forward_ios_outlined,
          //                 size: 17.h,
          //                 color: Styles.defualtColorWhite,
          //               )),
          //         ],
          //       ),
          //
          //       // Icon(Icons.arrow_forward_ios_outlined,size:17.h,color: Styles.defualtColorWhite,),
          //     ],
          //   ) :Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //
          //     children: [
          //
          //       Text(
          //         'تخطي',
          //         style: TextStyle(
          //           color: Colors.transparent,
          //           fontSize: 16.sp,
          //         ),
          //       ),
          //       Stack(
          //         children: [
          //           Icon(
          //             Icons.arrow_forward_ios_outlined,
          //             size: 17.h,
          //             color: Colors.transparent,
          //           ),
          //           Positioned(
          //               left: 5.h,
          //               child: Icon(
          //                 Icons.arrow_forward_ios_outlined,
          //                 size: 17.h,
          //                 color: Colors.transparent,                                          )),
          //         ],
          //       ),
          //
          //       // Icon(Icons.arrow_forward_ios_outlined,size:17.h,color: Styles.defualtColorWhite,),
          //     ],
          //   ),
          // ),
          Expanded(
            flex: 4,
            child: PageView.builder(

                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                // FluentSystemIcons.ic_fluent_ios_arrow_left_regular
                physics: BouncingScrollPhysics(),
                itemCount: boarding.length,

                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(15.h),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          //boarding[index].image
                          Gap(40.h),
                          SvgPicture.asset(boarding[index].image),
                          // Text(
                          //   boarding[index].title,
                          //
                          // ),
                          Gap(100.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: Text(
                              boarding[index].body,
                              style: TextStyle(
                                color: Styles.defualtColorWhite,
                                fontSize: 18.h,
                                height: 1.h,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),



                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //
                          //
                          //      Container(
                          //        height: 4.h,
                          //          width: 18.h,
                          //        decoration: BoxDecoration(
                          //          color: Styles.defualtColorWhite,
                          //          borderRadius: BorderRadius.circular(10.h),
                          //        ),
                          //      ),
                          //     Gap(3.h),
                          //     Container(
                          //        height: 5.h,
                          //          width: 5.h,
                          //        decoration: BoxDecoration(
                          //          shape: BoxShape.circle,
                          //          color: Styles.defualtColorWhite,
                          //
                          //
                          //        ),
                          //      ),
                          //     Gap(3.h),
                          //     Container(
                          //        height: 5.h,
                          //          width: 5.h,
                          //        decoration: BoxDecoration(
                          //          shape: BoxShape.circle,
                          //          color: Styles.defualtColorWhite,
                          //
                          //
                          //        ),
                          //      ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  );
                }),
          ),

          Expanded(
            flex: 1,
            child: Padding(
              padding:   EdgeInsets.symmetric(horizontal: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        boarding.length,
                            (index) => Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 1.2.h),
                          child: AnimatedContainer(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration:
                            Duration(seconds: 1),
                            width: index == currentIndex ? 20 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(20)),
                          ),
                        )),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(

                          onTap:(){
                            if (currentIndex == boarding.length - 1) {
                              Get.offAll(SignScreen());
                            }
                            _controller?.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                          },
                          child: Icon(FluentSystemIcons.ic_fluent_arrow_right_circle_filled,color: Colors.white,size: 30.h,))
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    ));
  }
}
