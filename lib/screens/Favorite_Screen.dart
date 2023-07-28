import 'dart:convert';


import 'package:amg_store/screens/product_fav_screen.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import '../components/app_style.dart';
import '../components/ratingController.dart';
import '../models/favModel.dart';
import 'bottomNav_screen.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
      padding:   EdgeInsets.symmetric(horizontal: 15.h),
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
  Future<FavModel?> FavoritId() async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://eibtek2-001-site6.atempurl.com/api/Get_Faviourites_byUserId/${userData.read('token')}'),

      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print(data);
      } else {
        print("Faild");
      }
      return FavModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e.toString());
    }
  }

  void DelelteFavorite(

      ) async {
    try {
      var request = http.Request('DELETE', Uri.parse('http://eibtek2-001-site6.atempurl.com/api/DeleteFaviourite?productId=${userData.read('add')}&applicationUserId=${userData.read('token')}'));


      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
         Get.offAll(BottomNavScreen());

        Fluttertoast.showToast(
            msg: 'تم الحذف من المفضلة بنجاح',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      else {
        print(response.reasonPhrase);
      }



    } catch (e) {
      print(e.toString());
    }
  }

  bool isSelected = true;
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
                            'المفضلة',
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
                  FutureBuilder(
                    future: FavoritId(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //snapshot.data!.newRecords[index]
                        return Padding(
                            padding: EdgeInsets.only(
                                top: 100.h, right: 15.h, left: 15.h),
                            child: SizedBox(
                              height: 580.h,
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data!.newRecords!.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12.h,
                                  childAspectRatio: .64,
                                  crossAxisSpacing: 7.h,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return   InkWell(
                                    onTap: () {
                                      print(snapshot.data!.newRecords[index]!.id);
                                      userData.write('add',snapshot.data!.newRecords![index]!.id);
                                      Get.to(ProductFavScreen(
                                        crsal:   snapshot.data!.newRecords![index].productPhotos .map((e) =>  Column(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                showDialog(
                                                  context: context,
                                                  builder:(context)=>
                                                      Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(30)),

                                                        child: Container(
                                                          height: 250.h,
                                                          width: 250.h,

                                                          child: InteractiveViewer(

                                                              clipBehavior: Clip.none,
                                                              child: Container(
                                                                width: double.infinity,


                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(


                                                                      image:  NetworkImage(
                                                                        'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                                                                      ),
                                                                    )
                                                                ),
                                                              )
                                                          ),
                                                        ),

                                                      ),

                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15.h),
                                                    image: DecorationImage(

                                                      image: NetworkImage(
                                                        'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                                                      ),
                                                    )),
                                                height: 250.h,
                                                width: 300.h,
                                              ),
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //   MainAxisAlignment.center,
                                            //   crossAxisAlignment:
                                            //   CrossAxisAlignment.end,
                                            //   children: [
                                            //     for (int i = 0; i < item[index]!.productPhotos.length; i++)
                                            //       Container(
                                            //         height: 6.h,
                                            //         width: 6.h,
                                            //         margin: EdgeInsets.symmetric(
                                            //             horizontal: 3.h,
                                            //             vertical: 10.h),
                                            //         decoration: BoxDecoration(
                                            //           color: counter1 == i
                                            //               ? Color(0xff858583)
                                            //               : Color(0xff014678),
                                            //           shape: BoxShape.circle,
                                            //         ),
                                            //       ),
                                            //   ],
                                            // ),
                                          ],
                                        )).toList(),
                                        // productModelHome:snapshot.data!.newRecords[index]! ,

                                        name: '${snapshot.data!.newRecords[index]!.name}',
                                        price:
                                        '${snapshot.data!.newRecords[index]!.price} رس',
                                        description:
                                        '${snapshot.data!.newRecords[index]!.description}',

                                        overAll:
                                        '${snapshot.data!.newRecords[index]!.overAll}',
                                        img: ' ',
                                        Fav:  FavoriteButton(
                                        iconColor: Styles.defualtColor,
                                        iconSize: 30.sp,
                                        isFavorite:  true ,
                                        valueChanged: (val) {

                                          DelelteFavorite();

                                        },
                                      ),
                                      ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.h,
                                          vertical: 10.h),
                                      height: 200.h,
                                      width: 140.h,
                                      decoration: BoxDecoration(
                                        color: Styles.defualtColorWhite,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey
                                                .withOpacity(.1),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius:
                                        BorderRadius.circular(5.h),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Image(

                                                  image: NetworkImage(
                                                      'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${snapshot.data!.newRecords![index]!.photoName}'),


                                                  height: 120.h,
                                                  width: 120.h,
                                                ),

                                                Gap(10.h),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SizedBox(
                                                      width: 100.h,
                                                      child: Text(
                                                        '${snapshot.data!.newRecords![index]!.name}',
                                                        maxLines: 2,
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                    ),
                                                    Gap(5.h),
                                                    // Row(
                                                    //   children: [
                                                    //     Icon(
                                                    //       FluentSystemIcons
                                                    //           .ic_fluent_star_regular,
                                                    //       color: Styles
                                                    //           .defualtColor,
                                                    //       size: 15.sp,
                                                    //     ),
                                                    //     Icon(
                                                    //       FluentSystemIcons
                                                    //           .ic_fluent_star_regular,
                                                    //       color: Styles
                                                    //           .defualtColor,
                                                    //       size: 15.sp,
                                                    //     ),
                                                    //     Icon(
                                                    //       FluentSystemIcons
                                                    //           .ic_fluent_star_regular,
                                                    //       color: Styles
                                                    //           .defualtColor,
                                                    //       size: 15.sp,
                                                    //     ),
                                                    //     Icon(
                                                    //       FluentSystemIcons
                                                    //           .ic_fluent_star_regular,
                                                    //       color: Styles
                                                    //           .defualtColor,
                                                    //       size: 15.sp,
                                                    //     ),
                                                    //     Icon(
                                                    //       FluentSystemIcons
                                                    //           .ic_fluent_star_regular,
                                                    //       color: Styles
                                                    //           .defualtColor,
                                                    //       size: 15.sp,
                                                    //     ),
                                                    //     Text(
                                                    //       '(4.5)',
                                                    //       style: TextStyle(
                                                    //           fontSize:
                                                    //           11.sp,
                                                    //           color: Styles
                                                    //               .defualtColor),
                                                    //     )
                                                    //   ],
                                                    // ),

                                                    Text(
                                                      '${snapshot.data!.newRecords![index]!.price} رس',
                                                      style: TextStyle(
                                                          color: Colors.grey.shade500,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600,
                                                          fontSize:
                                                          11.sp),
                                                    ),
                                                    _buildBody(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            // InkWell(
                                            //   onTap: () {
                                            //     setState(() {
                                            //       isSelected=!isSelected;
                                            //     });
                                            //   },
                                            //   child: Container(
                                            //       height: 22.h,
                                            //       width: 22.h,
                                            //       decoration: BoxDecoration(
                                            //         boxShadow: [
                                            //           BoxShadow(
                                            //             color:
                                            //             Colors.grey.withOpacity(.2),
                                            //             spreadRadius: 1,
                                            //             blurRadius: 7,
                                            //             offset: Offset(0,
                                            //                 3), // changes position of shadow
                                            //           ),
                                            //         ],
                                            //         color: Colors.white,
                                            //         borderRadius: BorderRadius.circular(5.r),
                                            //       ),
                                            //       child: Icon(isSelected?Icons.favorite:Icons.favorite_border,
                                            //           size: 19.h, color: Colors.red)),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Styles.defualtColor),
                          ),
                        );
                      }
                    },
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
