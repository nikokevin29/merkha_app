part of "widgets.dart";

class VoucherCard extends StatelessWidget {
  final Voucher voucher;
  const VoucherCard(this.voucher);

  @override
  Widget build(BuildContext context) {
    var dates = DateTime.parse(voucher.validDate);
    return Column(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(voucher.merchantLogo ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.48,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                voucher.merchant,
                                style: blackTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                voucher.voucherName,
                                style: blackTextFont.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#403E3E'),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: (voucher.voucherType == "Rate")
                              ? Text(
                                  "Discount " + ((voucher.discRate * 10) + 1).toString() + ' %',
                                  style: redNumberFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#403E3E'),
                                  ),
                                )
                              : Text(
                                  NumberFormat.currency(
                                          locale: 'id', symbol: 'IDR ', decimalDigits: 0)
                                      .format(voucher.discAmount),
                                  style: redNumberFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#403E3E'),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(children: [
                  SizedBox(width: 5),
                  Text(
                    'VALID\nTHRU',
                    style: blackTextFont.copyWith(
                        fontSize: 8, color: Colors.grey, fontWeight: FontWeight.w200),
                  ),
                  SizedBox(width: 5),
                  Column(
                    children: [
                      Text(
                        formatDate(dates, [dd, '/', mm, '/', yy]),
                        style: redNumberFont.copyWith(fontSize: 12),
                      ),
                      Text(
                        formatDate(dates, [H, ':', nn, ':', s]),
                        style: redNumberFont.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
        //
      ],
    );
  }
}
