import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const int baseRed = 0xFFCD202C;
const int lightGrey = 0xFFCCCCCC;
const int darkGrey = 0xFF4D4D4D;
const int appGrey = 0xFF8C8C8C;
const backgroundWhite = 0xFFE5E5E5;
const int expansionBg = 0xFFE6E6E6;
const int alertTextColor = 0xFF1A1A1A;
const int appYellow = 0xFFF7D002;
const int selectedRed = 0xFFCD202C;
const int adicionarImagensButtonColor = 0xFFF5F5F5;

const double defaultSpanFontSize = 25;

BorderRadius appDefaultBorderRadius = BorderRadius.circular(15);
SystemUiOverlayStyle toolbarDefaultSettings = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
);
PreferredSize defaultAppBarBottom = PreferredSize(
  preferredSize: Size.fromHeight(1),
  child: Container(
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(lightGrey)))),
  ),
);

UnderlineInputBorder lightGreyInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(
        color: Color(lightGrey),
        width: 1
    )
);

OutlineInputBorder zerarBordasInput = OutlineInputBorder(
    borderSide: BorderSide(
      width: 0,
      color: Colors.transparent,
    ));

Widget titleText(String text, {double? fontSize}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize ?? 20,
        fontWeight: FontWeight.w700,
        color: Color(darkGrey)),
  );
}

TextSpan baseTextSpan(String text, bool isBold, int textColor, {double fontSize = 18}) {
  return TextSpan(
    text: text,
    style: TextStyle(
        fontSize: fontSize,
        color: Color(textColor),
        fontWeight: !isBold ? FontWeight.normal : FontWeight.bold),
  );
}

Widget buildHorizontalList(List<Map<String, dynamic>> items) {
  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: index == 0 ? 14 : 0),
          width: MediaQuery.of(context).size.width / 2.5,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: appDefaultBorderRadius),
            color: Color(baseRed),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: appDefaultBorderRadius,
              ),
              onTap: () {
                if (items[index]['navigateTo'] != null) {
                  Navigator.pushNamed(context, items[index]['navigateTo']);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    items[index]["icon"] as IconData,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    items[index]["label"] as String,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

