import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../components/app_style.dart';
import '../models/question_model.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  Future<List<Questions>> getData() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site6.atempurl.com/api/QuestionsApi/GetAll'));
    var data = jsonDecode(response.body.toString());
    // for(var element in data){
    //   termsAndConditions.add(TermsAndConditions.fromJson(element));
    //   print(element);
    // }
    if (response.statusCode == 200) {

      print(response.body);
      print(data);
      List jsonData = (data);
      return jsonData
          .map(( Data) => Questions.fromJson(Data))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  @override
  Widget build(BuildContext context) {
    return   Directionality(
      textDirection:ui.TextDirection.rtl,

      child: Scaffold(
        backgroundColor: Styles.defualtColorWhite,
        body: SingleChildScrollView(
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
                              color: Styles.defualtColorWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5.r),

                            ),
                            child:  Icon(Icons.keyboard_arrow_right_outlined,size: 19.h,)
                        ),
                      ),

                      Text( 'عن التطبيق', style: TextStyle(
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

              // Column(
              //   children: [
              //     Padding(
              //         padding:  EdgeInsets.symmetric(horizontal: 20.h),
              //         child:  SizedBox(
              //           height: 500.h,
              //           //    width: 400.h,
              //           child: ListView.separated(
              //             //|padding: EdgeInsets.all(10.h),
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
              //               itemCount: 2),
              //         )
              //     )
              //   ],
              // )
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [



                  Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: FutureBuilder<List<Questions?>>(
                      future: getData(),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          List<Questions?>? item = snapshot.data;
                          return SizedBox(
                            height: 500.h,
                            child: ListView.separated(
                              padding: EdgeInsets.all(5.h),
                              itemBuilder: (context,index)=> Column(
                                children: [
                                  BuildQuestionScreen(text1:   '${item![index]!.question}', text2:  '${item[index]!.answer}',),







                                ],
                              ),
                              separatorBuilder: (context,index)=>Gap(5.h),
                              itemCount: item!.length,
                            ),
                          );
                        }else {
                          return Center(
                            child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor),),
                          );
                        }
                      },

                    ),
                  )
                ],),

            ],
          ),
        ),

      ),
    );
  }
}


Widget BuildQuestionScreen({
  required String text1,
  required String text2,
}) => Column(
  children: [
    Row(
      children: [

        Container(
          height: 60,
          width: 210,
          decoration: BoxDecoration(
            color:Color(0xFFCDA748),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(23),
                topLeft: Radius.circular(23),
                bottomRight: Radius.circular(23)),
          ),
          child: Center(
            child: Text(
              text1,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    ),
    Gap(8),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 60,
          width: 220,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Color(0xFFF2DA75),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(23),
                topLeft: Radius.circular(23),
                bottomLeft: Radius.circular(23)),
          ),
          child: Center(
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    ),
  ],
);