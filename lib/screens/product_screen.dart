// import 'dart:convert';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get_storage/get_storage.dart';
// import 'dart:ui' as ui;
// import 'package:http/http.dart' as http;
// import '../components/app_style.dart';
// import '../models/product_all.dart';
// import '../models/product_by_SupCat_model.dart';
// import 'Shopping_cart_screen.dart';
// import 'bottomNav_screen.dart';
//
// class ProductScreen extends StatefulWidget {
//   String name;
//   String description;
//   String features;
//   String price;
//   String img;
//   String overAll;
//   int Count;
//    Widget Fav;
//   Widget Cursal;
//   ProductBySubCategModel productModel;
//
//   ProductScreen({
//     Key? key,
//     required this.name,
//     required this.price,
//     required this.description,
//     required this.features,
//     required this.overAll,
//     required this.img,
//      required this.Fav,
//     required this.Count,
//     required this.Cursal,
//    required this.productModel,
//   }) : super(key: key);
//
//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//
//   final userData = GetStorage();
//   bool isClick=true;
//   bool isClick2=false;
//   void Favorite(
//
//       ) async {
//     try {
//       var response = await http.post(
//           Uri.parse('http://eibtek2-001-site6.atempurl.com/api/CreateUserFavorites'),
//           headers: {
//             "Content-Type": "application/json",
//           },
//           body: jsonEncode({
//
//             "productId": userData.read('add'),
//             "applicationUserId": "${userData.read('token')}",
//
//           }));
//       var data = jsonDecode(response.body.toString());
//       if (response.statusCode == 200) {
//         print(data);
//
//         Fluttertoast.showToast(
//             msg: 'تمت الإضافة إلى المفضلة بنجاح',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       }
//       else {
//         print(response.reasonPhrase);
//       }
//
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//   void DelelteFavorite(
//
//       ) async {
//     try {
//       var request = http.Request('DELETE', Uri.parse('http://eibtek2-001-site6.atempurl.com/api/DeleteFaviourite?productId=${userData.read('add')}&applicationUserId=${userData.read('token')}'));
//
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         print(await response.stream.bytesToString());
//       }
//       else {
//         print(response.reasonPhrase);
//       }
//
//       //
//       // var response = await http.delete(
//       //     Uri.parse('http://eibtek2-001-site6.atempurl.com/api/DeleteFaviourite/${userData.read('delete')}'),
//       //     headers: {
//       //       "Content-Type": "application/json",
//       //     },
//       //  );
//       // var data = jsonDecode(response.body.toString());
//       // if (response.statusCode == 200) {
//       //   print(data);
//       //
//       //   //Get.offAll(BottomNavScreen());
//       //
//       //   Fluttertoast.showToast(
//       //       msg: 'تم الحذف من المفضلة بنجاح',
//       //       toastLength: Toast.LENGTH_SHORT,
//       //       gravity: ToastGravity.BOTTOM,
//       //       timeInSecForIosWeb: 1,
//       //       textColor: Colors.white,
//       //       fontSize: 16.0);
//       // }
//       // else {
//       //   print(response.reasonPhrase);
//       // }
//
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   int counter1 = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: ui.TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Styles.defualtColorWhite,
//         body: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             //alignment: Alignment.bottomCenter,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     alignment: Alignment.topCenter,
//                     height: 200.h,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(25.r),
//                           bottomRight: Radius.circular(25.r)),
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsets.only(left: 20.h, right: 20.h, top: 50.h),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                                 height: 20.h,
//                                 width: 20.h,
//                                 decoration: BoxDecoration(
//                                   color: Styles.defualtColorWhite,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.shade200,
//                                       spreadRadius: 1,
//                                       blurRadius: 3,
//                                       offset: Offset(
//                                           0, 1), // changes position of shadow
//                                     ),
//                                   ],
//                                   borderRadius: BorderRadius.circular(5.r),
//                                 ),
//                                 child: Icon(
//                                   Icons.keyboard_arrow_right_outlined,
//                                   size: 19.h,
//                                   color: Styles.defualtColor,
//                                 )),
//                           ),
//                           SizedBox(
//                             width: 248.h,
//                             child: widget.Cursal
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                           widget.Fav,
//                               // InkWell(
//                               //   onTap: () {
//                               //      // Favorite();
//                               //
//                               //      setState(() {
//                               //        isClick=!isClick;
//                               //        if(isClick==true){
//                               //          Favorite();
//                               //        }else{
//                               //          //DelelteFavorite();
//                               //        }
//                               //
//                               //      });
//                               //
//                               //
//                               //
//                               //
//                               //   },
//                               //   onLongPress: (){
//                               //  //   DelelteFavorite();
//                               //   },
//                               //   child: Container(
//                               //       height: 20.h,
//                               //       width: 20.h,
//                               //       decoration: BoxDecoration(
//                               //         color: Colors.white,
//                               //         boxShadow: [
//                               //           BoxShadow(
//                               //             color: Colors.grey.shade200,
//                               //             spreadRadius: 1,
//                               //             blurRadius: 3,
//                               //             offset: Offset(0,
//                               //                 1), // changes position of shadow
//                               //           ),
//                               //         ],
//                               //         borderRadius:
//                               //             BorderRadius.circular(5.r),
//                               //       ),
//                               //       child: Icon(isClick?Icons.favorite:
//                               //         Icons.favorite_border,
//                               //         size: 19.h,
//                               //         color: Styles.defualtColor,
//                               //       )),
//                               // ),
//                               Gap(10.h),
//                               InkWell(
//                                 onTap: () {
//
//                                 },
//                                 child: Container(
//                                     height: 20.h,
//                                     width: 20.h,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.shade200,
//                                           spreadRadius: 1,
//                                           blurRadius: 3,
//                                           offset: Offset(0,
//                                               1), // changes position of shadow
//                                         ),
//                                       ],
//                                       borderRadius:
//                                           BorderRadius.circular(5.r),
//                                     ),
//                                     child: Icon(
//                                       Icons.share,
//                                       size: 19.h,
//                                       color: Styles.defualtColor,
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20.h),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 280.h,
//                           child: Text(
//                          widget.name,
//                             style: TextStyle(fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         Gap(10.h),
//                         Text(
//                           widget.price,
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 15.sp),
//                         ),
//                         Gap(10.h),
//                         Container(
//                           height: 50.h,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: .1, color: Colors.grey.shade400)),
//                         ),
//                         Gap(10.h),
//                         Text(
//                           'وصف المنتج',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 15.sp),
//                         ),
//                         Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 5.r,
//                                   backgroundColor: Styles.defualtColorBlack,
//                                 ),
//                                 Gap(5.h),
//                                 SizedBox(
//                                   width: 270.h,
//                                   child: Text(
//                                     widget.description,
//                                     textAlign: TextAlign.start,
//                                     style: TextStyle(),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Gap(10.h),
//                           ],
//                         ),
//                         Gap(10.h),
//                         Text(
//                           'المميزات',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 15.sp),
//                         ),
//                         Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 5.r,
//                                   backgroundColor: Styles.defualtColorBlack,
//                                 ),
//                                 Gap(5.h),
//                                 SizedBox(
//                                   width: 270.h,
//                                   child: Text(
//                                     widget.features,
//                                     textAlign: TextAlign.start,
//                                     style: TextStyle(),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Gap(10.h),
//                           ],
//                         ),
//                         Gap(10.h),
//                         Text(
//                           'نظرة عامة',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 15.sp),
//                         ),
//                         SizedBox(
//                           width: 270.h,
//                           child: Text(
//                             widget.overAll,
//                             textAlign: TextAlign.start,
//                             style: TextStyle(),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   // Column(
//                   //   children: [
//                   //
//                   //     Padding(
//                   //         padding:  EdgeInsets.symmetric(horizontal: 0.h),
//                   //         child:  SizedBox(
//                   //           height: 200.h,
//                   //           //    width: 400.h,
//                   //           child: ListView.separated(
//                   //               padding: EdgeInsets.all(10.h),
//                   //               itemBuilder: (context,index)=>Center(
//                   //                 child: Row(
//                   //                   mainAxisAlignment: MainAxisAlignment.start,
//                   //                   crossAxisAlignment: CrossAxisAlignment.start,
//                   //                   children: [
//                   //                     CircleAvatar(
//                   //                       radius: 5.r,
//                   //                       backgroundColor: Styles.defualtColorBlack,
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 270.h,
//                   //                       child: Text(' Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrystandard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
//                   //
//                   //                         textAlign: TextAlign.start,
//                   //                         style: TextStyle(
//                   //
//                   //
//                   //                         ),
//                   //                       ),
//                   //                     )
//                   //                   ],
//                   //                 ),
//                   //               ),
//                   //               separatorBuilder: (context,index)=>Gap(20.h),
//                   //               itemCount: 4),
//                   //         )
//                   //     )
//                   //   ],
//                   // ),
//                 ],
//               ),
//               Container(
//                 height: 80.h,
//                 width: double.infinity,
//                 color: Styles.defualtColorWhite,
//                 padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () {
//
//                       },
//                       child: Container(
//                         height: 40.h,
//                         width: 70.h,
//                         padding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 3.h),
//                         decoration: BoxDecoration(
//
//                             borderRadius: BorderRadius.circular(5.r),
//                             border:   Border.all(color: Styles.defualtColor)
//                         ),
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               InkWell(
//                                 onTap: (){
//                                   setState(() {
//                                     widget.Count++;
//                                     print(widget.Count);
//                                     userData.write('Count', widget.Count);
//                                   });
//                                 },
//                                 child: Container(
//                                   width: 20.h,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade200,
//                                     borderRadius: BorderRadius.circular(10.r),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "+",
//                                       style: TextStyle(color: Styles.defualtColor),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Center(
//                                 child: Text(
//                                  '${ widget.Count}',
//                                   style: TextStyle(color: Styles.defualtColor),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: (){
//                                   if(widget.Count>1)
//                                   setState(() {
//                                     widget.Count--;
//                                     print(widget.Count);
//                                     userData.write('Count', widget.Count);
//                                   });
//                                 },
//                                 child: Container(
//                                   width: 20.h,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade200,
//                                     borderRadius: BorderRadius.circular(10.r),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "-",
//                                       style: TextStyle(color: Styles.defualtColor),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         print(cartList.length);
//                         userData.write('lenght', cartList.length);
//                         cartList.add(widget.productModel);
//                         // Fluttertoast.showToast(
//                         //     msg: 'تمت الإضافة إلى السلة بنجاح',
//                         //     toastLength: Toast.LENGTH_SHORT,
//                         //     gravity: ToastGravity.BOTTOM,
//                         //     timeInSecForIosWeb: 1,
//                         //     textColor: Colors.white,
//                         //     fontSize: 16.0);
//                         showModalBottomSheet(
//                             context: context,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(20),
//                               ),
//                             ),
//                             builder: (builder){
//                               return new Container(
//                                 height: 200.h,
//                                 color: Colors.transparent,
//                                 padding: EdgeInsets.all(10.h),
//                                 //could change this to Color(0xFF737373),
//                                 //so you don't have to change MaterialApp canvasColor
//                                 child: new Container(
//                                     decoration: new BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:   BorderRadius.only(
//                                             topLeft:   Radius.circular(10.0),
//                                             topRight:   Radius.circular(10.0))),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         new Center(
//                                           child: new Text('تمت الإضافة إلى السلة بنجاح',),
//                                         ),
//                                         Gap(20.h),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             InkWell(
//                                               onTap: (){
//                                                 Get.offAll(BottomNavScreen());
//                                               },
//                                               child: Container(
//                                                 height: 40.h,
//                                                 width:150.h,
//                                                 decoration: BoxDecoration(
//                                                   gradient: LinearGradient(
//                                                     begin: Alignment(.8.h, -.7.h),
//                                                     end: Alignment(0.8.h, 1.h),
//                                                     colors: [
//                                                       const Color(0xFFF2DA75),
//                                                       const Color(0xFFCDA748),
//                                                     ],
//                                                     stops: [0.0, 1.0],
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5.r),
//                                                 ),
//                                                 child: Center(
//                                                   child: Text(
//                                                     "الذهاب الي الصفحة الرئيسية",
//                                                     style: TextStyle(color: Styles.defualtColorWhite),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: (){
//                                                 Get.back();
//                                               },
//                                               child: Container(
//                                                 height: 40.h,
//                                                 width:150.h,
//                                                 decoration: BoxDecoration(
//                                                   gradient: LinearGradient(
//                                                     begin: Alignment(.8.h, -.7.h),
//                                                     end: Alignment(0.8.h, 1.h),
//                                                     colors: [
//                                                       const Color(0xFFF2DA75),
//                                                       const Color(0xFFCDA748),
//                                                     ],
//                                                     stops: [0.0, 1.0],
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5.r),
//                                                 ),
//                                                 child: Center(
//                                                   child: Text(
//                                                     "إختيار منتجات أخري",
//                                                     style: TextStyle(color: Styles.defualtColorWhite),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                               );
//                             }
//                         );
//
//
//                       },
//                       child: Container(
//                         height: 40.h,
//                         width:210.h,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment(.8.h, -.7.h),
//                             end: Alignment(0.8.h, 1.h),
//                             colors: [
//                               const Color(0xFFF2DA75),
//                               const Color(0xFFCDA748),
//                             ],
//                             stops: [0.0, 1.0],
//                           ),
//                           borderRadius: BorderRadius.circular(5.r),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "أضف الي السلة",
//                             style: TextStyle(color: Styles.defualtColorWhite),
//                           ),
//                         ),
//                       ),
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// List <ProductBySubCategModel?> cartList=[];
// // ProductBySubCategModel? productModel;
// // void increase ( ){
// //   productModel!.productCount++;
// //
// // }void decrease (ProductBySubCategModel productModel){
// //   if(productModel.productCount>1){
// //     productModel.productCount--;
// //   }
// //
// //
// // }