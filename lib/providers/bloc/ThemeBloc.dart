import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/providers/events/ThemeEvent.dart';
import 'package:ientc_jdls/providers/states/ThemeState.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielThemes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: ThemeConfig.lightTheme)) {
    on<ToggleThemeEvent>((event, emit) {
      final isDarkMode = state.themeData.brightness == Brightness.dark;
      emit(ThemeState(
        themeData: isDarkMode ? ThemeConfig.lightTheme : ThemeConfig.darkTheme,
      ));
    });
  }
}
