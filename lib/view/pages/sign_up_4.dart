part of 'pages.dart';

//User Interest
class SignUp4 extends StatefulWidget {
  @override
  _SignUp4State createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4> {
  List<String> selectedCat = [];
  List<S2Choice<String>> cat = [];
  final _catMemoizer = AsyncMemoizer<List<S2Choice<String>>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    //tap here
                    Get.to(SignUp5());
                  },
                  child: Text(
                    "Skip",
                    style: blackTextFont.copyWith(
                        fontSize: 24, fontWeight: FontWeight.w100, color: HexColor('#a0a0a0')),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Choose your\ninterests",
                style: blackTextFont.copyWith(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Get personalized recommendations\n"+"Pick 5 or more interests.",
                style: blackTextFont.copyWith(color: accentColor3, fontWeight: FontWeight.w100),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: FutureBuilder<List<S2Choice<String>>>(
                  initialData: [],
                  future: this._catMemoizer.runOnce(fetchCategory),
                  builder: (context, snapshot) {
                    if (snapshot != null) {
                      return SmartSelect<String>.multiple(
                          title: 'Category',
                          value: selectedCat,
                          modalFilter: true,
                          choiceItems: snapshot.data,
                          choiceType: S2ChoiceType.checkboxes,
                          placeholder: 'Select Minimum 5 Category',
                          onChange: (state) => setState(() => selectedCat = state.value),
                          choiceDirection: Axis.vertical,
                          tileBuilder: (context, state) {
                            print('Selected Category : '+selectedCat.toString()); // This Value being update by change in Framework
                            return S2Tile.fromState(
                              state,
                              isTwoLine: true,
                              isLoading: snapshot.connectionState == ConnectionState.waiting,
                              leading: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(Icons.category),
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Divider(
                height: 30,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: FlatButton(
                    disabledColor: Color(0xFFE4E4E4),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    color: accentColor2,
                    child: Text(
                      "Next",
                      style: blackTextFont.copyWith(
                          fontSize: 16, color: accentColor3, fontWeight: FontWeight.bold),
                    ),
                    onPressed: (selectedCat.length != 0 && selectedCat.length >= 5)
                        ? () async {
                            Get.to(SignUp5(selectedCat: selectedCat));
                          }
                        : null,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<List<S2Choice<String>>> fetchCategory({http.Client client, String query}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'product/category/show';
    var response = await client.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode != 200) {
      print('status code ${response.statusCode} ');
      return null;
    }
    var data = jsonDecode(response.body);
    var dat = data['data'];
    return S2Choice.listFrom<String, dynamic>(
      source: dat,
      value: (index, item) => item['id'].toString(),
      title: (index, item) => item['category_name'],
    );
  }
}
