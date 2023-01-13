abstract class HomeEvent {
  final int? newMonth;
  HomeEvent({
    this.newMonth,
  });
}

class OnHomePageEmpty extends HomeEvent {}

class OnHomePageLogout extends HomeEvent {}

class OnHomePageSetMonth extends HomeEvent {
  OnHomePageSetMonth({required super.newMonth});
}
