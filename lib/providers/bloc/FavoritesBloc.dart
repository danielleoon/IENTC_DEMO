import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/providers/events/FavoritesEvent.dart';
import 'package:ientc_jdls/class/characters.dart';
import 'package:ientc_jdls/providers/states/FavoritesState.dart';
import 'package:ientc_jdls/services/ServiceMain.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielScaffoldMessage.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final List<CharactersDB> _characters = [];
  final List<CharactersDB> _favorites = [];

  FavoritesBloc() : super(FavoritesInitialState()) {
    on<LoadCharactersEvent>((event, emit) async {
      try {
        final newCharacters = await Main.fetchCharacters(
          page: event.page,
          limit: event.limit,
        );
        _characters.addAll(newCharacters);

        emit(FavoritesLoadedState(
            List.from(_characters), List.from(_favorites)));
      } catch (e) {
        print("error al cargar personajes: $e");
      }
    });

    on<AddToFavoritesEvent>((event, emit) {
      if (_favorites.contains(event.character)) {
        _favorites.remove(event.character);

        MessageHelper.showMessage(
            event.context,
            '${event.character.name} eliminado de favoritos.',
            DanielColors.yellow90,
            DanielColors.yellow50);
      } else {
        _favorites.add(event.character);

        MessageHelper.showMessage(
            event.context,
            '${event.character.name} agregado a favoritos.',
            DanielColors.green30,
            DanielColors.green80);
      }

      emit(FavoritesLoadedState(List.from(_characters), List.from(_favorites)));
    });
  }
}
