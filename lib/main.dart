import 'package:amg_store/screens/bottomNav_screen.dart';
import 'package:amg_store/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'components/app_style.dart';
import 'components/ratingController.dart';

void main()async {
  final controller = Get.put(RatingController());
  await controller.initSp();
  await  GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:  Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(

        title: 'AmgStore',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          appBarTheme:   AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:  Brightness.light,
              statusBarBrightness:  Brightness.light,
            ),
          ),

        ),
        home: child,
      ),
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userData = GetStorage();

  @override
  void initState() {
    super.initState();
    userData.writeIfNull('isLogged', false);
    userData.writeIfNull('isLoggedByGoogle', false);
    Future.delayed(Duration.zero, () async {
      checkIfLoged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
            ),
          ),
        ));
  }

  void checkIfLoged() {
    userData.read('isLogged')||userData.read('isLoggedByGoogle')
        ? Get.offAll(BottomNavScreen())
        : Get.offAll(OnBoardingScreen());
  }
}
