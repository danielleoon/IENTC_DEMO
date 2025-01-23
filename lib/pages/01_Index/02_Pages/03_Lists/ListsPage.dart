import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/class/characters.dart';
import 'package:ientc_jdls/providers/bloc/FavoritesBloc.dart';
import 'package:ientc_jdls/providers/bloc/ThemeBloc.dart';
import 'package:ientc_jdls/providers/events/FavoritesEvent.dart';
import 'package:ientc_jdls/providers/states/FavoritesState.dart';
import 'package:ientc_jdls/providers/states/ThemeState.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielTextFieldIcon.dart';
import 'package:ientc_jdls/utils/DragonBall/DragonBallCard.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  _ListsPageState createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  int currentPage = 1;
  final int limit = 20;
  bool isLoading = false;
  bool hasMore = true;
  bool isExpanded = false;
  String searchQuery = '';
  List<CharactersDB> allCharacters = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _setupScrollController();
    _setupSearchController();
  }

  void _setupSearchController() {
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (!_scrollController.hasClients || !hasMore) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        _loadCharacters();
      }
    });
  }

  Future<void> _loadInitialData() async {
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    if (isLoading || !hasMore || searchQuery.isNotEmpty) return;

    setState(() {
      isLoading = true;
    });

    if (!mounted) return;

    context.read<FavoritesBloc>().add(LoadCharactersEvent(
          page: currentPage,
          limit: limit,
        ));
  }

  List<CharactersDB> getFilteredCharacters() {
    if (searchQuery.isEmpty) {
      return List.from(allCharacters);
    }

    final seenIds = <int>{};
    return allCharacters
        .where((character) =>
            character.name.toLowerCase().contains(searchQuery) &&
            seenIds.add(character.id))
        .toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesLoadedState) {
            setState(() {
              final newCharacters = state.characters;
              hasMore = newCharacters.length >= limit;

              if (currentPage == 1) {
                allCharacters = List.from(newCharacters);
              } else {
                final existingIds =
                    allCharacters.map((char) => char.id).toSet();
                final filteredNewCharacters = newCharacters
                    .where((newChar) => !existingIds.contains(newChar.id))
                    .toList();

                if (filteredNewCharacters.isEmpty) {
                  hasMore = false;
                }

                allCharacters.addAll(filteredNewCharacters);
              }

              isLoading = false;
              if (hasMore) {
                currentPage++;
              }
            });
          }
        },
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                final themeData = themeState.themeData;

                final scaffoldBackgroundColor =
                    themeData.scaffoldBackgroundColor;

                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      backgroundColor: scaffoldBackgroundColor,
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
                                            duration: const Duration(
                                                milliseconds: 300),
                                            right: isExpanded
                                                ? 60
                                                : -MediaQuery.of(context)
                                                    .size
                                                    .width,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
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
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                  color:
                                                      DanielAcentColors.orange,
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
                                                      key: ValueKey<bool>(
                                                          isExpanded),
                                                      color:
                                                          scaffoldBackgroundColor),
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
                                  "Personajes Dragon Ball",
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
                        if (state is FavoritesInitialState &&
                            currentPage == 1) {
                          return const SliverFillRemaining(
                            child: SizedBox.shrink(),
                          );
                        }

                        final displayedCharacters = getFilteredCharacters();
                        if (displayedCharacters.isEmpty) {
                          return const SliverFillRemaining(
                            child: SizedBox.shrink(),
                          );
                        }

                        return SliverPadding(
                          padding: const EdgeInsets.all(10),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).size.width >= 600
                                      ? (MediaQuery.of(context).size.width >=
                                              900
                                          ? 4
                                          : 3)
                                      : 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index >= displayedCharacters.length) {
                                  return null;
                                }
                                return CharacterCard(
                                    character: displayedCharacters[index]);
                              },
                              childCount: displayedCharacters.length +
                                  (hasMore ? 1 : 0),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
