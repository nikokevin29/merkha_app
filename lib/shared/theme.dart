part of 'shared.dart';

const double defaultMargin = 16;

Color mainColor = Color(0xFF503E9D);
Color accentColor1 = Color(0xFF2C1F63);
Color accentColor2 = HexColor("#C5EA2A");
Color accentColor3 = HexColor("#707070");

TextStyle blackTextFont =
    GoogleFonts.roboto().copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont =
    GoogleFonts.roboto().copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle purpleTextFont =
    GoogleFonts.roboto().copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont =
    GoogleFonts.roboto().copyWith(color: accentColor3, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont = GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle redNumberFont = GoogleFonts.openSans().copyWith(color: HexColor('#DB0B00'));
