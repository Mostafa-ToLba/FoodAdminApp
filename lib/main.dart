import 'package:admin/foodLayout/foodLayoutScreen.dart';
import 'package:admin/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:admin/modules/login/login_screen.dart';
import 'package:admin/modules/shared/bloc_observer/bloc_observer.dart';
import 'package:admin/modules/shared/casheHelper/sharedPreferance.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';
import 'foodLayout/layoutCubit/layoutCubit.dart';
import 'modules/shared/constants/constants.dart';
import 'modules/splashScreen/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CasheHelper.init();
  Widget widget ;
  uId = CasheHelper.getData(key: 'uId');
  print('main uId == ${uId}');
  if(uId!= null)
  {
    widget = FoodLayoutScreen();
  }else
  {
    widget = SplashScreen();
  }
  //cloudMesssaging
  OneSignal.shared.init('ab900aa0-133a-42bb-9784-d9e2db2680c5', iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
  //
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



   MyApp({Key? key,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>FoodCubitAdmin(InitialFoodState())..getNotify(),
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,deviceType)=>MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'admin',
          theme: ThemeData(
            checkboxTheme: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white,
              selectedItemColor: HexColor('#7a0000'),
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              selectedLabelStyle:TextStyle(color: HexColor('#184a2c')),
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
            ),
            primarySwatch: Colors.red,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
          ),
          home:  SplashScreen(),
        ),
      ),
    );
  }
}

