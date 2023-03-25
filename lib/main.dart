import 'package:earthcuacke/moduals/home_screen/home_lyout.dart';
import 'package:earthcuacke/remote/dio.dart';
import 'package:earthcuacke/sherd/cubit/app_cubit.dart';
import 'package:earthcuacke/sherd/cubit/state.dart';
import 'package:earthcuacke/sherd/network/local/sherd_prefrence.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'moduals/login/cubit/bloc_observ.dart';
import 'moduals/login/login_screen.dart';
import 'moduals/on_boarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  dynamic onboarding = CacheHelper.getData(key: 'onboarding');
  dynamic token = CacheHelper.getData(key: 'token');
  runApp(MyApp(onboarding, token));
}

class MyApp extends StatefulWidget {
  dynamic onboarding;
  dynamic token;
  MyApp(
    this.onboarding,
    this.token,
  );

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopAppCubit()..getHomeDate(),
        child: BlocConsumer<ShopAppCubit, ShopState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                ),
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                fontFamily: 'Jannah',
              ),
              home: widget.onboarding != null
                  ? widget.token != null
                      ? ShopLayout()
                      : LoginScreen()
                  : const OnboardingScreen(),
            );
          },
        ));
  }
}
