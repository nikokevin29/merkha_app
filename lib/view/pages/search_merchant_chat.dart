part of 'pages.dart';

class SearchMerchantChatPage extends StatefulWidget {
  @override
  _SearchMerchantChatPageState createState() => _SearchMerchantChatPageState();
}

class _SearchMerchantChatPageState extends State<SearchMerchantChatPage> {
  TextEditingController searchMerhcantController = TextEditingController();
  List<Merchant> merchant;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        context.read<SearchMerchantCubit>().clear();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Search Merchant Chat', style: blackTextFont.copyWith(fontSize: 22)),
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
              context.read<SearchMerchantCubit>().clear();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Expanded(
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
                    return Column(
                      children: [
                        Container(
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
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          FirebaseFirestore.instance
                                              .collection('rooms')
                                              .doc(merchant[index].merchantId.toString() +
                                                  '-' +
                                                  (context.read<UserCubit>().state as UserLoaded)
                                                      .user
                                                      .id
                                                      .toString()) //idMerchant-idUser
                                              .set({
                                            'id_merchant':
                                                merchant[index].merchantId.toString(), //Id Merchant
                                            'id_user':
                                                (context.read<UserCubit>().state as UserLoaded)
                                                    .user
                                                    .id
                                                    .toString(), //Id Merchant
                                            'url_photo': merchant[index].merchantLogo,
                                            'merchant_name': merchant[index].merchantName,
                                            'created_at': DateTime.now(),
                                          });
                                          Get.to(DetailChat(
                                              peerId: merchant[index].merchantId.toString(),
                                              peerAvatar: merchant[index].merchantLogo,
                                              peerName: merchant[index].merchantName));

                                          //
                                        },
                                        child: ListTile(
                                          leading: Container(
                                              child: (merchant[index].merchantLogo != null)
                                                  ? CachedNetworkImage(
                                                      height: 40,
                                                      width: 40,
                                                      imageUrl: merchant[index].merchantLogo,
                                                      progressIndicatorBuilder:
                                                          (context, url, downloadProgress) =>
                                                              CircularProgressIndicator(
                                                                  value: downloadProgress.progress),
                                                      errorWidget: (context, url, error) =>
                                                          Icon(Icons.error),
                                                      imageBuilder: (context, imageProvider) =>
                                                          Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.white),
                                                          borderRadius: BorderRadius.circular(30),
                                                          image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.2),
                                                              spreadRadius: 4,
                                                              blurRadius: 4,
                                                              offset: Offset(0,
                                                                  1), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'assets/defaultProfile.png')),
                                                        border: Border.all(color: Colors.white),
                                                        borderRadius: BorderRadius.circular(100),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.2),
                                                            spreadRadius: 4,
                                                            blurRadius: 4,
                                                            offset: Offset(
                                                                0, 1), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                          title: Expanded(
                                            child: Text(
                                              merchant[index].merchantName ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: blackTextFont.copyWith(),
                                            ),
                                          ),
                                          subtitle: Text(
                                            '@' + merchant[index].merchantUsername ?? '',
                                            style: blackTextFont.copyWith(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                                )
                              : Center(
                                  child: Text(
                                    'Not Found',
                                    style: blackTextFont.copyWith(fontSize: 16, color: Colors.red),
                                  ),
                                ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
