import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/data/persistent_storage_repository.dart';

class AppThemeCubit extends Cubit<bool>{
  AppThemeCubit(this._persistentStorageRepository): super(false);

  final PersistentStorageRepository _persistentStorageRepository;
  
  bool _isDark = false;
  bool get isDark => _isDark;
  
  Future<void> init() async{
    //TODO: Verify local storage
    _isDark = true;
    emit(_isDark);
  }
}