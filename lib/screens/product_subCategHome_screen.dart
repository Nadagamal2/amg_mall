import 'dart:convert';

import 'package:amg_store/screens/bottomNav_screen.dart';
import 'package:amg_store/screens/productHome.dart';
import 'package:amg_store/screens/product_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
import '../model_categ/product_by_sub_categ_home.dart';
import '../models/categ_model.dart';
import '../models/product_by_SupCat_model.dart';
import '../models/subCat_model.dart';
import '../models/supCat_model.dart';

class ProductBySubCageHomecScreen extends StatefulWidget {
  String name;
  ProductBySubCageHomecScreen({Key? key,required this.name}) : super(key: key);

  @override
  State<ProductBySubCageHomecScreen> createState() => _ProductBySubCageHomecScreenState();
}

class _ProductBySubCageHomecScreenState extends State<ProductBySubCageHomecScreen> {

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
  int counter1 = 0;
  bool isSelected=false;
  void Favorite(

      ) async {
    try {
      var response = await http.post(
          Uri.parse('http://eibtek2-001-site6.atempurl.com/api/CreateUserFavorites'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({

            "productId": userData.read('add'),
            "applicationUserId": "${userData.read('token')}",

          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print(data);


        Fluttertoast.showToast(
            msg: 'تمت الإضافة إلى المفضلة بنجاح',
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
  void DelelteFavorite(

      ) async {
    try {
      var request = http.Request('DELETE', Uri.parse('http://eibtek2-001-site6.atempurl.com/api/DeleteFaviourite?productId=${userData.read('add')}&applicationUserId=${userData.read('token')}'));


      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        //Get.offAll(BottomNavScreen());

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
  Future<List<ProductSubCategHomeModel>> getData4() async {
    final response = await http.post(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/ProductApi/GetAllBySubCategoryId ?ApplicationUserId=${userData.read('token')}&CategoryId=${userData.read('subCategId')}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {

      print(response.body);

      List jsonData = (data);
      // print(jsonData);
      return jsonData
          .map(( Data) => ProductSubCategHomeModel.fromJson(Data))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  final userData =GetStorage();



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text( widget.name, style: TextStyle(
            fontFamily: 'Tajawal2',
            color: Styles.defualtColor2,
            fontSize: 17.sp,
          ),) ,
          leading:    InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.keyboard_arrow_right_outlined,size: 19.h,color: Colors.black,),
          ) ,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   alignment: Alignment.bottomCenter,
                  //   height: 100.h,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r),bottomRight: Radius.circular(25.r)),
                  //   ),
                  //   child: Padding(
                  //     padding:   EdgeInsets.symmetric(horizontal: 15.h,vertical: 28.h),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         InkWell(
                  //           onTap: (){
                  //             Get.back();
                  //           },
                  //           child: Container(
                  //               height: 20.h,
                  //               width: 20.h,
                  //
                  //               decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //
                  //                 borderRadius: BorderRadius.circular(5.r),
                  //
                  //               ),
                  //               child:  Icon(Icons.keyboard_arrow_right_outlined,size: 19.h,color: Colors.black,)
                  //           ),
                  //         ),
                  //
                  //         Text( widget.name, style: TextStyle(
                  //           fontFamily: 'Tajawal2',
                  //           color: Styles.defualtColor2,
                  //           fontSize: 17.sp,
                  //         ),),
                  //         InkWell(
                  //           onTap: (){
                  //             Get.back();
                  //           },
                  //           child: Container(
                  //               height: 20.h,
                  //               width: 20.h,
                  //
                  //               decoration: BoxDecoration(
                  //                 color: Colors.transparent,
                  //
                  //                 borderRadius: BorderRadius.circular(5.r),
                  //
                  //               ),
                  //               child:  Icon(Icons.keyboard_arrow_right_outlined,size: 19.h, color: Colors.transparent,)
                  //           ),
                  //         ),
                  //
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        // Container(
                        //     height: 40.h,
                        //     width:double.infinity,
                        //     padding:   EdgeInsets.symmetric(horizontal: 10.h),
                        //
                        //     decoration: BoxDecoration(
                        //       color: Styles.defualtColorWhite,
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.grey.shade200,
                        //           spreadRadius: 1,
                        //           blurRadius: 3,
                        //           offset: Offset(0, 1), // changes position of shadow
                        //         ),
                        //       ],
                        //       borderRadius: BorderRadius.circular(5.r),
                        //
                        //     ),
                        //     child:  Row(
                        //       children: [
                        //         Icon(FluentSystemIcons.ic_fluent_search_regular,size: 20.h, color: Colors.grey.shade400,),
                        //         Gap(5.h),
                        //         Text('بحث',style: TextStyle(
                        //           color: Colors.grey.shade400,
                        //         ),)
                        //       ],
                        //     )
                        // ),

                        FutureBuilder<List<ProductSubCategHomeModel?>>(
                          future: getData4(),
                          builder: (context,snapshot){
                            if(snapshot.hasData){
                              print(snapshot.error);
                              List<ProductSubCategHomeModel?>? item = snapshot.data;
                              return  Container(
                                height: 600.h,
                              //  padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 4.h),
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: item!.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12.h,
                                    childAspectRatio: .6,
                                    crossAxisSpacing: 7.h,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return   InkWell(
                                      onTap: () {

                                        print(item[index]!.id);
                                        userData.write('add',item![index]!.id);
                                        Get.to(ProductHomeScreen(
                                          Cursal:  item[index]!.productPhotos!.map((e) =>  Column(
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
                                                                          'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgURL}',
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
                                                          'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgURL}',
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
                                          productModelHome:item[index]! ,

                                          name: '${item[index]!.name}',
                                          price:
                                          '${item[index]!.price} رس',
                                          description:
                                          '${item[index]!.description}',

                                          overAll:
                                          '${item[index]!.overAll}',
                                          img: ' ',   Fav:  FavoriteButton(
                                          iconColor: Styles.defualtColor,
                                          iconSize: 30.sp,
                                          isFavorite:  item[index]!.isFavorite ,
                                          valueChanged: (val) {
                                            item[index]!.isFavorite==false?
                                                Favorite():DelelteFavorite();
                                            val==item[index]!.isFavorite;
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
                                                        'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${item![index]!.photoName}'),


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
                                                          ' ${item![index]!.name} ',
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
                                                        '${item![index]!.price} رس',
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
                              );
                            }else {
                              return Center(
                                child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Colors.transparent),),
                              );
                            }
                          },
                        ),




                        // FutureBuilder<List<CategModel?>?>(
                        //   future: getData(),
                        //   builder: (context,snapshot){
                        //     if(snapshot.hasData){
                        //       List<CategModel?>? item = snapshot.data;
                        //       return SizedBox(
                        //         height: 200.h,
                        //         child: ListView.separated(
                        //           padding: EdgeInsets.all(5.h),
                        //
                        //             itemBuilder: (context,index)=>     InkWell(
                        //               onTap: (){
                        //
                        //               },
                        //               child: Container(
                        //                 height: 40.h,
                        //                 width: double.infinity,
                        //                 padding: EdgeInsets.symmetric(horizontal: 10.h),
                        //                 decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //
                        //                   borderRadius: BorderRadius.circular(10.h),
                        //                   boxShadow: [
                        //                     BoxShadow(
                        //                       color: Colors.grey.withOpacity(0.1),
                        //                       spreadRadius: 5,
                        //                       blurRadius: 7,
                        //                       offset: Offset(0, 3), // changes position of shadow
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text('${item![index]!.name}',style: TextStyle(
                        //                       color: Colors.grey.shade400,
                        //                     ),),
                        //                     //Icon( Icons.arrow_forward_ios_rounded,size: 15.h, color: Colors.grey.shade400,),
                        //
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //
                        //
                        //             separatorBuilder: (context,index)=>  Divider(
                        //               height: 25.h,
                        //               thickness: .5,
                        //               color: Colors.grey.shade400,
                        //             ),
                        //
                        //             itemCount: item!.length
                        //         ),
                        //       );
                        //     }else {
                        //       return Center(
                        //         child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor),),
                        //       );
                        //     }
                        //   },
                        // ),

                        // Divider(
                        //   height: 15.h,
                        //   thickness: .5,
                        //   color: Colors.grey.shade400,
                        // ),
                        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text('العاب',style: TextStyle(
                        //       color: Colors.grey.shade400,
                        //     ),),
                        //     Icon( Icons.arrow_forward_ios_rounded,size: 15.h, color: Colors.grey.shade400,),
                        //
                        //   ],
                        // ),
                        // Divider(
                        //   height: 15.h,
                        //   thickness: .5,
                        //   color: Colors.grey.shade400,
                        // ),
                        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text('ادوات منزليه',style: TextStyle(
                        //       color: Colors.grey.shade400,
                        //     ),),
                        //     Icon( Icons.arrow_forward_ios_rounded,size: 15.h, color: Colors.grey.shade400,),
                        //
                        //   ],
                        // ),
                        // Divider(
                        //   height: 15.h,
                        //   thickness: .5,
                        //   color: Colors.grey.shade400,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
