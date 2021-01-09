part of 'pages.dart';

class SearchMerchant extends StatefulWidget {
  @override
  _SearchMerchantState createState() => _SearchMerchantState();
}

class _SearchMerchantState extends State<SearchMerchant> {
  List<Merchant> merchant;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchMerhcantController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 5),
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.teal)),
                suffixIcon: InkWell(
                    child: Icon(Icons.search),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode()); //Close Keyboard
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      await context
                          .read<SearchMerchantCubit>()
                          .searchFilterMerchant(keyword: searchMerhcantController.text);
                      Navigator.pop(context);
                    }),
              ),
              autocorrect: false,
              controller: searchMerhcantController,
            ),
            Divider(),
            BlocBuilder<SearchMerchantCubit, SearchMerchantState>(builder: (_, state) {
              if (state is SearchMerchantLoaded) {
                merchant = state.merchant;
                return Container(
                  width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                  child: (merchant.length != 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: merchant.length,
                          itemBuilder: (_, index) => Container(
                              child: Wrap(
                            alignment: WrapAlignment.center,
                            direction: Axis.horizontal,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              MerchantSearchCard(merchant: merchant[index]),
                            ],
                          )),
                        )
                      : Center(
                          child: Text(
                            'Not Found',
                            style: blackTextFont.copyWith(fontSize: 16, color: Colors.red),
                          ),
                        ),
                );
              } else {
                return Container();
              }
            }),
          ]),
        ),
      ),
    );
  }
}
