import 'package:flutter/material.dart';
import 'package:ientc_jdls/class/characters.dart';

abstract class FavoritesEvent {}

class LoadCharactersEvent extends FavoritesEvent {
  final int page;
  final int limit;

  LoadCharactersEvent({required this.page, required this.limit});
}

class AddToFavoritesEvent extends FavoritesEvent {
  final CharactersDB character;
  final BuildContext context;

  AddToFavoritesEvent(this.character, this.context);
}
