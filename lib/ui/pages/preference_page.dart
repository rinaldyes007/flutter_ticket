part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;
  final List<String> genres = [
    "Horor",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];
  final List<String> languanges = ["Bahasa", "English", "Japanese", "Korean"];

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguange = "english";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          context
              .read<PageBloc>()
              .add(GoToRegistrationPage(widget.registrationData));
          return;
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 56,
                    margin: EdgeInsets.only(top: 20, bottom: 4),
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<PageBloc>()
                            .add(GoToRegistrationPage(widget.registrationData));
                        return;
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    "Select Your Four\nFavorite Genres",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenreWidgets(context),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Movie Languange\nYou Prefer?",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLangWidgets(context),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: mainColor,
                      child: Icon(
                        Icons.arrow_forward,
                      ),
                      onPressed: () {
                        if (selectedGenres.length != 4) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Please Select 4 Genres",
                          )..show(context);
                        } else {
                          widget.registrationData.selectedGenres =
                              selectedGenres;
                          widget.registrationData.selectedLang =
                              selectedLanguange;
                          context.read<PageBloc>().add(
                              GoToAccountConfirmationPage(
                                  widget.registrationData));
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedGenres.contains(e),
              onTap: () {
                onSelectGenre(e);
              },
            ))
        .toList();
  }

  List<Widget> generateLangWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languanges
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguange == e,
              onTap: () {
                setState(() {
                  selectedLanguange = e;
                });
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else if (selectedGenres.length < 4) {
      setState(() {
        selectedGenres.add(genre);
      });
    }
  }
}
