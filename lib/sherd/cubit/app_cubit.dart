import 'package:earthcuacke/models/home_model.dart';
import 'package:earthcuacke/moduals/favoirate/favoirate.dart';
import 'package:earthcuacke/moduals/products/Products.dart';
import 'package:earthcuacke/moduals/settings/settings.dart';
import 'package:earthcuacke/remote/dio.dart';
import 'package:earthcuacke/sherd/cubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../moduals/cateogries/cateogries.dart';
import '../../moduals/home_screen/home_lyout.dart';

class ShopAppCubit extends Cubit<ShopState> {
  ShopAppCubit() : super(ShopInitialState());
  static ShopAppCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;

  dynamic homeData;
  List<Widget> screens = const [
    Products(),
    Favoirate(),
    Cateogries(),
    Setting(),
  ];

  //methodes
  void changeindex(int index) {
    currentindex = index;
    emit(ChangeIndexBottomNavigationBar());
  }

  void getHomeDate({
    String? url,
    String? token,
  }) {
    emit(GetHomeDataLoading());
    DioHelper.getData(url: 'home').then((value) {
      homeData = HomeData.fromjson(value.data);
      print(homeData!.status);
      emit(GetHomeDataSeccseful());
    }).catchError((error) {
      emit(GetHomeDataError());
      print(error.toString());
    });
  }
}
