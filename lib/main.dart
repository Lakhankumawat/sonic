import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sonic/routes/navigation_routes.dart';
import 'package:sonic/src/screens/permission/permission.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//Icon( Icons.radar_outlined, ),
//https://www.codetd.com/en/article/11667523
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: ScreenUtilInit(
        designSize: const Size(500, 500),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sonic',
          routes: routes,
          initialRoute: PermissionsPage.routeName,
        ),
      ),
    );
  }
}
