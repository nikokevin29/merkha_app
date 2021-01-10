part of 'pages.dart';

class DetailProduct extends StatelessWidget {
  final Product product;
  DetailProduct({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.grey,
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 35,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: (product.merchantLogo.toString() != null)
                        ? NetworkImage(product.merchantLogo)
                        : AssetImage('assets/defaultProfile.png')),
                boxShadow: [
                  BoxShadow(spreadRadius: 3, blurRadius: 7, color: Colors.black12),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 200,
                  child: Text(
                    product.merchant.toString(),
                    style: blackTextFont.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text(
                  product.merchantLocation.toString(),
                  style: blackTextFont.copyWith(fontSize: 8, fontWeight: FontWeight.w200),
                ),
              ],
            )
          ],
        ),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.grey),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 'more',
                        child: InkWell(
                          onTap: () {
                            //Action here
                            print(product.photo);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_alarm_sharp,
                                color: Colors.grey,
                              ),
                              Text(' Option'),
                            ],
                          ),
                        )),
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: defaultMargin),
          child: Column(
            children: [
              //note: Image Product
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width - (2 * defaultMargin),
                ),
                items: product.photo
                    .substring(1, product.photo.length - 1)
                    .split(', ')
                    .toList()
                    .map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(i),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(spreadRadius: 3, blurRadius: 7, color: Colors.black12)
                          ],
                        ),
                        //child: Text(i ?? 'Image not Found'), //Debug Show Link image
                      );
                    },
                  );
                }).toList(),
              ),
              Divider(color: Colors.transparent, height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // note: Product Name
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(product.productName,
                        style: blackTextFont.copyWith(fontWeight: FontWeight.w400, fontSize: 20),
                        overflow: TextOverflow.clip),
                  ),
                  //note: Wishlist Button
                  SizedBox(
                    height: 22,
                    width: 17,
                    child: InkWell(
                      child: Icon(Icons.bookmark_border, color: Colors.grey),
                      onTap: () {
                        print('tap bookmark detaill product');
                        context.read<WishlistCubit>().addWishlist(Wishlist(idProduct: product.id));
                        Get.snackbar('Product Added', product.productName + ' Added to Wishlist');
                      },
                    ),
                  ),
                ],
              ),
              // note: Price Product
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(product.price.toDouble()),
                  style: redNumberFont.copyWith(fontSize: 20),
                ),
              ),
              //note: Rating Product
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 8),
                  Text('4.9', style: redNumberFont.copyWith(color: Colors.grey)),
                  SizedBox(width: 5),
                  Text('(13 Rating)', style: blackTextFont.copyWith(color: Colors.grey)),
                ],
              ),
              Divider(),
              // note: Description
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                    SizedBox(height: 9),
                    //note: Description
                    Text(
                      product.description,
                      style:
                          blackMonstadtTextFont.copyWith(fontSize: 14, fontWeight: FontWeight.w200),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Review', style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                    SizedBox(height: 9),
                    //note: Review Product (Belum Jadi)
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width - (2 * defaultMargin),
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Information Details',
                        style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                    SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Seller',
                            style: blackMonstadtTextFont.copyWith(
                                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w100)),
                        Text(product.merchant.toString(),
                            style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Seller Location',
                            style:
                                blackMonstadtTextFont.copyWith(fontSize: 14, color: Colors.grey)),
                        Text(product.merchantLocation.toString(),
                            style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Weight',
                            style:
                                blackMonstadtTextFont.copyWith(fontSize: 14, color: Colors.grey)),
                        Text(product.weight.toString() + ' Grams',
                            style: redNumberFont.copyWith(fontSize: 14, color: Colors.black)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Category',
                            style:
                                blackMonstadtTextFont.copyWith(fontSize: 14, color: Colors.grey)),
                        Text(product.category.toString(),
                            style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Seller Website',
                            style:
                                blackMonstadtTextFont.copyWith(fontSize: 14, color: Colors.grey)),
                        Text(product.website.toString(),
                            style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                    SizedBox(height: 88)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 88,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          alignment: Alignment.center,
          child: Wrap(
            spacing: 15,
            runSpacing: 5,
            children: [
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                minWidth: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.7,
                color: Colors.blue,
                child: Text(
                  'BUY',
                  style: blackTextFont.copyWith(
                      fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  print('Buy Tapped');
                },
              ),
              InkWell(
                onTap: () {
                  print('Chat Tapped');
                },
                child: SizedBox(
                  height: 50,
                  width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.2,
                  child: Icon(Icons.chat, color: HexColor('#373E4C')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
