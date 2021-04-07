import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewCubit extends Cubit<int>{
  HomeViewCubit() : super(0);

  void onChangeTab(int index) => emit(index);

}