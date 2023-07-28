import 'dart:convert';

import 'package:amg_store/screens/bottomNav_screen.dart';
import 'package:amg_store/screens/product_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../components/app_style.dart';
import '../models/categ_model.dart';
import '../models/product_by_SupCat_model.dart';
import '../models/subCat_model.dart';
import '../models/supCat_model.dart';

class ProductBySubCatecScreen extends StatefulWidget {
  String name;
  ProductBySubCatecScreen({Key? key,required this.name}) : super(key: key);

  @override
  State<ProductBySubCatecScreen> createState() => _ProductBySubCatecScreenState();
}

class _ProductBySubCatecScreenState extends State<ProductBySubCatecScreen> {
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

      //
      // var response = await http.delete(
      //     Uri.parse('http://eibtek2-001-site6.atempurl.com/api/DeleteFaviourite/${userData.read('delete')}'),
      //     headers: {
      //       "Content-Type": "application/json",
      //     },
      //  );
      // var data = jsonDecode(response.body.toString());
      // if (response.statusCode == 200) {
      //   print(data);
      //
      //   //Get.offAll(BottomNavScreen());
      //
      //   Fluttertoast.showToast(
      //       msg: 'تم الحذف من المفضلة بنجاح',
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // }
      // else {
      //   print(response.reasonPhrase);
      // }

    } catch (e) {
      print(e.toString());
    }
  }
  Future<List<ProductBySubCategModel>> getData4() async {
    final response = await http.post(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/ProductApi/GetAllByCategoryId ?ApplicationUserId=${userData.read('token')}&CategoryId=${userData.read('subCategId')}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {

       print(response.body);

      List jsonData = (data);
      // print(jsonData);
      return jsonData
          .map(( Data) => ProductBySubCategModel.fromJson(Data))
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

        body: Center(
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
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              child:  Icon(Icons.keyboard_arrow_right_outlined,size: 19.h,color: Colors.black,)
                          ),
                        ),

                        Text( widget.name, style: TextStyle(
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
                      FutureBuilder<List<ProductBySubCategModel?>>(
                        future: getData4(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            List<ProductBySubCategModel?>? item = snapshot.data;
                            return  SizedBox(
                              height: 580.h,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(5.h),
                                  itemBuilder: (context, index) => Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(item[index]!.id);
                                          userData.write('add',item![index]!.id);
                                          // Get.to(ProductScreen(
                                          //   Cursal: CarouselSlider(
                                          //       options: CarouselOptions(
                                          //         height: 160.h,
                                          //
                                          //
                                          //         autoPlay: false,
                                          //         viewportFraction: .8.h,
                                          //         onPageChanged: (index, reason) {
                                          //           setState(() {
                                          //             counter1 = index;
                                          //           });
                                          //         },
                                          //         enlargeCenterPage: true,
                                          //
                                          //         autoPlayCurve:
                                          //         Curves.fastLinearToSlowEaseIn,
                                          //         pauseAutoPlayOnTouch: true,
                                          //         //enableInfiniteScroll: true,
                                          //         autoPlayAnimationDuration:
                                          //         Duration(milliseconds: 900),
                                          //         //  viewportFraction: .8,
                                          //       ),
                                          //       items: item[index]!.productPhotos.map((e) =>  Column(
                                          //         children: [
                                          //           InkWell(
                                          //             onTap: (){
                                          //               showDialog(
                                          //                 context: context,
                                          //                 builder:(context)=>
                                          //                     Dialog(
                                          //                       shape: RoundedRectangleBorder(
                                          //                           borderRadius: BorderRadius.circular(30)),
                                          //
                                          //                       child: Container(
                                          //                         height: 250.h,
                                          //                         width: 250.h,
                                          //
                                          //                         child: InteractiveViewer(
                                          //
                                          //                             clipBehavior: Clip.none,
                                          //                             child: Container(
                                          //                               width: double.infinity,
                                          //
                                          //
                                          //                               decoration: BoxDecoration(
                                          //                                   image: DecorationImage(
                                          //
                                          //
                                          //                                     image:  NetworkImage(
                                          //                                       'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                                          //                                     ),
                                          //                                   )
                                          //                               ),
                                          //                             )
                                          //                         ),
                                          //                       ),
                                          //
                                          //                     ),
                                          //
                                          //               );
                                          //             },
                                          //             child: Container(
                                          //               decoration: BoxDecoration(
                                          //                   borderRadius:
                                          //                   BorderRadius.circular(15.h),
                                          //                   image: DecorationImage(
                                          //
                                          //                     image: NetworkImage(
                                          //                       'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                                          //                     ),
                                          //                   )),
                                          //               height: 110.h,
                                          //               width: 300.h,
                                          //             ),
                                          //           ),
                                          //           Row(
                                          //             mainAxisAlignment:
                                          //             MainAxisAlignment.center,
                                          //             crossAxisAlignment:
                                          //             CrossAxisAlignment.end,
                                          //             children: [
                                          //               for (int i = 0; i < item[index]!.productPhotos.length; i++)
                                          //                 Container(
                                          //                   height: 6.h,
                                          //                   width: 6.h,
                                          //                   margin: EdgeInsets.symmetric(
                                          //                       horizontal: 3.h,
                                          //                       vertical: 10.h),
                                          //                   decoration: BoxDecoration(
                                          //                     color: counter1 == i
                                          //                         ? Color(0xff858583)
                                          //                         : Color(0xff014678),
                                          //                     shape: BoxShape.circle,
                                          //                   ),
                                          //                 ),
                                          //             ],
                                          //           ),
                                          //         ],
                                          //       )).toList() ),
                                          //   productModel:item[index]! ,
                                          //
                                          //   name: '${item[index]!.name}',
                                          //   price:
                                          //   '${item[index]!.price} رس',
                                          //   description:
                                          //   '${item[index]!.description}',
                                          //   features:
                                          //   '${item[index]!.features}',
                                          //   overAll:
                                          //   '${item[index]!.overAll}',
                                          //   img: ' ',  Count: item[index]!.productCount, Fav:  item[index]!.isFavorite==false?
                                          // InkWell(
                                          //   onTap: () {
                                          //     print( item[index]!.isFavorite);
                                          //     setState(() {
                                          //
                                          //       print( item[index]!.isFavorite);
                                          //       if( item[index]!.isFavorite==true){
                                          //         DelelteFavorite();
                                          //       }else{
                                          //         Favorite();
                                          //       }
                                          //     });
                                          //   },
                                          //   child: Container(
                                          //       height: 20.h,
                                          //       width: 20.h,
                                          //       decoration:
                                          //       BoxDecoration(
                                          //         color:
                                          //         Colors.white,
                                          //         boxShadow: [
                                          //           BoxShadow(
                                          //             color: Colors
                                          //                 .grey
                                          //                 .shade200,
                                          //             spreadRadius:
                                          //             1,
                                          //             blurRadius: 3,
                                          //             offset: Offset(
                                          //                 0,
                                          //                 1), // changes position of shadow
                                          //           ),
                                          //         ],
                                          //         borderRadius:
                                          //         BorderRadius
                                          //             .circular(
                                          //             5.r),
                                          //       ),
                                          //       child: Icon(
                                          //         item[index]!.isFavorite?  Icons.favorite: Icons.favorite_border_rounded,
                                          //         size: 19.h,
                                          //         color: Styles
                                          //             .defualtColor,
                                          //       )),
                                          // ):
                                          // InkWell(
                                          //   onTap: () {
                                          //     DelelteFavorite();
                                          //   },
                                          //   child: Container(
                                          //       height: 20.h,
                                          //       width: 20.h,
                                          //       decoration:
                                          //       BoxDecoration(
                                          //         color:
                                          //         Colors.white,
                                          //         boxShadow: [
                                          //           BoxShadow(
                                          //             color: Colors
                                          //                 .grey
                                          //                 .shade200,
                                          //             spreadRadius:
                                          //             1,
                                          //             blurRadius: 3,
                                          //             offset: Offset(
                                          //                 0,
                                          //                 1), // changes position of shadow
                                          //           ),
                                          //         ],
                                          //         borderRadius:
                                          //         BorderRadius
                                          //             .circular(
                                          //             5.r),
                                          //       ),
                                          //       child: Icon(
                                          //         Icons.favorite,
                                          //         size: 19.h,
                                          //         color: Styles
                                          //             .defualtColor,
                                          //       )),
                                          // ),
                                          // ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.h,
                                              vertical: 10.h),
                                          height: 110.h,
                                          width: double.infinity,
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
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image(

                                                      image: NetworkImage(
                                                          'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${item![index]!.photoName}'),


                                                      height: 80.h,
                                                      width: 80.h,
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
                                                            '${item![index]!.name}',
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
                                      )
                                    ],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      Gap(10.h),
                                  itemCount: item!.length),
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
            )
        ),
      ),
    );
  }
}
