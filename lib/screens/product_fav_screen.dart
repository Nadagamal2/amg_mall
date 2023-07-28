import 'dart:convert';

import 'package:amg_store/screens/Favorite_Screen.dart';
import 'package:amg_store/screens/productHome.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../components/app_style.dart';
import '../components/evaluated_Buttom.dart';
import '../components/ratingController.dart';
import '../model_categ/product_by_sub_categ_home.dart';
import '../models/favModel.dart';
import 'bottomNav_screen.dart';

class ProductFavScreen extends StatefulWidget {
  String name;
  String description;

  String price;
  String img;
  String overAll;
  List<Widget>? crsal;
  Widget Fav;


  ProductFavScreen({
    Key? key,
    required this.name,
    required this.price,
    required this.description,

    required this.overAll,
    required this.img,
    required this.crsal,
    required this.Fav,

  }) : super(key: key);

  @override
  State<ProductFavScreen> createState() => _ProductFavScreenState();
}

class _ProductFavScreenState extends State<ProductFavScreen> {
  final _kind = ['اختر كميه؟','1', "2","3", "4","5","6","7","8","9","10","11","12"];
  String? _selectvalue = 'اختر كميه؟';
  BookDoctorScreen() {
    _selectvalue = _kind[0];
  }
  void AddToCart(

      ) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('http://eibtek2-001-site6.atempurl.com/api/CartItemApi/AddToCart'));
      request.body = json.encode({
        "id": 0,
        "productId":  userData.read('add'),
        "applicationUserId": userData.read('token'),
        "quantity":  userData.read('quantity'),
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }
  static const id = 'rating_page'; // see GetMaterialApp for this usage

  final controller = Get.find<RatingController>(); // finding the same instance of initialized controller

  Widget _buildBody() {
    final stars = List<Widget>.generate(5, (index) {
      return GetBuilder<RatingController>( // rebuilds when update() is called from GetX class
        builder: (controller) => Expanded(
          child: GestureDetector(
            child: controller.buildRatingStar(index),
            onTap: () {
              controller.updateAndStoreRating(index + 1); // +1 because index starts at 0 otherwise the star rating is offset by one
            },
          ),
        ),
      );
    });
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: 70.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: stars,
            ),
          ),

        ],
      ),
    );
  }
  final userData = GetStorage();

  int counter1 = 0;
  bool fav=false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Styles.defualtColorWhite,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            //alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 350.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.r),
                          bottomRight: Radius.circular(25.r)),
                    ),
                    child: Padding(
                      padding:
                      EdgeInsets.only(left: 20.h, right: 20.h, top: 50.h),
                      child: Stack(

                        children: [
                          SizedBox(
                            width: 400.h,
                            child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 400.h,


                                  autoPlay: false,
                                  viewportFraction: .8.h,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      counter1 = index;
                                    });
                                  },
                                  enlargeCenterPage: true,

                                  autoPlayCurve:
                                  Curves.fastLinearToSlowEaseIn,
                                  pauseAutoPlayOnTouch: true,
                                  //enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                  Duration(milliseconds: 900),
                                  //  viewportFraction: .8,
                                ),
                                items: widget.crsal),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
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
                                          offset: Offset(
                                              0, 1), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      size: 19.h,
                                      color: Styles.defualtColor,
                                    )),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.Fav,
                                  // InkWell(
                                  //   onTap: () {
                                  //      // Favorite();
                                  //
                                  //      setState(() {
                                  //        isClick=!isClick;
                                  //        if(isClick==true){
                                  //          Favorite();
                                  //        }else{
                                  //          //DelelteFavorite();
                                  //        }
                                  //
                                  //      });
                                  //
                                  //
                                  //
                                  //
                                  //   },
                                  //   onLongPress: (){
                                  //  //   DelelteFavorite();
                                  //   },
                                  //   child: Container(
                                  //       height: 20.h,
                                  //       width: 20.h,
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.white,
                                  //         boxShadow: [
                                  //           BoxShadow(
                                  //             color: Colors.grey.shade200,
                                  //             spreadRadius: 1,
                                  //             blurRadius: 3,
                                  //             offset: Offset(0,
                                  //                 1), // changes position of shadow
                                  //           ),
                                  //         ],
                                  //         borderRadius:
                                  //             BorderRadius.circular(5.r),
                                  //       ),
                                  //       child: Icon(isClick?Icons.favorite:
                                  //         Icons.favorite_border,
                                  //         size: 19.h,
                                  //         color: Styles.defualtColor,
                                  //       )),
                                  // ),
                                  Gap(10.h),
                                  InkWell(
                                    onTap: () {
                                      _launchUrl('https://play.google.com/store/apps/details?id=on.sam.amg');

                                    },
                                    child: Container(
                                        height: 20.h,
                                        width: 20.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                          BorderRadius.circular(5.r),
                                        ),
                                        child: Icon(
                                          Icons.share,
                                          size: 19.h,
                                          color: Styles.defualtColor,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 280.h,
                          child: Text(
                            widget.name,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),

                        Text(
                          widget.price,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15.sp),
                        ),
                        _buildBody(),
                        Divider(
                          color: Colors.grey.shade400,
                          thickness: .5,
                          height: 25.h,
                        ),
                        Text(
                          'وصف المنتج :',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15.sp),
                        ),
                        Column(
                          children: [
                            Row(

                              children: [
                                Text('*'),
                                Gap(5.h),
                                SizedBox(
                                  width: 270.h,
                                  child: Text(
                                    widget.description,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(),
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                          thickness: .5,
                          height: 25.h,
                        ),
                        // Text(
                        //   'المميزات :',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.w700, fontSize: 15.sp),
                        // ),
                        // Column(
                        //   children: [
                        //     Row(
                        //
                        //       children: [
                        //         Text('*'),
                        //         Gap(5.h),
                        //         // SizedBox(
                        //         //   width: 270.h,
                        //         //   child: Text(
                        //         //     widget.features,
                        //         //     textAlign: TextAlign.start,
                        //         //     style: TextStyle(),
                        //         //   ),
                        //         // )
                        //       ],
                        //     ),
                        //
                        //   ],
                        // ),
                        // Divider(
                        //   color: Colors.grey.shade400,
                        //   thickness: .5,
                        //   height: 25.h,
                        // ),
                        Text(
                          'نظرة عامة :',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15.sp),
                        ),
                        SizedBox(
                          width: 270.h,
                          child: Text(
                            widget.overAll,
                            textAlign: TextAlign.start,
                            style: TextStyle(),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Column(
                  //   children: [
                  //
                  //     Padding(
                  //         padding:  EdgeInsets.symmetric(horizontal: 0.h),
                  //         child:  SizedBox(
                  //           height: 200.h,
                  //           //    width: 400.h,
                  //           child: ListView.separated(
                  //               padding: EdgeInsets.all(10.h),
                  //               itemBuilder: (context,index)=>Center(
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.start,
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     CircleAvatar(
                  //                       radius: 5.r,
                  //                       backgroundColor: Styles.defualtColorBlack,
                  //                     ),
                  //                     SizedBox(
                  //                       width: 270.h,
                  //                       child: Text(' Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrystandard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  //
                  //                         textAlign: TextAlign.start,
                  //                         style: TextStyle(
                  //
                  //
                  //                         ),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //               separatorBuilder: (context,index)=>Gap(20.h),
                  //               itemCount: 4),
                  //         )
                  //     )
                  //   ],
                  // ),
                ],
              ),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 15.h
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80.h,
                      width: 90.h,
                      color: Styles.defualtColorWhite,
                      padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 20.h),
                      child:         DropdownButtonFormField(
                        value: _selectvalue,
                        items: _kind
                            .map((e) => DropdownMenuItem(
                          child: Text(
                            e,
                            style: TextStyle(
                                fontFamily: 'Tajawal7',
                                fontSize: 13.sp,
                                color: Colors.grey ),
                          ),
                          value: e,
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectvalue = val as String;
                          });
                          print(val);
                          userData.write('quantity', val);
                        },
                        icon: Align(
                          alignment: Alignment.center,
                          child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.grey
                          ),
                        ),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.h),
                          filled: true,
                          fillColor: Color(0xffF6F5F5),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: .1.r, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: .1.r, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          labelText: '1',
                          hintText: '1',
                          labelStyle: TextStyle(
                              fontFamily: 'Tajawal7',
                              fontSize: 13.sp,
                              color: Colors.grey.shade400),
                          hintStyle: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Tajawal7',
                              color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    Container(
                      height: 80.h,
                      width: 200.h,
                      color: Styles.defualtColorWhite,
                      padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 20.h),
                      child:  MyElevatedButton(
                        width:double.infinity,
                        onPressed: () {
                          userData.write('fav', false);
                          print(userData.read('fav'));
                          // print(cartList.length);
                          // userData.write('lenght', cartList.length);
                          //cartList.add(widget.productModelHome);
                          // Fluttertoast.showToast(
                          //     msg: 'تمت الإضافة إلى السلة بنجاح',
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0);
                          AddToCart();
                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (builder){
                                return new Container(
                                  height: 200.h,
                                  color: Colors.transparent,
                                  padding: EdgeInsets.all(10.h),
                                  //could change this to Color(0xFF737373),
                                  //so you don't have to change MaterialApp canvasColor
                                  child: new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:   BorderRadius.only(
                                              topLeft:   Radius.circular(10.0),
                                              topRight:   Radius.circular(10.0))),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          new Center(
                                            child: new Text('تمت الإضافة إلى السلة بنجاح',),
                                          ),
                                          Gap(20.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              MyElevatedButton(
                                                width: 150.h,
                                                onPressed: () {
                                                  Get.offAll(BottomNavScreen());



                                                },
                                                borderRadius: BorderRadius.circular(5.r),
                                                child: Text("الذهاب الي الصفحة الرئيسية",style: TextStyle(fontSize: 10.h),),
                                              ),
                                              MyElevatedButton(
                                                width: 150.h,
                                                onPressed: () {
                                                  Get.back();



                                                },
                                                borderRadius: BorderRadius.circular(5.r),
                                                child: Text(      "إختيار منتجات أخري",),
                                              ),

                                              // InkWell(
                                              //   onTap: (){
                                              //     Get.back();
                                              //   },
                                              //   child: Container(
                                              //     height: 40.h,
                                              //     width:150.h,
                                              //     decoration: BoxDecoration(
                                              //       gradient: LinearGradient(
                                              //         begin: Alignment(.8.h, -.7.h),
                                              //         end: Alignment(0.8.h, 1.h),
                                              //         colors: [
                                              //           const Color(0xFFF2DA75),
                                              //           const Color(0xFFCDA748),
                                              //         ],
                                              //         stops: [0.0, 1.0],
                                              //       ),
                                              //       borderRadius: BorderRadius.circular(5.r),
                                              //     ),
                                              //     child: Center(
                                              //       child: Text(
                                              //         "إختيار منتجات أخري",
                                              //         style: TextStyle(color: Styles.defualtColorWhite),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),

                                            ],
                                          ),
                                        ],
                                      )),
                                );
                              }
                          );

                        },
                        borderRadius: BorderRadius.circular(5.r),
                        child: Text( "إضافة الي السلة",),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _launchUrl(String link ) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
List <NewRecord?> cartList2=[];