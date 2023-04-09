import '../../models/change_favorites_model.dart';

abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ChangeIndexBottomNavigationBar extends ShopState {}

class GetHomeDataSeccseful extends ShopState {}

class GetHomeDataLoading extends ShopState {}

class GetHomeDataError extends ShopState {}

class ShopSuccessCategoriesState extends ShopState {}

class ShopErrorCategoriesState extends ShopState {}

class ShopChangeFavoritesState extends ShopState {}

class ShopSuccessChangeFavoritesState extends ShopState {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopState {}
