import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/Social_Layout/Social_Layout.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/shared/bloc_observer/bloc_observer.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/shared/network/local/cache_helper.dart';
import 'package:social_application4/shared/network/remote/dio_helper.dart';
import 'package:social_application4/styles/themes.dart';
import 'firebase_options.dart';
import 'modules/login_screen/login_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("On Background Message ");
  print(message.data.toString());
  showToast(msg: 'On Background message', color: Colors.green, textColor: Colors.white);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken();
  print("token $token");

  FirebaseMessaging.onMessage.listen((event) {
    print("NOTIFICATIONS ${event.data.toString()}");
    showToast(msg: 'on Message', color: Colors.green, textColor: Colors.white );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("NOTIFICATIONS ${event.data.toString()}");
    showToast(msg: 'on message opened app',color: Colors.green, textColor: Colors.white);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');

  Widget startWidget;

  if(uId != null){
    startWidget = SocialLayout();
  }else{
    startWidget = SocialLoginScreen();
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(startWidget: startWidget,));
    },
    blocObserver: MyBlocObserver(),
  );}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({
    required this.startWidget,
});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLayoutCubit()..getUserData(userID: uId),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
