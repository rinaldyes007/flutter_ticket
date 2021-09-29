part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    if (user == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.read<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.read<UserBloc>().add(LoadUser(user.uid));

        prevPageEvent = GoToMainPage();
        context.read<PageBloc>().add(prevPageEvent);
      }
    }

    //   context.read<PageBloc>().add(GoToSplashPage());
    // } else {
    //   context.read<PageBloc>().add(GoToMainPage());
    // }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : (pageState is OnRegistrationPage)
                    ? SignUpPage(pageState.registrationData)
                    : MainPage());
  }
}
