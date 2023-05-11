import 'package:flutter/material.dart';

const int baseRed = 0xFFCD202C;
const int lightGrey = 0xFFCCCCCC;
const int darkGrey = 0xFF4D4D4D;
const int appGrey = 0xFF8C8C8C;
const backgroundWhite = 0xFFE5E5E5;

Widget titleText(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Color(darkGrey)),
  );
}

TextSpan baseTextSpan(String text, bool isBold) {
  return TextSpan(
    text: text,
    style: TextStyle(
        fontSize: 18,
        color: Color(appGrey),
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
                margin: EdgeInsets.only(left: index == 0 ? 18 : 0),
                width: MediaQuery.of(context).size.width / 2.5,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Color(baseRed),
                  child: InkWell(
                    onTap: () {
                      if (items[index]['navigateTo'] != null) {
                        Navigator.pushNamed(
                            context, items[index]['navigateTo']);
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
