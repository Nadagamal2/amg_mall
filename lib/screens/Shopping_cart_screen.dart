import 'dart:convert';

import 'package:amg_store/screens/bottomNav_screen.dart';
import 'package:amg_store/screens/done_screen.dart';
import 'package:amg_store/screens/home_screen.dart';
import 'package:amg_store/screens/productHome.dart';
import 'package:amg_store/screens/product_fav_screen.dart';
import 'package:amg_store/screens/product_screen.dart';
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
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../components/app_style.dart';
import '../components/evaluated_Buttom.dart';
import '../components/ratingController.dart';
import '../model_categ/categList_model.dart';
import '../models/product_by_SupCat_model.dart';
import 'Complete_the_application.dart';
import 'EditProfileAddressScreen.dart';
import 'cart_done.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  List<double> sumOfProduct = [];
  List<double> sumOfProduct2 = [];
  int sum = 0;
  double getSumOfProduct({required List<double> prices}){
    double sum = 0.0;
    prices.forEach((element) { sum+=element;});
    return sum;
  }
  double testSum(){
    List<double> items =  [32000.0, 10500.0, 64000.0, 64000.0];
    double sum = 0.0;
    items.forEach((element) { sum+=element;});
    print(' sumn is $sum');
    return sum;
  }
  @override
  void initState() {
    testSum();
    super.initState();
  }
  // List data = [];
  // List <ProductBySubCategModel?>? cartList=[];
  // Future<List<ProductBySubCategModel?>?> getData4(int id) async {
  //   final response = await http.get(Uri.parse(
  //       'http://eibtek2-001-site6.atempurl.com/api/ProductApi/GetProductsBySubCategoryId?subcategoryId=${id}'));
  //   var data = jsonDecode(response.body.toString());
  //
  //   if (response.statusCode == 200) {
  //     // print(response.body);
  //
  //     List jsonData = (data);
  //     // print(jsonData);
  //     data=jsonData;
  //     cartList=data.map((e) => ProductBySubCategModel.fromJson(e)).toList();
  //     return cartList;
  //
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }
  final userData = GetStorage();
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
      padding: EdgeInsets.symmetric(horizontal: 1.h),
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

  void cart() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://eibtek2-001-site6.atempurl.com/api/SavedOrdersApi/Saved'));
    request.body = json.encode({
      "id": 0,
      "productId": userData.read('add'),
      "applicationUserId": '${userData.read('token')}',
      "quantity": userData.read('lenght'),
      "status": "لم يصل"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.offAll(CartDoneScreen());
      cartList = [];
      cartList2 = [];
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<List<OrderRecord>> getData4() async {
    final response = await http.post(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/CartItemApi/GetCartItemsByApplcationUserId?UserId=${userData.read('token')}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body);

      List jsonData = (data['orderRecord']);
      print(jsonData);
      return jsonData.map((Data) => OrderRecord.fromJson(Data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  void cart2() async {
    var response = await http.post(
        Uri.parse(
            'http://eibtek2-001-site6.atempurl.com/api/SavedOrdersApi/Saved'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          {
            "id": 0,
            "productid": userData.read('add'),
            "applicationUserId": '${userData.read('token')}',
            "quantity": userData.read('lenght'),
            "status": 'لم يصل'
          }
        }));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
    } else {
      print(response.reasonPhrase);
    }
  }

  bool isSelected = true;
  int counter1 = 0;
  void Favorite() async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://eibtek2-001-site6.atempurl.com/api/CreateUserFavorites'),
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
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void DelelteFavorite() async {
    try {
      var request = http.Request(
          'DELETE',
          Uri.parse(
              'http://eibtek2-001-site6.atempurl.com/api/DeleteFaviourite?productId=${userData.read('add')}&applicationUserId=${userData.read('token')}'));

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
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void DelelteCart() async {
    try {
      var request = http.Request(
          'DELETE',
          Uri.parse(
              'http://eibtek2-001-site6.atempurl.com/api/CartItemApi/DeleteFromCart?ApplicationUserId=${userData.read('token')}&CartItemId=${userData.read('cartId')}'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        Get.offAll(BottomNavScreen());

        Fluttertoast.showToast(
            msg: 'تم الحذف من السلة بنجاح',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.r),
                    bottomRight: Radius.circular(25.r)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 28.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                          height: 20.h,
                          width: 20.h,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 19.h,
                            color: Colors.transparent,
                          )),
                    ),
                    Text(
                      'سلة المشتريات',
                      style: TextStyle(
                        fontFamily: 'Tajawal2',
                        color: Styles.defualtColor2,
                        fontSize: 17.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          height: 20.h,
                          width: 20.h,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 19.h,
                            color: Colors.transparent,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Container(
                        height: 45.h,
                        width: double.infinity,
                        padding: EdgeInsets.all(5.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FluentSystemIcons.ic_fluent_location_regular,
                              color: Styles.defualtColor,
                            ),
                            Gap(10.h),
                            Text(
                              'توصيل الي : ${userData.read('Title')}',
                              style: TextStyle(fontSize: 11.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                    Gap(10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: MyElevatedButton(
                        width: double.infinity,
                        onPressed: () {
                          Get.to(EditProfileAddressScreen());
                        },
                        borderRadius: BorderRadius.circular(5.r),
                        child: Text(
                          "تعديل العنوان",
                        ),
                      ),
                    ),

                    Gap(20.h),
                    FutureBuilder<List<OrderRecord?>>(
                      future: getData4(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.error);
                          List<OrderRecord?>? item = snapshot.data;
                          return  item!.isEmpty?Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/No data-cuate (1).svg'),
                                Gap(15.h),
                                Text('سلة المشتريات فارغة',style: TextStyle(
                                  color: Styles.defualtColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                          ): Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: SizedBox(
                                  height: 300.h,
                                  child: ListView.separated(
                                      itemBuilder: (context, index)  {

                                        return InkWell(
                                          onTap: () {
                                            // print(item[index]!.id);
                                            // userData.write('add',item[index]!.id);
                                            // Get.to(ProductFavScreen(
                                            //
                                            //   // crsal:item[index]!.productPhotos.map((e) =>  Column(
                                            //   //   children: [
                                            //   //     InkWell(
                                            //   //       onTap: (){
                                            //   //         showDialog(
                                            //   //           context: context,
                                            //   //           builder:(context)=>
                                            //   //               Dialog(
                                            //   //                 shape: RoundedRectangleBorder(
                                            //   //                     borderRadius: BorderRadius.circular(30)),
                                            //   //
                                            //   //                 child: Container(
                                            //   //                   height: 250.h,
                                            //   //                   width: 250.h,
                                            //   //
                                            //   //                   child: InteractiveViewer(
                                            //   //
                                            //   //                       clipBehavior: Clip.none,
                                            //   //                       child: Container(
                                            //   //                         width: double.infinity,
                                            //   //
                                            //   //
                                            //   //                         decoration: BoxDecoration(
                                            //   //                             image: DecorationImage(
                                            //   //
                                            //   //
                                            //   //                               image:  NetworkImage(
                                            //   //                                 'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                                            //   //                               ),
                                            //   //                             )
                                            //   //                         ),
                                            //   //                       )
                                            //   //                   ),
                                            //   //                 ),
                                            //   //
                                            //   //               ),
                                            //   //
                                            //   //         );
                                            //   //       },
                                            //   //       child: Container(
                                            //   //         decoration: BoxDecoration(
                                            //   //             borderRadius:
                                            //   //             BorderRadius.circular(15.h),
                                            //   //             image: DecorationImage(
                                            //   //
                                            //   //               image: NetworkImage(
                                            //   //                 'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                                            //   //               ),
                                            //   //             )),
                                            //   //         height: 250.h,
                                            //   //         width: 300.h,
                                            //   //       ),
                                            //   //     ),
                                            //   //
                                            //   //   ],
                                            //   // )).toList(),
                                            //   crsal:null,
                                            //
                                            //
                                            //
                                            //   name: '${item[index]!.product!.name}',
                                            //   price:
                                            //   '${item[index]!.product!.price} رس',
                                            //   description:
                                            //   '${item[index]!.product!.description}',
                                            //   features:
                                            //   'null',
                                            //   overAll:
                                            //   '${item[index]!.product!.overAll}',
                                            //   img: ' ',    Fav:  FavoriteButton(
                                            //   iconColor: Styles.defualtColor,
                                            //   iconSize: 30.sp,
                                            //   isFavorite:  item[index]!.product!.isFavorite ,
                                            //   valueChanged: (val) {
                                            //     item[index]!.product!.isFavorite==false?
                                            //     Favorite():DelelteFavorite();
                                            //     val==item[index]!.product!.isFavorite;
                                            //   },
                                            // ),
                                            // ));



                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.h, vertical: 10.h),
                                            height: 110.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Styles.defualtColorWhite,
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                  Colors.grey.withOpacity(.2),
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
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image(
                                                        image: NetworkImage(
                                                            'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${item[index]!.product!.photoName}'),
                                                        height: 80.h,
                                                        width: 80.h,
                                                      ),
                                                      Gap(10.h),
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
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
                                                                  '${item[index]!.product!.name}',
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
                                                              Gap(3.h),
                                                              // Row(
                                                              //   children: [
                                                              //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                                                              //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                                                              //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                                                              //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                                                              //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                                                              //     Text('(4.5)',style: TextStyle(
                                                              //         fontSize: 11.sp,
                                                              //         color: Styles.defualtColor
                                                              //
                                                              //     ),)
                                                              //   ],
                                                              // ),
                                                              Text(
                                                                '${item[index]!.product!.price} رس',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    fontSize: 11.sp),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Container(
                                                                height: 20.h,
                                                                width: 50.h,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.grey.shade200,
                                                                  borderRadius: BorderRadius.circular(5.r),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    '${item[index]!.quantity} منتج ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                        fontSize: 11.sp),
                                                                  ),
                                                                ),
                                                              ),
                                                              Gap(70.h),
                                                              InkWell(
                                                                onTap: (){
                                                                  print(item[index]!.id);
                                                                  userData.write(
                                                                      'cartId', item[index]!.id);
                                                                  showModalBottomSheet(
                                                                      context: context,
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius.vertical(
                                                                          top: Radius.circular(20),
                                                                        ),
                                                                      ),
                                                                      builder: (builder) {
                                                                        return new Container(
                                                                          height: 200.h,
                                                                          color: Colors.transparent,
                                                                          padding: EdgeInsets.all(10.h),
                                                                          //could change this to Color(0xFF737373),
                                                                          //so you don't have to change MaterialApp canvasColor
                                                                          child: new Container(
                                                                              decoration: new BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius:
                                                                                  BorderRadius.only(
                                                                                      topLeft: Radius
                                                                                          .circular(
                                                                                          10.0),
                                                                                      topRight: Radius
                                                                                          .circular(
                                                                                          10.0))),
                                                                              child: Column(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .center,
                                                                                children: [
                                                                                  new Center(
                                                                                    child: new Text(
                                                                                      '',
                                                                                    ),
                                                                                  ),
                                                                                  Gap(20.h),
                                                                                  Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment
                                                                                        .spaceBetween,
                                                                                    children: [
                                                                                      MyElevatedButton(
                                                                                        width: 150.h,
                                                                                        onPressed: () {
                                                                                          DelelteCart();
                                                                                        },
                                                                                        borderRadius:
                                                                                        BorderRadius
                                                                                            .circular(
                                                                                            5.r),
                                                                                        child: Text(
                                                                                          "حذف",
                                                                                          style: TextStyle(
                                                                                              fontSize:
                                                                                              10.h),
                                                                                        ),
                                                                                      ),
                                                                                      MyElevatedButton(
                                                                                        width: 150.h,
                                                                                        onPressed: () {
                                                                                          Get.back();
                                                                                        },
                                                                                        borderRadius:
                                                                                        BorderRadius
                                                                                            .circular(
                                                                                            5.r),
                                                                                        child: Text(
                                                                                          "الغاء",
                                                                                        ),
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
                                                                      });
                                                                },
                                                                child: Container(
                                                                    height: 20.h,
                                                                    width: 50.h,
                                                                    decoration: BoxDecoration(

                                                                      color: Colors.red.shade50,
                                                                      borderRadius: BorderRadius.circular(5.r),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        Icon(Icons.delete,
                                                                            size: 13.h, color: Colors.red),
                                                                        Gap(2.h),
                                                                        Text('حذف',style: TextStyle(
                                                                          color: Colors.red,
                                                                          fontSize: 10.h,
                                                                        ),)
                                                                      ],
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  // Column(
                                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  //   crossAxisAlignment: CrossAxisAlignment.end,
                                                  //   children: [
                                                  //     InkWell(
                                                  //       onTap: () {
                                                  //         setState(() {
                                                  //
                                                  //           // cartList.removeWhere((element) => element!.id==e.id);
                                                  //         });
                                                  //         print(cartList.length);
                                                  //
                                                  //       },
                                                  //       child: Container(
                                                  //           height: 20.h,
                                                  //           width: 50.h,
                                                  //           decoration: BoxDecoration(
                                                  //
                                                  //             color: Colors.red.shade50,
                                                  //             borderRadius: BorderRadius.circular(5.r),
                                                  //           ),
                                                  //           child: Row(
                                                  //             mainAxisAlignment: MainAxisAlignment.center,
                                                  //             crossAxisAlignment: CrossAxisAlignment.center,
                                                  //             children: [
                                                  //               Icon(Icons.delete,
                                                  //                   size: 13.h, color: Colors.red),
                                                  //               Gap(2.h),
                                                  //               Text('حذف',style: TextStyle(
                                                  //                 color: Colors.red,
                                                  //                 fontSize: 10.h,
                                                  //               ),)
                                                  //             ],
                                                  //           )),
                                                  //     ),
                                                  //
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Gap(15.h),
                                      itemCount: item!.length),
                                ),
                              ),
                              FutureBuilder (
                                  future: getData4(),
                                  builder: (context, snapshot){
                                    if (snapshot.hasData) {
                                      for(var i =0; i<snapshot.data!.length;i++){
                                        sumOfProduct.add(snapshot.data![i].totalPriceOfProduct);
                                        print(sumOfProduct);
                                      }




                                      return  SizedBox(
                                        height: 300.h,
                                        child: ListView.builder(
                                            padding: EdgeInsets.all(5.h),
                                            itemCount:1,
                                            itemBuilder: (context, index) {

                                              // print('tola sum is $sumOfProduct');
                                              return Column(children: [
                                                Column(
                                                  children: [
                                                    Gap(10.h),
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.symmetric(horizontal: 20.h),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            'السعر الكلي',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w600),
                                                          ),
                                                          Text(
                                                            '${sumOfProduct.reduce((val1, val2) => val1 + val2)}',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.green),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Gap(10.h),
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.symmetric(horizontal: 20.h),
                                                      child: MyElevatedButton(
                                                        width: double.infinity,
                                                        onPressed: () {
                                                         Get.to(CompleteTheApplicationScreen());
                                                          print(sumOfProduct.reduce((val1, val2) => val1 + val2));
                                                          userData.write('totalPrice', sumOfProduct.reduce((val1, val2) => val1 + val2));
                                                        },
                                                        borderRadius: BorderRadius.circular(5.r),
                                                        child: Text(
                                                          "إتمام الطلب ؟",
                                                        ),
                                                      ),
                                                    ),
                                                    Gap(30.h),
                                                  ],
                                                ),
                                              ]);
                                            }
                                        ),
                                      );
                                    }
                                    else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.transparent),
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.transparent),
                            ),
                          );
                        }
                      },
                    ),
                    // userData.read('fav')==true?
                    // FutureBuilder<List<OrderRecord?>>(
                    //   future: getData4(),
                    //    builder: (context,snapshot){
                    //     if(snapshot.hasData){
                    //       List<OrderRecord?>? item = snapshot.data;
                    //       return Padding(
                    //         padding:   EdgeInsets.symmetric(horizontal: 20.h),
                    //         child: SizedBox(
                    //           height: 300.h,
                    //           child: ListView.separated(
                    //               itemBuilder: (context,index)=> InkWell(
                    //                 onTap: (){
                    //                   print(item[index]!.id);
                    //                   userData.write('add',item[index]!.id);
                    //                   Get.to(ProductFavScreen(
                    //
                    //                     // crsal:item[index]!.productPhotos.map((e) =>  Column(
                    //                     //   children: [
                    //                     //     InkWell(
                    //                     //       onTap: (){
                    //                     //         showDialog(
                    //                     //           context: context,
                    //                     //           builder:(context)=>
                    //                     //               Dialog(
                    //                     //                 shape: RoundedRectangleBorder(
                    //                     //                     borderRadius: BorderRadius.circular(30)),
                    //                     //
                    //                     //                 child: Container(
                    //                     //                   height: 250.h,
                    //                     //                   width: 250.h,
                    //                     //
                    //                     //                   child: InteractiveViewer(
                    //                     //
                    //                     //                       clipBehavior: Clip.none,
                    //                     //                       child: Container(
                    //                     //                         width: double.infinity,
                    //                     //
                    //                     //
                    //                     //                         decoration: BoxDecoration(
                    //                     //                             image: DecorationImage(
                    //                     //
                    //                     //
                    //                     //                               image:  NetworkImage(
                    //                     //                                 'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                    //                     //                               ),
                    //                     //                             )
                    //                     //                         ),
                    //                     //                       )
                    //                     //                   ),
                    //                     //                 ),
                    //                     //
                    //                     //               ),
                    //                     //
                    //                     //         );
                    //                     //       },
                    //                     //       child: Container(
                    //                     //         decoration: BoxDecoration(
                    //                     //             borderRadius:
                    //                     //             BorderRadius.circular(15.h),
                    //                     //             image: DecorationImage(
                    //                     //
                    //                     //               image: NetworkImage(
                    //                     //                 'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                    //                     //               ),
                    //                     //             )),
                    //                     //         height: 250.h,
                    //                     //         width: 300.h,
                    //                     //       ),
                    //                     //     ),
                    //                     //
                    //                     //   ],
                    //                     // )).toList(),
                    //                     crsal:null,
                    //
                    //
                    //
                    //                     name: '${item[index]!.product!.name}',
                    //                     price:
                    //                     '${item[index]!.product!.price} رس',
                    //                     description:
                    //                     '${item[index]!.product!.description}',
                    //                     features:
                    //                     'null',
                    //                     overAll:
                    //                     '${item[index]!.product!.overAll}',
                    //                     img: ' ',    Fav:  FavoriteButton(
                    //                     iconColor: Styles.defualtColor,
                    //                     iconSize: 30.sp,
                    //                     isFavorite:  item[index]!.product!.isFavorite ,
                    //                     valueChanged: (val) {
                    //                       item[index]!.product!.isFavorite==false?
                    //                       Favorite():DelelteFavorite();
                    //                       val==item[index]!.product!.isFavorite;
                    //                     },
                    //                   ),
                    //                   ));
                    //                 },
                    //                 child: Container(
                    //                   padding: EdgeInsets.symmetric(
                    //                       horizontal: 10.h, vertical: 10.h),
                    //                   height: 110.h,
                    //                   width: double.infinity,
                    //                   decoration: BoxDecoration(
                    //                     color: Styles.defualtColorWhite,
                    //                     boxShadow: [
                    //                       BoxShadow(
                    //                         color:
                    //                         Colors.grey.withOpacity(.2),
                    //                         spreadRadius: 1,
                    //                         blurRadius: 7,
                    //                         offset: Offset(0,
                    //                             3), // changes position of shadow
                    //                       ),
                    //                     ],
                    //                     borderRadius:
                    //                     BorderRadius.circular(5.h),
                    //                   ),
                    //                   child: Center(
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                       crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                       children: [
                    //                         Row(
                    //                           children: [
                    //                             Image(image: NetworkImage(
                    //                                 'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${item[index]!.product!.photoName}'),
                    //
                    //                               height: 80.h,
                    //                               width: 80.h,),
                    //                             Gap(10.h),
                    //                             Column(
                    //                               mainAxisAlignment: MainAxisAlignment.start,
                    //                               crossAxisAlignment: CrossAxisAlignment.start,
                    //                               children: [
                    //                                 SizedBox(
                    //                                   width:100.h,
                    //                                   child: Text('${item[index]!.product!.name}',
                    //                                     maxLines: 2,
                    //                                     overflow: TextOverflow.ellipsis,
                    //                                     style: TextStyle(
                    //                                         fontWeight: FontWeight.w600
                    //                                     ),),
                    //                                 ),
                    //                                 Gap(3.h),
                    //                                 // Row(
                    //                                 //   children: [
                    //                                 //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                                 //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                                 //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                                 //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                                 //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                                 //     Text('(4.5)',style: TextStyle(
                    //                                 //         fontSize: 11.sp,
                    //                                 //         color: Styles.defualtColor
                    //                                 //
                    //                                 //     ),)
                    //                                 //   ],
                    //                                 // ),
                    //                                 Text('${item[index]!.product!.price} رس',style: TextStyle(
                    //                                     fontWeight: FontWeight.w600,
                    //                                     fontSize: 11.sp
                    //                                 ),),
                    //                               ],
                    //                             ),
                    //                           ],
                    //                         ),
                    //                         Column(
                    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                           crossAxisAlignment: CrossAxisAlignment.end,
                    //                           children: [
                    //                             InkWell(
                    //                               onTap: () {
                    //                                 setState(() {
                    //
                    //                                   // cartList.removeWhere((element) => element!.id==e.id);
                    //                                 });
                    //                                 print(cartList.length);
                    //
                    //                               },
                    //                               child: Container(
                    //                                   height: 20.h,
                    //                                   width: 50.h,
                    //                                   decoration: BoxDecoration(
                    //
                    //                                     color: Colors.red.shade50,
                    //                                     borderRadius: BorderRadius.circular(5.r),
                    //                                   ),
                    //                                   child: Row(
                    //                                     mainAxisAlignment: MainAxisAlignment.center,
                    //                                     crossAxisAlignment: CrossAxisAlignment.center,
                    //                                     children: [
                    //                                       Icon(Icons.delete,
                    //                                           size: 13.h, color: Colors.red),
                    //                                       Gap(2.h),
                    //                                       Text('حذف',style: TextStyle(
                    //                                         color: Colors.red,
                    //                                         fontSize: 10.h,
                    //                                       ),)
                    //                                     ],
                    //                                   )),
                    //                             ),
                    //
                    //                           ],
                    //                         ),
                    //
                    //
                    //
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               separatorBuilder: (context,index)=>Gap(15.h),
                    //               itemCount: item!.length),
                    //         ),
                    //       );
                    //     }else {
                    //       return Center(
                    //         child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Colors.transparent),),
                    //       );
                    //     }
                    //    },
                    // ):
                    // Padding(
                    //   padding:   EdgeInsets.symmetric(horizontal: 20.h),
                    //   child: Container(
                    //     color: Colors.white,
                    //
                    //     child: Column(
                    //       mainAxisAlignment:
                    //       MainAxisAlignment.spaceBetween,
                    //       children:  cartList.map((e) =>   Column(
                    //         children: [
                    //           InkWell(
                    //             onTap: (){
                    //               print(e!.id);
                    //               userData.write('add',e.id);
                    //               Get.to(ProductHomeScreen(
                    //                 Cursal:e.productPhotos!.map((e) =>  Column(
                    //                   children: [
                    //                     InkWell(
                    //                       onTap: (){
                    //                         showDialog(
                    //                           context: context,
                    //                           builder:(context)=>
                    //                               Dialog(
                    //                                 shape: RoundedRectangleBorder(
                    //                                     borderRadius: BorderRadius.circular(30)),
                    //
                    //                                 child: Container(
                    //                                   height: 250.h,
                    //                                   width: 250.h,
                    //
                    //                                   child: InteractiveViewer(
                    //
                    //                                       clipBehavior: Clip.none,
                    //                                       child: Container(
                    //                                         width: double.infinity,
                    //
                    //
                    //                                         decoration: BoxDecoration(
                    //                                             image: DecorationImage(
                    //
                    //
                    //                                               image:  NetworkImage(
                    //                                                 'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                    //                                               ),
                    //                                             )
                    //                                         ),
                    //                                       )
                    //                                   ),
                    //                                 ),
                    //
                    //                               ),
                    //
                    //                         );
                    //                       },
                    //                       child: Container(
                    //                         decoration: BoxDecoration(
                    //                             borderRadius:
                    //                             BorderRadius.circular(15.h),
                    //                             image: DecorationImage(
                    //
                    //                               image: NetworkImage(
                    //                                 'http://eibtek2-001-site6.atempurl.com/Files/LastProductPhotos/${e.imgUrl}',
                    //                               ),
                    //                             )),
                    //                         height: 250.h,
                    //                         width: 300.h,
                    //                       ),
                    //                     ),
                    //
                    //                   ],
                    //                 )).toList(),
                    //                 productModelHome:e ,
                    //
                    //                 name: '${e.name}',
                    //                 price:
                    //                 '${e.price} رس',
                    //                 description:
                    //                 '${e.description}',
                    //                 features:
                    //                 '${e.features}',
                    //                 overAll:
                    //                 '${e.overAll}',
                    //                 img: '',  Count: e.productCount, Fav:  FavoriteButton(
                    //                 iconColor: Styles.defualtColor,
                    //                 iconSize: 30.sp,
                    //                 isFavorite:  e.isFavorite ,
                    //                 valueChanged: (val) {
                    //                   e.isFavorite==false?
                    //                   Favorite():DelelteFavorite();
                    //                   val==e.isFavorite;
                    //                 },
                    //               ),
                    //               ));
                    //             },
                    //             child: Container(
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: 10.h, vertical: 10.h),
                    //               height: 110.h,
                    //               width: double.infinity,
                    //               decoration: BoxDecoration(
                    //                 color: Styles.defualtColorWhite,
                    //                 boxShadow: [
                    //                   BoxShadow(
                    //                     color:
                    //                     Colors.grey.withOpacity(.2),
                    //                     spreadRadius: 1,
                    //                     blurRadius: 7,
                    //                     offset: Offset(0,
                    //                         3), // changes position of shadow
                    //                   ),
                    //                 ],
                    //                 borderRadius:
                    //                 BorderRadius.circular(5.h),
                    //               ),
                    //               child: Center(
                    //                 child: Row(
                    //                   mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //                   crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //                   children: [
                    //                     Row(
                    //                       children: [
                    //                         Image(image: NetworkImage(
                    //                             'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${e!.photoName}'),
                    //
                    //                           height: 80.h,
                    //                           width: 80.h,),
                    //                         Gap(10.h),
                    //                         Column(
                    //                           mainAxisAlignment: MainAxisAlignment.start,
                    //                           crossAxisAlignment: CrossAxisAlignment.start,
                    //                           children: [
                    //                             SizedBox(
                    //                               width:100.h,
                    //                               child: Text('${e!.name}',
                    //                                 maxLines: 2,
                    //                                 overflow: TextOverflow.ellipsis,
                    //                                 style: TextStyle(
                    //                                     fontWeight: FontWeight.w600
                    //                                 ),),
                    //                             ),
                    //                             Gap(3.h),
                    //                             // Row(
                    //                             //   children: [
                    //                             //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                             //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                             //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                             //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                             //     Icon(FluentSystemIcons.ic_fluent_star_regular,color: Styles.defualtColor,size: 15.sp,),
                    //                             //     Text('(4.5)',style: TextStyle(
                    //                             //         fontSize: 11.sp,
                    //                             //         color: Styles.defualtColor
                    //                             //
                    //                             //     ),)
                    //                             //   ],
                    //                             // ),
                    //                             Text('${e.price} رس',style: TextStyle(
                    //                                 fontWeight: FontWeight.w600,
                    //                                 fontSize: 11.sp
                    //                             ),),
                    //                           ],
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     Column(
                    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                       crossAxisAlignment: CrossAxisAlignment.end,
                    //                       children: [
                    //                         InkWell(
                    //                           onTap: () {
                    //                             setState(() {
                    //
                    //                               cartList.removeWhere((element) => element!.id==e.id);
                    //                             });
                    //                             print(cartList.length);
                    //
                    //                           },
                    //                           child: Container(
                    //                               height: 20.h,
                    //                               width: 50.h,
                    //                               decoration: BoxDecoration(
                    //
                    //                                 color: Colors.red.shade50,
                    //                                 borderRadius: BorderRadius.circular(5.r),
                    //                               ),
                    //                               child: Row(
                    //                                 mainAxisAlignment: MainAxisAlignment.center,
                    //                                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                                 children: [
                    //                                   Icon(Icons.delete,
                    //                                       size: 13.h, color: Colors.red),
                    //                                   Gap(2.h),
                    //                                   Text('حذف',style: TextStyle(
                    //                                     color: Colors.red,
                    //                                     fontSize: 10.h,
                    //                                   ),)
                    //                                 ],
                    //                               )),
                    //                         ),
                    //
                    //                       ],
                    //                     ),
                    //
                    //
                    //
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           Gap(15.h),
                    //         ],
                    //       )).toList(),
                    //     ),
                    //
                    //   ),
                    // ),
                    Gap(10.h),
                  //  Text('${getSumOfProduct(prices: s)}')
                    //      Padding(
                    //       padding:   EdgeInsets.symmetric(horizontal: 20.h),
                    //       child: Stack(
                    //         alignment: Alignment.centerLeft,
                    //         children: [
                    //           TextFormField(
                    //             validator: (String? val) {
                    //               if (val!.isEmpty) {
                    //                 return " ";
                    //               }
                    //             },
                    //             cursorColor: Colors.grey.shade400,
                    //             keyboardType: TextInputType.text,
                    //             // controller: passwordController,
                    //             decoration: InputDecoration(
                    //               floatingLabelBehavior:
                    //               FloatingLabelBehavior.never,
                    //               contentPadding: EdgeInsets.symmetric(
                    //                   vertical: 3.h, horizontal: 15.h),
                    //               filled: true,
                    //               fillColor: Colors.grey.shade200,
                    //
                    //
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                     width: .1.r, color: Colors.transparent),
                    //                 borderRadius: BorderRadius.circular(5.r),
                    //               ),
                    //               border: OutlineInputBorder(),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                     width: .1.r, color: Colors.transparent),
                    //                 borderRadius: BorderRadius.circular(5.r),
                    //               ),
                    //               labelText: "ادخل كود الخصم",
                    //               hintText: "ادخل كود الخصم",
                    //               labelStyle: TextStyle(
                    //                   fontFamily: 'Tajawal7',
                    //                   fontSize: 13.sp,
                    //                   color: Colors.grey.shade400),
                    //               hintStyle: TextStyle(
                    //                   fontSize: 13.sp,
                    //                   fontFamily: 'Tajawal7',
                    //                   color: Colors.grey.shade400),
                    //             ),
                    //           ),
                    //           TextButton(onPressed: () {  }, child: Text(
                    //             'تفعيل',style: TextStyle(
                    //             color: Colors.green,
                    //             fontWeight: FontWeight.w600
                    //           ),
                    //           ), )
                    //         ],
                    //       ),
                    // ),
                  ],
                ),

                // SizedBox(
                //   height: 150.h,
                //   child: ListView.separated(
                //     padding: EdgeInsets.all(5.h),
                //     itemBuilder: (context, index) =>
                //         FutureBuilder<List<OrderRecord?>>(
                //       future: getData4(),
                //       builder: (context, snapsot) {
                //         if (snapsot.hasData) {
                //           print(snapsot.error);
                //
                //           List<OrderRecord?>? item = snapsot.data;
                //           // sumOfProduct.add(item![0]!.totalPriceOfProduct);
                //
                //           sumOfProduct.add(item![index]!.totalPriceOfProduct);
                //
                //           print(sumOfProduct);
                //           // print(sumOfProduct.reduce( (val1,val2)=> val1 + val2));
                //           // print(sumOfProduct);
                //
                //           return Column(children: [
                //             Column(
                //               children: [
                //                 Gap(10.h),
                //                 Padding(
                //                   padding:
                //                       EdgeInsets.symmetric(horizontal: 20.h),
                //                   child: Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Text(
                //                         'السعر الكلي',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.w600),
                //                       ),
                //                       Text(
                //                         '${sumOfProduct.reduce((val1, val2) => val1 + val2)}',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.w600,
                //                             color: Colors.green),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 Gap(10.h),
                //                 Padding(
                //                   padding:
                //                       EdgeInsets.symmetric(horizontal: 20.h),
                //                   child: MyElevatedButton(
                //                     width: double.infinity,
                //                     onPressed: () {
                //                       Get.to(CompleteTheApplicationScreen());
                //                     },
                //                     borderRadius: BorderRadius.circular(5.r),
                //                     child: Text(
                //                       "إتمام الطلب ؟",
                //                     ),
                //                   ),
                //                 ),
                //                 Gap(30.h),
                //               ],
                //             ),
                //           ]);
                //         } else {
                //           return Center(
                //             child: CircularProgressIndicator(
                //               valueColor: AlwaysStoppedAnimation<Color>(
                //                   Colors.transparent),
                //             ),
                //           );
                //         }
                //       },
                //     ),
                //     separatorBuilder: (BuildContext context, int index) {
                //       return Gap(0);
                //     },
                //     itemCount: 1,
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
