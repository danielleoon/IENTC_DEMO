abstract class IndexEvent {}

class ResetSubIndexEvent extends IndexEvent {}

class ChangeIndexEvent extends IndexEvent {
  final int newIndex;

  ChangeIndexEvent(this.newIndex);
}
