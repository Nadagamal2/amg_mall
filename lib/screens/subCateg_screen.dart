import 'dart:convert';

import 'package:amg_store/screens/product_by_subCateg_screen.dart';
import 'package:amg_store/screens/product_subCategHome_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../components/app_style.dart';
import '../models/categ_model.dart';
import '../models/subCat_model.dart';
import '../models/supCat_model.dart';

class SubCategScreen extends StatefulWidget {
  String name;
   SubCategScreen({Key? key,required this.name}) : super(key: key);

  @override
  State<SubCategScreen> createState() => _SubCategScreenState();
}

class _SubCategScreenState extends State<SubCategScreen> {
  final userData =GetStorage();
  Future<List<SubCategModel>> getData2() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/SubCategoryApi/GetByCategoryId?categoryId=${userData.read('categId')}'));
    var data = jsonDecode(response.body.toString());
    // for(var element in data){
    //   termsAndConditions.add(TermsAndConditions.fromJson(element));
    //   print(element);
    // }
    if (response.statusCode == 200) {

      // print(response.body);
      print(data);
      List jsonData = (data);
      return jsonData
          .map((categoryData) => SubCategModel.fromJson(categoryData))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }


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
                      FutureBuilder<List<SubCategModel?>>(
                        future: getData2(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            List<SubCategModel?>? item = snapshot.data;
                            return SizedBox(
                              height: 530.h,
                              child: FadeInRight(
                                duration: Duration(milliseconds: 900),
                                child: ListView.separated(
                                  padding: EdgeInsets.all(5.h),
                                    physics: BouncingScrollPhysics(),

                                    itemBuilder: (context,index)=>     InkWell(
                                      onTap: (){
                                        print(item[index]!.id);
                                        userData.write('subCategId', item[index]!.id);
                                        Get.to(ProductBySubCageHomecScreen(name: '${item[index]!.name}',));
                                      },
                                      child: Container(
                                        height: 40.h,
                                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                                        decoration: BoxDecoration(

                                          color: Styles.defualtColorWhite,
                                          borderRadius: BorderRadius.circular(5.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              blurRadius: 6,
                                              spreadRadius: 2,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${item[index]!.name}',style: TextStyle(
                                                color: Colors.black
                                            ),),
                                         //   Icon( Icons.arrow_forward_ios_rounded,size: 15.h,  color: Colors.black,),

                                          ],
                                        ),
                                      ),
                                    ),
                                    separatorBuilder: (context,index)=> Divider(
                                      height: 20.h,
                                      thickness: .5,
                                      color: Colors.grey.shade300,
                                    ),
                                    itemCount: item!.length),
                              ),
                            );
                          }else {
                            return Center(
                              child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor),),
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
