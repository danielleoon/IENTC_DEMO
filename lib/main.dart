import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/providers/bloc/ThemeBloc.dart';
import 'package:ientc_jdls/providers/states/ThemeState.dart';
import 'package:ientc_jdls/routes/routes.dart';
import 'package:ientc_jdls/providers/bloc/FavoritesBloc.dart';
import 'package:ientc_jdls/providers/bloc/IndexBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoritesBloc>(create: (context) => FavoritesBloc()),
        BlocProvider<IndexBloc>(create: (_) => IndexBloc()),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final themeData = themeState.themeData;

          return MaterialApp(
            theme: themeData,
            title: 'Demo',
            debugShowCheckedModeBanner: false,
            initialRoute: '/Main',
            routes: getAplicationRoutes(),
          );
        },
      ),
    );
  }
}
