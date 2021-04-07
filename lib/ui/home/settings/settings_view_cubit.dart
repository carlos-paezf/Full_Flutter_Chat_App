import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsSwitchCubit extends Cubit<bool>{
  SettingsSwitchCubit(bool state) : super(state);

  void onChangeDarkMode(bool isDark)=> emit(isDark);
}

class SettingsLogoutCubit extends Cubit<void> {
  SettingsLogoutCubit() : super(null);

  void logOut() {
    //TODO: Call services
    print('Log out');
    emit(null);
  }
}
