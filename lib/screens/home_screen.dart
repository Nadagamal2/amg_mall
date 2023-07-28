import 'dart:convert';

import 'package:amg_store/screens/productHome.dart';
import 'package:amg_store/screens/product_by_subCateg_screen.dart';
import 'package:amg_store/screens/product_subCategHome_screen.dart';
import 'package:amg_store/screens/search.dart';
 import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../components/app_style.dart';
import '../components/ratingController.dart';
import '../model_categ/product_by_sub_categ_home.dart';
import '../model_categ/sub_Categ_home.dart';
import '../models/TheBestCategoriesHome.dart';
import '../models/product-subcateg-home.dart';

import '../models/slider1.dart';
import '../models/slider2.dart';

import 'bottomNav_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<ProductSubCategHomeModel>> getData5(String userId,String subId) async {
    final response = await http.post(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/ProductApi/GetAllBySubCategoryId ?ApplicationUserId=${userId}&CategoryId=${subId}'));
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

  int counter1 = 0;
  Future<List<Slider1>> getData() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/Slider1Api/GetAll'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(response.body);
      // print(data);
      List jsonData = (data);
      return jsonData.map((Data) => Slider1.fromJson(Data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Slider2>> getData3() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/Slider2Api/GetAll'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(response.body);
      // print(data);
      List jsonData = (data);
      return jsonData.map((Data) => Slider2.fromJson(Data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
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



    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<SubCategHomeModel>> getData2() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/SubCategoryApi/GetAll'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(response.body);
      // print(data);
      List jsonData = (data);
      return jsonData
          .map((Data) => SubCategHomeModel.fromJson(Data))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<ProductSubCategHomeModel>> getData4(int id) async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/ProductApi/GetProductsBySubCategoryId?subcategoryId=${id}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(response.body);

      List jsonData = (data);
      // print(jsonData);
      return jsonData
          .map((Data) => ProductSubCategHomeModel.fromJson(Data))
          .toList();
    } else {
      throw Exception('Failed to load album');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defualtColorWhite,
      body: Center(
          child: SingleChildScrollView(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h, left: 20.h, right: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'أهلاً ${userData.read('Name')} ',
                        style: TextStyle(
                            fontSize: 16.h, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "نتمنى لك يوم سعيد",
                        style: TextStyle(
                          fontSize: 13.h,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showSearch(context: context, delegate: search());

                        },
                        child: Container(
                            height: 38.h,
                            width: 38.h,
                            decoration: BoxDecoration(
                              color: Styles.defualtColorWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Icon(
                              Icons.search,
                              size: 24.h,
                            )),
                      ),
                      Gap(10.h),

                      InkWell(
                        onTap: () {
                          Get.to(NotificationScreen());
                        },
                        child: Container(
                            height: 38.h,
                            width: 38.h,
                            decoration: BoxDecoration(
                              color: Styles.defualtColorWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Icon(
                              Icons.notifications,
                              size: 24.h,
                            )),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Gap(5.h),
            SizedBox(
              height: 530.h,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    FutureBuilder<List<Slider1?>>(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Slider1?>? item = snapshot.data;
                          return CarouselSlider(
                              options: CarouselOptions(
                                height: 110.h,

                                autoPlay: true,
                                viewportFraction: .91.h,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    counter1 = index;
                                  });
                                },
                                enlargeCenterPage: true,

                                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                pauseAutoPlayOnTouch: true,
                                //enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 900),
                                //  viewportFraction: .8,
                              ),
                              items: item!
                                  .map(
                                    (e) => Container(
                                        height: 110.h,
                                        width: double.infinity,
                                        //   padding: EdgeInsets.symmetric(horizontal: 15.h,vertical: 10.h),
                                        decoration: BoxDecoration(
                                          //   color: Colors.red,
                                          gradient: LinearGradient(
                                            begin: Alignment(.8.h, -.7.h),
                                            end: Alignment(0.8.h, 1.h),
                                            colors: [
                                              const Color(0xFF160E24),
                                              const Color(0xFF442B6D),
                                            ],
                                            stops: [0.0, 1.0],
                                          ),
                                        ),
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${e!.photoName}'),
                                        )),
                                  )
                                  .toList());
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Styles.defualtColor),
                            ),
                          );
                        }
                      },
                    ),

                    // Container(
                    //   height: 110.h,
                    //   width: double.infinity,
                    //   padding: EdgeInsets.symmetric(horizontal: 15.h,vertical: 10.h),
                    //   decoration: BoxDecoration(
                    //  //   color: Colors.red,
                    //     gradient: LinearGradient(
                    //       begin: Alignment(.8.h, -.7.h),
                    //       end: Alignment(0.8.h, 1.h),
                    //       colors: [
                    //         const Color(0xFF160E24),
                    //         const Color(0xFF442B6D),
                    //       ],
                    //
                    //       stops: [0.0, 1.0],
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //          mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Flexible(
                    //             child: SizedBox(
                    //               width:195.h,
                    //               height: 45.h,
                    //               child: Text('أفضل الأسعار علي الإلكترونيات والإكسسوارات',
                    //
                    //                maxLines: 2,
                    //                 overflow: TextOverflow.fade,
                    //                 style: TextStyle(
                    //                   height: 1.1.h,
                    //                   color: Styles.defualtColorWhite,
                    //                   fontSize: 16.sp,
                    //                   fontWeight: FontWeight.w600
                    //                 ),
                    //
                    //
                    //               ),
                    //             ),
                    //           ),
                    //           Gap(3.h),
                    //           Container(
                    //             height: 16.h,
                    //             width: 80.h,
                    //             decoration: BoxDecoration(
                    //               color: Color(0xffBA81BE),
                    //             ),
                    //             child: Center(
                    //               child: Text('خصم حتي 20 %',style: TextStyle(
                    //                 color: Styles.defualtColorWhite,
                    //                 fontSize: 12.sp
                    //               ),),
                    //             ),
                    //           ),
                    //           Gap(5.h),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               Icon(Icons.delivery_dining_outlined,size: 18.sp,color: Styles.defualtColorWhite,),
                    //               Gap(3.h),
                    //               SizedBox(
                    //                 height: 22.h,
                    //                 width: 60.h,
                    //                 child: Text('توصيل مجاني عند أول عملية شراء',style: TextStyle(
                    //                   color: Styles.defualtColorWhite,
                    //                   height: 1.h,
                    //                   fontSize: 8.h,
                    //                 ),),
                    //               ),
                    //               Gap(5.h),
                    //               Icon(FluentSystemIcons.ic_fluent_payment_regular,size: 18.sp,color: Styles.defualtColorWhite,),
                    //               Gap(3.h),
                    //               Text('الدفع عند الإستلام',style: TextStyle(
                    //                 color: Styles.defualtColorWhite,
                    //                 height: 1.h,
                    //                 fontSize: 8.h,
                    //               ),),
                    //
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //
                    //       Image(image: AssetImage('assets/Secure data-pana.png'),
                    //
                    //         height: 100.h,
                    //         width: 100.h,),
                    //
                    //     ],
                    //   ),
                    // ),
                    Gap(5.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15.h, right: 15.h, top: 5.h),
                          child: Row(
                            children: [
                              Text('أفضل الفئات :'),
                            ],
                          ),
                        ),
                        Gap(10.h),


                        FutureBuilder<List<SubCategHomeModel?>>(
                          future: getData2(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<SubCategHomeModel?>? item = snapshot.data;
                              return SizedBox(
                                height: 200.h,

                                child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    physics: const ClampingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5,
                                    children: item!.map((e) => InkWell(
                                      onTap: (){
                                        print(e!.id);
                                        userData.write('subCategId', e.id);
                                        Get.to(ProductBySubCageHomecScreen(name: '${e.name}',));
                                      },
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 70.h,
                                                width: 70.h,
                                                decoration: BoxDecoration(
                                                    color: Styles
                                                        .defualtColorWhite,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .grey.shade100,
                                                        blurRadius: 6,
                                                        spreadRadius: 2,
                                                        offset: Offset(0, 3),
                                                      ),
                                                    ],
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${e!.photoName}'),
                                                    )),
                                              ),
                                              Gap(3.h),
                                              Text(
                                                '${e.name}',
                                                style:
                                                TextStyle(fontSize: 11.h),
                                              ),
                                            ],
                                          ),
                                          Gap(0.h),

                                        ],
                                      ),
                                    ),).toList()),
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
                        Gap(10.h),

                        FutureBuilder<List<Slider2?>>(
                          future: getData3(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Slider2?>? item = snapshot.data;
                              return CarouselSlider(
                                  options: CarouselOptions(
                                    height: 110.h,

                                    autoPlay: true,
                                    viewportFraction: .91.h,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        counter1 = index;
                                      });
                                    },
                                    enlargeCenterPage: true,

                                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                    pauseAutoPlayOnTouch: true,
                                    //enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                    Duration(milliseconds: 900),
                                    //  viewportFraction: .8,
                                  ),
                                  items: item!
                                      .map(
                                        (e) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.h),
                                      child: Container(
                                        height: 90.h,
                                        width: double.infinity,
                                        //  padding: EdgeInsets.symmetric(horizontal: 15.h,vertical: 8.h),
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
                                            borderRadius:
                                            BorderRadius.circular(15.r),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${e!.photoName}'),
                                            )),
                                      ),
                                    ),
                                  )
                                      .toList());
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
                        Gap(20.h),
                        FutureBuilder<List<ProductSubCategHomeModel?>>(
                          future: getData5('${userData.read('token')}','${13}'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<ProductSubCategHomeModel?>? item = snapshot.data;
                              return Column(

                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 15.h, right: 15.h, top: 5.h),
                                    child: Row(
                                      children: [
                                        Text('أفضل الفئات في ${item![0]!.subCategory!.name} :'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 240.h,

                                    child: ListView.separated(
                                        padding: EdgeInsets.all(5.h),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (context,index)=>InkWell(
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
                                              img: ' ',
                                              Fav:  FavoriteButton(
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
                                        ), separatorBuilder: (context,index)=>Gap(10.h), itemCount: item!.length),
                                  ),
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
                        Gap(20.h),
                        FutureBuilder<List<ProductSubCategHomeModel?>>(
                          future: getData5('${userData.read('token')}','${14}'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.error);


                              List<ProductSubCategHomeModel?>? item = snapshot.data;
                              print('pric=${item![0]!.price}');

                              return Column(

                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 15.h, right: 15.h, top: 5.h),
                                    child: Row(
                                      children: [
                                        Text('أفضل الفئات في ${item![0]!.subCategory!.name} :'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 245.h,

                                    child: ListView.separated(
                                        padding: EdgeInsets.all(5.h),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (context,index)=>InkWell(
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
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      for (int i = 0; i < item[index]!.productPhotos!.length; i++)
                                                        Container(
                                                          height: 6.h,
                                                          width: 6.h,
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal: 3.h,
                                                              vertical: 10.h),
                                                          decoration: BoxDecoration(
                                                            color: counter1 == i
                                                                ? Color(0xff858583)
                                                                : Color(0xff014678),
                                                            shape: BoxShape.circle,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
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
                                        ), separatorBuilder: (context,index)=>Gap(10.h), itemCount: item!.length),
                                  ),
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
                        Gap(50.h),

                      ],
                    ),
                  ],
                ),
              ),
            ),




        ],
      ),
          )),
    );
  }
}
