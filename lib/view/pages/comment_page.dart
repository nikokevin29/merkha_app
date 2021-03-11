part of 'pages.dart';

class CommentPage extends StatefulWidget {
  final Feed feed;
  CommentPage({this.feed});
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() async {
    await context.read<CommentCubit>().showCommentById(widget.feed.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Comments', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              Container(
                  child: BlocBuilder<CommentCubit, CommentState>(
                builder: (_, state) => (state is CommentListLoaded)
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(widget.feed.merchantUsername ?? widget.feed.username,
                                style: blackTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(widget.feed.caption,
                                      style: blackTextFont.copyWith(fontSize: 14),
                                      textAlign: TextAlign.justify,
                                      maxLines: 10),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: state.comment
                                .map(
                                  (e) => ListTile(
                                    tileColor: Colors.white,
                                    title: Text(
                                      (e.idUser == null) ? e.merchantUsername : e.userName,
                                      style: blackMonstadtTextFont.copyWith(fontSize: 14),
                                    ),
                                    subtitle: Text(e.comment,
                                        style: blackMonstadtTextFont.copyWith(fontSize: 12)),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
              )),
              buildInput(),
            ],
          ),
        ),
      ),
      // bottomSheet: Container(
      //   height: MediaQuery.of(context).size.height * 0.1,
      //   alignment: Alignment.center,
      //   child: Container(
      //     padding: EdgeInsets.symmetric(horizontal: 10),
      //     child: Column(
      //       children: [
      //         Row(
      //           children: [
      //             Expanded(
      //                 child: TextField(
      //               controller: commentController,
      //               focusNode: focusNode,
      //               decoration: InputDecoration(labelText: "Type your comments here"),
      //             )),
      //             FlatButton(
      //               minWidth: 50,
      //               child: Icon(Icons.send),
      //               onPressed: () {
      //                 print('Tap Send Comment');
      //               },
      //             ),
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget buildInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {},
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: commentController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your comments...',
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
                onPressed: () {
                  onSendComment(Comment(
                    comment: commentController.text,
                    idFeed: widget.feed.id,
                  ));
                },
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

  void onSendComment(Comment comment) async {
    print('ID FEED ' + widget.feed.id.toString());
    if (comment.comment.trim() != '') {
      commentController.clear();
      await context.read<CommentCubit>().sendComment(comment);
      await context
          .read<CommentCubit>()
          .showCommentById(widget.feed.id.toString()); //Reload All Comments
      //TODO: here
    } else {
      Get.snackbar('Nothing to Send', 'Nothing Comment to Send');
    }
  }
}
