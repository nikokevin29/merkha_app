part of 'pages.dart';

class DetailChat extends StatelessWidget {
  final String peerId; //Merchant_id
  final String peerAvatar; //Merhchant_Url // Bakal Ngebug kalo peerAvatar Null
  final String peerName;

  DetailChat({Key key, @required this.peerId, @required this.peerAvatar, this.peerName})
      : super(key: key);

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
        title: Row(
          children: [
            Image.network(peerAvatar, fit: BoxFit.cover, height: 30),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                peerName ?? '',
                style: blackTextFont.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      body: ChatScreen(
        peerId: peerId,
        peerAvatar: peerAvatar,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerAvatar;

  ChatScreen({Key key, @required this.peerId, @required this.peerAvatar}) : super(key: key);

  @override
  State createState() => ChatScreenState(peerId: peerId, peerAvatar: peerAvatar);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.peerId, @required this.peerAvatar});

  String peerId;
  String peerAvatar;
  String id;

  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId;
  SharedPreferences prefs;

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        print("reach the bottom");
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <= listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);

    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    id = (context.read<UserCubit>().state as UserLoaded).user.id.toString();

    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    FirebaseFirestore.instance.collection(id).doc(peerId).update({'chattingWith': peerId});

    setState(() {});
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fb_storage.Reference reference =
        fb_storage.FirebaseStorage.instance.ref('chat_photo').child(fileName);
    fb_storage.UploadTask uploadTask = reference.putFile(imageFile);
    fb_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Error', 'This file is not an image');
    });
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();
      //TODO: onSend Messeage
      var documentReference = FirebaseFirestore.instance
          // .collection('messages')
          // .doc(groupChatId)
          // .collection(groupChatId)
          .collection('rooms')
          .doc(peerId + '-' + id) //idMerchant-idUser
          .collection('message')
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'id_room': peerId + '-' + id,
            'from': 'user',
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Get.snackbar('Nothing to send', 'Nothing Message to Send');
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document.data()['idFrom'] == id && document.data()['from'] == 'user') {
      // Right (my message)
      return Column(
        children: <Widget>[
          document.data()['type'] == 0
              // Text
              ? Bubble(
                  alignment: Alignment.centerRight,
                  stick: true,
                  nip: BubbleNip.rightTop,
                  color: Colors.blueAccent,
                  child: Text(document.data()['content'],
                      style: blackTextFont.copyWith(color: Colors.white)),
                )
              : document.data()['type'] == 1
                  // Image
                  ? Container(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                'assets/img_not_available.jpeg',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: document.data()['content'],
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Get.to(FullPhoto(url: document.data()['content']));
                        },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(bottom: 2.0, right: 10.0),
                    )
                  // Sticker
                  : Container(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(0.0, 2.0, 20.0, 10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateFormat('dd MMM kk:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(int.parse(document.data()['timestamp']))),
                style: TextStyle(color: Colors.grey, fontSize: 10.0, fontStyle: FontStyle.italic),
              ),
            ),
          )
        ],
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Material(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      width: 35.0,
                      height: 35.0,
                      padding: EdgeInsets.all(10.0),
                    ),
                    imageUrl: peerAvatar,
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                document.data()['type'] == 0
                    ? Bubble(
                        alignment: Alignment.centerLeft,
                        stick: true,
                        nip: BubbleNip.leftTop,
                        color: Colors.greenAccent,
                        child: Text(document.data()['content'],
                            style: blackTextFont.copyWith(color: Colors.white)),
                      )
                    : document.data()['type'] == 1
                        ? Container(
                            alignment: Alignment.bottomLeft,
                            child: FlatButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                    ),
                                    width: 200.0,
                                    height: 200.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Material(
                                    child: Image.asset(
                                      'assets/img_not_available.jpeg',
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: document.data()['content'],
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                Get.to(FullPhoto(url: document.data()['content']));
                              },
                              padding: EdgeInsets.all(0),
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        : Container(),
              ],
            ),
            Container(
              child: Text(
                DateFormat('dd MMM kk:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(int.parse(document.data()['timestamp']))),
                style: TextStyle(color: Colors.grey, fontSize: 10.0, fontStyle: FontStyle.italic),
              ),
              margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  // bool isLastMessageLeft(int index) {
  //   if ((index > 0 && listMessage != null && listMessage[index - 1].data()['idFrom'] == id) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // bool isLastMessageRight(int index) {
  //   if ((index > 0 && listMessage != null && listMessage[index - 1].data()['idFrom'] != id) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      FirebaseFirestore.instance.collection(id).doc(peerId).update({'chattingWith': null});
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // // Sticker
              // (isShowSticker ? buildSticker() : Container()),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? const CircularProgressIndicator() : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: getImage,
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 0);
                },
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: greyColor),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(
              child:
                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder(
              //TODO: Build Message
              stream: FirebaseFirestore.instance
                  .collection('rooms')
                  .doc(peerId + '-' + id)
                  .collection('message')
                  .orderBy('timestamp', descending: true)
                  .limit(_limit)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
                } else {
                  listMessage.addAll(snapshot.data.documents);
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }
}
