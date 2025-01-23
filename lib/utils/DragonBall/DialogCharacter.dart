import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/class/characters.dart';
import 'package:ientc_jdls/class/originPlanets.dart';
import 'package:ientc_jdls/class/transformations.dart';
import 'package:ientc_jdls/providers/bloc/FavoritesBloc.dart';
import 'package:ientc_jdls/providers/events/FavoritesEvent.dart';
import 'package:ientc_jdls/providers/states/FavoritesState.dart';
import 'package:ientc_jdls/services/ServiceCharacter.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';
import 'package:ientc_jdls/utils/DragonBall/TransformationCard.dart';

class CharacterDetailsDialog extends StatelessWidget {
  final CharactersDB character;

  const CharacterDetailsDialog({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ServiceCharacter.fetchCharacterExtras(character.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator(color: DanielAcentColors.orange));
        } else if (snapshot.hasError) {
          return Dialog(
            child: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          final originPlanet = data['originPlanet'] as OriginPlanet?;
          final transformations =
              data['transformations'] as List<Transformation>;

          return BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              bool isFavorite = false;

              if (state is FavoritesLoadedState) {
                isFavorite = state.favorites.contains(character);
              }

              return Dialog(
                insetPadding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    if (originPlanet != null)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            originPlanet.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.7),
                              Colors.white.withOpacity(1),
                              Colors.white.withOpacity(1),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  character.image,
                                  height: 350,
                                  fit: BoxFit.fitHeight,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              character.name,
                              style: const TextStyle(
                                fontSize: 30,
                                fontFamily: 'Daniel-Bold',
                                color: DanielBaseColors.black,
                              ),
                            ),
                            Text(
                              character.description,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Daniel-Regular',
                                color: DanielBaseColors.black,
                                shadows: [
                                  Shadow(
                                    blurRadius: 20.0,
                                    color: Colors.white,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                color:
                                    DanielBaseColors.lightGrey.withOpacity(.5),
                                height: 1,
                              ),
                            ),
                            richInfoText('Ki', character.ki),
                            richInfoText('Max. Ki', character.maxKi),
                            richInfoText('Raza', character.race),
                            richInfoText('Afiliación', character.affiliation),
                            richInfoText('Género', character.gender),
                            richInfoText('Planeta', originPlanet!.name),
                            richInfoText('Información planeta',
                                originPlanet.description),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                color:
                                    DanielBaseColors.lightGrey.withOpacity(.5),
                                height: 1,
                              ),
                            ),
                            const Text(
                              "Transformaciones:",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Daniel-Bold',
                                color: DanielBaseColors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              child: transformations.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No hay transformaciones disponibles',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Daniel-Regular',
                                          color: DanielBaseColors.darkGrey,
                                        ),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                            transformations.length, (index) {
                                          final transformation =
                                              transformations[index];
                                          return TransformationCard(
                                            imageUrl: transformation.image,
                                            name: transformation.name,
                                          );
                                        }),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: () {
                          context.read<FavoritesBloc>().add(
                                AddToFavoritesEvent(character, context),
                              );
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
              );
            },
          );
        } else {
          return const Center(
            child: Text("No se encontraron detalles del personaje."),
          );
        }
      },
    );
  }

  Widget richInfoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Daniel-Regular',
            color: DanielBaseColors.black,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Daniel-Bold',
                color: DanielBaseColors.black,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Daniel-Regular',
                color: DanielBaseColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
