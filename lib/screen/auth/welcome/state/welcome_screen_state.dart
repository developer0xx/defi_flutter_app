class WelcomeScreenState {
  final Function() onSignInPressed;
  final Function() onSignUpPressed;

  const WelcomeScreenState({
    required this.onSignInPressed,
    required this.onSignUpPressed,
  });
}

WelcomeScreenState useWelcomeScreenState({
  required Function() navigateToSignIn,
  required Function() navigateToSignUp,
}) {
  return WelcomeScreenState(
    onSignInPressed: navigateToSignIn,
    onSignUpPressed: navigateToSignUp,
  );
}
