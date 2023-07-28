import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/app_style.dart';
import '../components/evaluated_Buttom.dart';
import '../components/ratingController.dart';
import 'package:flutter/services.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  static const id = 'rating_page'; // see GetMaterialApp for this usage

  final controller = Get.find<
      RatingController>(); // finding the same instance of initialized controller

  Widget _buildBody() {
    final stars = List<Widget>.generate(5, (index) {
      return GetBuilder<RatingController>(
        // rebuilds when update() is called from GetX class
        builder: (controller) => Expanded(
          child: GestureDetector(
            child: controller.buildRatingStar(index),
            onTap: () {
              controller.updateAndStoreRating(index +
                  1); // +1 because index starts at 0 otherwise the star rating is offset by one
            },
          ),
        ),
      );
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: stars,
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                controller.updateAndStoreRating(0);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defualtColorWhite,
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30,
            )),
        centerTitle: true,
        title: Text(
          'مشاركة التطبيق',
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/Barcode Of AMG4.png',),height: 250.h,width: 250.h,),
            Text('AMG MALL',style: TextStyle(
              fontSize: 29.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xffDBC23F)
            ),),
            Gap(30.h),

            Padding(
              padding:   EdgeInsets.symmetric( horizontal: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130.h,
                    child: MyElevatedButton(
                      width: double.infinity,
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(
                            text:
                                'https://play.google.com/store/apps/details?id=on.sam.amg'));
                        print('do');
                        Fluttertoast.showToast(
                            msg: 'تم',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        // copied successfully
                      },
                      borderRadius: BorderRadius.circular(5.r),
                      child: Text('نسخ رابط التطبيق'),
                    ),
                  ),
                  SizedBox(
                    width: 130.h,
                    child: MyElevatedButton(
                      width: double.infinity,
                      onPressed: () async {
                        _launchUrl(
                            'https://play.google.com/store/apps/details?id=on.sam.amg');
                        print('do');

                        // copied successfully
                      },
                      borderRadius: BorderRadius.circular(5.r),
                      child: Text('مشاركة رابط التطبيق'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String link) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
