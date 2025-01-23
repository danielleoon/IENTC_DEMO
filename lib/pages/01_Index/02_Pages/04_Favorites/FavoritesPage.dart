import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/class/characters.dart';
import 'package:ientc_jdls/providers/bloc/FavoritesBloc.dart';
import 'package:ientc_jdls/providers/bloc/ThemeBloc.dart';
import 'package:ientc_jdls/providers/states/FavoritesState.dart';
import 'package:ientc_jdls/providers/states/ThemeState.dart';
import 'package:ientc_jdls/utils/DragonBall/DragonBallCard.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielTextFieldIcon.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool isLoading = false;
  bool isExpanded = false;
  String searchQuery = '';
  List<CharactersDB> allFavorites = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupSearchController();
  }

  void _setupSearchController() {
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  List<CharactersDB> getFilteredFavorites() {
    if (searchQuery.isEmpty) {
      return List.from(allFavorites);
    }

    final seenIds = <int>{};
    return allFavorites
        .where((character) =>
            character.name.toLowerCase().contains(searchQuery) &&
            seenIds.add(character.id))
        .toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesLoadedState) {
            setState(() {
              allFavorites = List.from(state.favorites);
              isLoading = false;
            });
          }
        },
        child:
            BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
          final themeData = themeState.themeData;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: themeData.scaffoldBackgroundColor,
                floating: true,
                snap: true,
                expandedHeight: 110.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/logodb.webp',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: 50,
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    AnimatedPositioned(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      right: isExpanded
                                          ? 60
                                          : -MediaQuery.of(context).size.width,
                                      width: MediaQuery.of(context).size.width -
                                          150,
                                      child: DanielTextFieldIcon(
                                        textLabel: 'Buscar personajes',
                                        keyboardType: TextInputType.text,
                                        controller: searchController,
                                        pressed: () {
                                          setState(() {
                                            searchController.text = '';
                                          });
                                        },
                                        maxLenght: 50,
                                        maxLines: 1,
                                        enabled: true,
                                        readOnly: false,
                                        obscuredText: false,
                                        height: 50,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isExpanded = !isExpanded;
                                            if (!isExpanded) {
                                              FocusScope.of(context).unfocus();
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            color: DanielAcentColors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            transitionBuilder:
                                                (child, animation) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: ScaleTransition(
                                                  scale: animation,
                                                  child: child,
                                                ),
                                              );
                                            },
                                            child: Icon(
                                                !isExpanded
                                                    ? Icons.search
                                                    : Icons
                                                        .chevron_right_rounded,
                                                key: ValueKey<bool>(isExpanded),
                                                color: themeData
                                                    .scaffoldBackgroundColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 0.0, left: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Favoritos",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Daniel-Bold',
                              color: DanielAcentColors.orange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesInitialState && allFavorites.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final displayedFavorites = getFilteredFavorites();
                  if (displayedFavorites.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text(
                          "No se encontraron elementos",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Daniel-Regular',
                              color: DanielBaseColors.darkGrey,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width >= 600
                            ? (MediaQuery.of(context).size.width >= 900 ? 4 : 3)
                            : 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= displayedFavorites.length) {
                            return null;
                          }
                          return CharacterCard(
                              character: displayedFavorites[index]);
                        },
                        childCount: displayedFavorites.length,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
