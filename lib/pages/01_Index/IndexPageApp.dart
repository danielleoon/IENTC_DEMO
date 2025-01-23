import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/pages/01_Index/02_Pages/04_Favorites/FavoritesPage.dart';
import 'package:ientc_jdls/pages/01_Index/02_Pages/05_Information/InformationPage.dart';
import 'package:ientc_jdls/pages/01_Index/02_Pages/03_Lists/ListsPage.dart';
import 'package:ientc_jdls/providers/bloc/FavoritesBloc.dart';
import 'package:ientc_jdls/providers/bloc/IndexBloc.dart';
import 'package:ientc_jdls/providers/bloc/ThemeBloc.dart';
import 'package:ientc_jdls/providers/events/IndexEvent.dart';
import 'package:ientc_jdls/providers/states/FavoritesState.dart';
import 'package:ientc_jdls/providers/states/IndexState.dart';
import 'package:ientc_jdls/providers/states/ThemeState.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  void _onItemTapped(BuildContext context, int index) {
    final bloc = context.read<IndexBloc>();
    bloc.add(ChangeIndexEvent(index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final themeData = themeState.themeData;
        return Scaffold(
          backgroundColor: themeData.scaffoldBackgroundColor,
          bottomNavigationBar: BlocBuilder<IndexBloc, IndexState>(
            builder: (context, state) {
              return BottomNavigationBar(
                backgroundColor: themeData.scaffoldBackgroundColor,
                elevation: 0,
                unselectedLabelStyle: const TextStyle(
                  fontSize: 0,
                  fontFamily: 'Daniel-Bold',
                  color: DanielColors.red20,
                ),
                selectedLabelStyle: const TextStyle(
                  fontSize: 0,
                  fontFamily: 'Daniel-Bold',
                  color: DanielColors.red20,
                ),
                items: <BottomNavigationBarItem>[
                  _buildBottomNavigationBarItem(
                      context, Icons.manage_search_sharp, 0, state),
                  _buildBottomNavigationBarItem(
                      context, Icons.favorite, 1, state),
                  _buildBottomNavigationBarItem(context, Icons.info, 2, state),
                ],
                currentIndex: state.selectedIndex,
                selectedItemColor: DanielAcentColors.orange,
                onTap: (index) => _onItemTapped(context, index),
              );
            },
          ),
          body: BlocBuilder<IndexBloc, IndexState>(
            builder: (context, state) {
              return IndexedStack(
                index: state.selectedIndex,
                children: const <Widget>[
                  ListsPage(),
                  FavoritesPage(),
                  InformationPage()
                ],
              );
            },
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      BuildContext context, IconData iconData, int index, IndexState state) {
    return BottomNavigationBarItem(
      icon: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, favoritesState) {
          int favoritesCount = 0;
          if (favoritesState is FavoritesLoadedState) {
            favoritesCount = favoritesState.favorites.length;
          }

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                iconData,
                color: state.selectedIndex == index
                    ? DanielAcentColors.orange
                    : DanielBaseColors.darkGrey,
              ),
              if (index == 1 && favoritesCount > 0)
                Positioned(
                  top: -5,
                  right: -10,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: DanielColors.red40,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$favoritesCount',
                      style: const TextStyle(
                        fontSize: 11,
                        fontFamily: 'Daniel-Regular',
                        color: DanielBaseColors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      label: '',
    );
  }
}
