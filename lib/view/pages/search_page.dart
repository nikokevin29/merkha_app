part of 'pages.dart';

class SearchPage extends StatefulWidget {
  final int index;
  SearchPage({this.index = 0});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this, initialIndex: widget.index);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Search', style: blackTextFont),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          controller: controller,
          tabs: [
            Tab(text: 'Product'),
            Tab(text: 'Merchant'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          SearchProduct(),
          SearchMerchant(),
        ],
      ),
    );
  }
}

// Material(
//   borderRadius: BorderRadius.circular(20.0),
//   elevation: 20,
//   child: TextFormField(
//     controller: null,
//     autofocus: false,
//     style: TextStyle(fontSize: 16.0, color: Color(0xFFbdc6cf)),
//     decoration: InputDecoration(
//       filled: true,
//       fillColor: Colors.white,
//       prefixIcon: Icon(Icons.search),
//       hintText: 'What are you looking for ?',
//       contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 14.0),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       enabledBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: Colors.white),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     ),
//   ),
// ),
