import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/class/characters.dart';
import 'package:ientc_jdls/providers/bloc/FavoritesBloc.dart';
import 'package:ientc_jdls/providers/bloc/ThemeBloc.dart';
import 'package:ientc_jdls/providers/events/FavoritesEvent.dart';
import 'package:ientc_jdls/providers/states/FavoritesState.dart';
import 'package:ientc_jdls/providers/states/ThemeState.dart';
import 'package:ientc_jdls/utils/DragonBall/DialogCharacter.dart';

class CharacterCard extends StatelessWidget {
  final CharactersDB character;

  const CharacterCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, favoritesState) {
            bool isFavorite = false;

            if (favoritesState is FavoritesLoadedState) {
              isFavorite = favoritesState.favorites.contains(character);
            }

            final themeData = themeState.themeData;

            return GestureDetector(
              onTap: () => _showCharacterDetails(context, character),
              child: Card(
                color: themeData.cardColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: Image.network(
                              character.image,
                              fit: BoxFit.fitHeight,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Daniel-Bold',
                                  color: themeData.primaryColorDark,
                                ),
                              ),
                              SizedBox(
                                  height: 20,
                                  child: Text(character.race,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Daniel-Regular',
                                        color: themeData.primaryColorDark,
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: FloatingActionButton(
                        onPressed: () {
                          context
                              .read<FavoritesBloc>()
                              .add(AddToFavoritesEvent(character, context));
                        },
                        backgroundColor: isFavorite ? Colors.red : Colors.grey,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCharacterDetails(BuildContext context, CharactersDB character) {
    showDialog(
      context: context,
      builder: (context) => CharacterDetailsDialog(character: character),
    );
  }
}
