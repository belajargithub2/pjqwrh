import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/api/api_repository.dart';
import '../../core/model/setting_model.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<SettingEvent>((event, emit) async {
      try{
        emit(SettingLoading());
        final data = await apiRepository.fetchSetting(event.baseUrl, event.deviceCode);
        emit(SettingSuccess(data));
        if(data.error != null){
          emit(SettingError(data.error));
        }
      } on Error{
        emit(const SettingError("failed fetch data"));
      }
    });
  }
}
