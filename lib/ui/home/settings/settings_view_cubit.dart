import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/domain/usecases/logout_usecase.dart';

class SettingsSwitchCubit extends Cubit<bool>{
  SettingsSwitchCubit(bool state) : super(state);

  void onChangeDarkMode(bool isDark)=> emit(isDark);
}

class SettingsLogoutCubit extends Cubit<void> {
  SettingsLogoutCubit(this._logoutUseCase) : super(null);

  final LogoutUseCase _logoutUseCase;

  void logOut() async {
    await _logoutUseCase.logout();
    print('Log out');
    emit(null);
  }
}
