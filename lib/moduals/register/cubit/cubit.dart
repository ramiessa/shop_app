import 'package:earthcuacke/moduals/register/cubit/state.dart';
import 'package:earthcuacke/remote/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreenCubit extends Cubit<RegisrerStates> {
  RegisterScreenCubit() : super(RegisterInitialState());

  static RegisterScreenCubit get(context) => BlocProvider.of(context);

  void Register({
    required String? name,
    required String? email,
    required String? password,
    required String? phonenumber,
  }) {
    emit(RegisterLoading());
    DioHelper.postData(url: 'register', data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phonenumber,
    }).then((value) {
      emit(RegisterSeccess());
      print(value.data);
    }).catchError((onError) {
      emit(RegisterError(onError));
    });
  }
}
