import 'package:earthcuacke/models/home_model.dart';
import 'package:earthcuacke/moduals/favoirate/favoirate.dart';
import 'package:earthcuacke/moduals/products/Products.dart';
import 'package:earthcuacke/moduals/settings/settings.dart';
import 'package:earthcuacke/remote/dio.dart';
import 'package:earthcuacke/sherd/components/constants.dart';
import 'package:earthcuacke/sherd/cubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/categories_model.dart';
import '../../models/change_favorites_model.dart';
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
  Map<int, bool> favorites = {};
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

      homeData.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
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

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {}

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
      ;
    });
  }
}
