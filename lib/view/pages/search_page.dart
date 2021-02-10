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
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        context.read<SearchProductCubit>().clear();
        context.read<SearchMerchantCubit>().clear();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Search', style: blackTextFont),
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
              context.read<SearchProductCubit>().clear();
              context.read<SearchMerchantCubit>().clear();
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
      ),
    );
  }
}
