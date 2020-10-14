part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //logic islogin if else dll
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnLoginSignupPage)
            ? LoginSignupPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : (pageState is OnMainPage) ? MainPage() : Container());
  }
}

// ? LoginSignupPage()
//                 : (pageState is OnLoginSignupPage)
