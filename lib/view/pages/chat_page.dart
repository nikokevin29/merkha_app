part of 'pages.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Chat', style: blackTextFont.copyWith(fontSize: 22)),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('rooms')
                  .orderBy('created_at')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        buildItem(context, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    return FlatButton(
      onPressed: () {
        Get.to(DetailChat(
          peerAvatar: document.data()['url_photo'],
          peerId: document.data()['id_merchant'],
          peerName: document.data()['merchant_name']
        ));
      },
      child: Card(
        shadowColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: (document.data()['url_photo'] != null)
                          ? NetworkImage(document.data()['url_photo'])
                          : AssetImage('assets/defaultProfile.png'),
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(document.data()['merchant_name'], style: blackMonstadtTextFont),
                    // Text('Ok, ill Send The Product  Tommorow Il go go go go go go',
                    //     style: blackMonstadtTextFont.copyWith(fontSize: 10),
                    //     maxLines: 1,
                    //     overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
