part of 'widgets.dart';

class TextDividerOrder extends StatelessWidget {
  final String text;
  TextDividerOrder({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: blackTextFont.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: HexColor('#707070'),
        ),
      ),
    );
  }
}