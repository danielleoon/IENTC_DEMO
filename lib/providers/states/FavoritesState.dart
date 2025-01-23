import 'package:ientc_jdls/class/characters.dart';

abstract class FavoritesState {
  List<CharactersDB> get characters;
  List<CharactersDB> get favorites;
}

class FavoritesInitialState extends FavoritesState {
  @override
  List<CharactersDB> get characters => [];

  @override
  List<CharactersDB> get favorites => [];
}

class FavoritesLoadedState extends FavoritesState {
  final List<CharactersDB> character;
  final List<CharactersDB> favorite;

  FavoritesLoadedState(this.character, this.favorite);

  @override
  List<CharactersDB> get characters => character;

  @override
  List<CharactersDB> get favorites => favorite;
}
