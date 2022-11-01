abstract class SplashScreenState {}

class SplashScreenStateEmpty extends SplashScreenState {}

class SplashScreenStateAuthenticated extends SplashScreenState {
  final String userData;

  SplashScreenStateAuthenticated(this.userData);
}

class SplashScreenStateUnauthenticated extends SplashScreenState {}
