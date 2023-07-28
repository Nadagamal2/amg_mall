import 'dart:convert';
 import 'package:amg_store/screens/productHome.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

 import '../components/app_style.dart';
import '../components/ratingController.dart';
import '../model_categ/product_by_sub_categ_home.dart';
import '../model_categ/seaarch_model.dart';
import 'bottomNav_screen.dart';


class search extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';

          },
          icon: Icon(Icons.close))
    ];
  }
  @override
  String get searchFieldLabel => 'بحث عن منتج معين';

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
          toolbarHeight: 65.h,
          color: Colors.grey,
          elevation: 0

      ),
      textSelectionTheme: TextSelectionThemeData(

          cursorColor: Colors.white,
          selectionColor: Colors.white,
          selectionHandleColor: Colors.white),

      inputDecorationTheme: InputDecorationTheme(


        hintStyle: TextStyle(
          color: Colors.white,
        ),
        isDense: true,
        contentPadding:
        EdgeInsets.fromLTRB(10.h, 5.h, 10.h, 7.h),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
    );
    assert(theme != null);
    return theme;
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  List data = [];
  List<ProductSubCategHomeModel> result = [];
  Future<List<ProductSubCategHomeModel>?> catidSearch({  String? query}) async {
    try {
      var response = await http.get(
          Uri.parse(
              'http://eibtek2-001-site6.atempurl.com/api/GetSearchClincs/${query}'),
          headers: {
            "Content-Type": "application/json",
          },
          );


      var dataa = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        data=dataa['records'];
         result=data.map((e) => ProductSubCategHomeModel.fromJson(e)).toList();
        if (query != null) {
          result = result
              .where((element) =>
              query.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        print('dataId==${data}');
        print('result==${result}');
      } else {
        print("Faild");
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
  }
  final userData =GetStorage();
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
  @override
  Widget buildResults(BuildContext context) {
    return     FutureBuilder<List<ProductSubCategHomeModel?>?>(
      future: catidSearch(query: query),
      builder: (context,snapshot){
        if(snapshot.hasData){
          print(snapshot.error);
          List<ProductSubCategHomeModel?>? item = snapshot.data;
          return  Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.h ),
            child: Container(
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
                        Cursal: item[index]!.productPhotos!.map((e) =>  Column(
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
                        img: ' ',    Fav:  FavoriteButton(
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
                                        '${item![index]!.name}',
                                        maxLines: 2,
                                        overflow:
                                        TextOverflow
                                            .ellipsis,
                                        style: TextStyle(
                                          color: Styles.defualtColorBlack,
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
            ),
          );
        }else {
          return Center(
            child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Colors.transparent),),
          );
        }
      },
    );
  }
  double rating=0;
  Set<String> savedWords = Set<String>();

  @override
  Widget buildSuggestions(BuildContext context) {
    return  Center(
      child: Text('بحث عن منتج معين',style: TextStyle(

        fontWeight: FontWeight.bold,
      ),),
    );
  }
  Future<void> _launchUrl(String link ) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}