import 'package:earthcuacke/models/home_model.dart';
import 'package:earthcuacke/moduals/favoirate/favoirate.dart';
import 'package:earthcuacke/moduals/products/Products.dart';
import 'package:earthcuacke/moduals/settings/settings.dart';
import 'package:earthcuacke/remote/dio.dart';
import 'package:earthcuacke/sherd/cubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/categories_model.dart';
import '../../moduals/cateogries/cateogries.dart';
import '../../moduals/home_screen/home_lyout.dart';
import '../network/local/remote/constant.dart';

class ShopAppCubit extends Cubit<ShopState> {
  ShopAppCubit() : super(ShopInitialState());
  static ShopAppCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;

  dynamic homeData;
  List<Widget> screens = [
    Products(),
    CategoriesScreen(),
    Favoirate(),
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

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
}
