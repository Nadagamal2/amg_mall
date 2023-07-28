import 'dart:convert';

import 'package:amg_store/screens/privacy_policy.dart';
import 'package:amg_store/screens/profile_data_screen.dart';
import 'package:amg_store/screens/sign_screen.dart';
import 'package:amg_store/screens/tems_And_condition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import '../components/app_style.dart';
import '../models/get_order_model.dart';
import 'Suggestions_and_complaints.dart';
import 'about_app.dart';
import 'change_password.dart';
import 'details_requests.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final userData = GetStorage();
  Future<GetOrderModel?> getData( ) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://eibtek2-001-site6.atempurl.com/api/SavedOrdersApi/GeOrderByUserId/${userData.read('token')}'),

          );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print(data);

      } else {
        print("Faild");
      }
      return GetOrderModel.fromJson(data);
    } catch (e) {
      print(e.toString());
    }
  }
  Future<List<GetOrderModel>> getData2() async {
    final response = await http.post(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/SavedOrdersApi/GeOrderByUserId/${userData.read('token')}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {

      print(response.body);
      print(data);
      List jsonData = (data);
      return jsonData
          .map((categoryData) => GetOrderModel.fromJson(categoryData))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

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
                            'الطلبات',
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
                  FutureBuilder  (
                    future: getData(),
                    builder: (context,snapshot){

                      if( snapshot.hasData){


                        return  Padding(
                            padding:
                            EdgeInsets.only(top: 100.h, right: 15.h, left: 15.h),
                            child: SizedBox(
                              height: 580.h,
                              child: ListView.separated(
                                  padding: EdgeInsets.all(5.h),
                                  itemBuilder: (context, index) => Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){},
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.h, vertical: 10.h),
                                          height: 120.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Styles.defualtColorWhite,
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                Colors.grey.withOpacity(.1),
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
                                              children: [
                                                Row(    mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                  Text('${DateFormat('yyyy-MM-dd').format(DateTime.parse( '${snapshot.data!.data![index].sevedDate}'))}',style: TextStyle(
                                                    fontSize: 9.h,
                                                    color: Colors.grey.shade400
                                                  ),),    Text('${DateFormat('HH-mm').format(DateTime.parse( '${snapshot.data!.data![index].sevedDate}'))}',style: TextStyle(
                                                    fontSize: 9.h,
                                                    color: Colors.grey.shade400
                                                  ),),

                                                  ],
                                                ),
                                                Gap(5.h),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [


                                                        Image(
                                                          image: NetworkImage(
                                                              'http://eibtek2-001-site6.atempurl.com/Files/Imgs/${snapshot.data!.data![index].product!.photoName}'),


                                                          height: 80.h,
                                                          width: 80.h,
                                                        ),
                                                        Gap(10.h),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: 100.h,
                                                              child: Text(
                                                                '${snapshot.data!.data![index].product!.name}',
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
                                                            Gap(10.h),
                                                            Text(  '${snapshot.data!.data![index].product!.price} ر.س ',style: TextStyle(

                                                                fontSize: 11.sp,

                                                            ),),
                                                            Gap(5.h),
                                                            Text(  '${snapshot.data!.data![index].status}',style: TextStyle(
                                                                color: Colors.green,
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w600
                                                            ),),

                                                          ],
                                                        ),
                                                      ],
                                                    ),




                                                  ],
                                                ),
                                                // Gap(10.h),
                                                // Row(     mainAxisAlignment:
                                                // MainAxisAlignment.spaceBetween,
                                                //   children: [
                                                //     Container(
                                                //       height: 20.h,
                                                //       width: 75.h,
                                                //       decoration: BoxDecoration(
                                                //         color: Colors.grey.shade200,
                                                //         borderRadius: BorderRadius.circular(5.r)
                                                //       ),
                                                //       child: Center(
                                                //         child: Text(
                                                //           'قيم المتجر',
                                                //           style: TextStyle(
                                                //             fontSize: 11.h,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     Container(
                                                //       height: 20.h,
                                                //       width: 75.h,
                                                //       decoration: BoxDecoration(
                                                //           color: Colors.grey.shade200,
                                                //           borderRadius: BorderRadius.circular(5.r)
                                                //       ),
                                                //       child: Center(
                                                //         child: Text(
                                                //           'قيم المنتج',
                                                //           style: TextStyle(
                                                //             fontSize: 11.h,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     Container(
                                                //       height: 20.h,
                                                //       width: 75.h,
                                                //       decoration: BoxDecoration(
                                                //           color: Colors.grey.shade200,
                                                //           borderRadius: BorderRadius.circular(5.r)
                                                //       ),
                                                //       child: Center(
                                                //         child: Text(
                                                //           'قيم الديليفري',
                                                //           style: TextStyle(
                                                //             fontSize: 11.h,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //
                                                //   ],
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  separatorBuilder: (context, index) => Gap(10.h),
                                  itemCount: snapshot.data!.data!.length),
                            ));
                      }else {
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
