abstract class IndexState {
  final int selectedIndex;
  final int selectedIndex2;

  IndexState(this.selectedIndex, this.selectedIndex2);
}

class IndexInitialState extends IndexState {
  IndexInitialState() : super(0, 0);
}

class IndexUpdatedState extends IndexState {
  IndexUpdatedState(super.selectedIndex, super.selectedIndex2);
}
