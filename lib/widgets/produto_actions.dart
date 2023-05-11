import 'package:agrale/Screens/Menu/menu_screen.dart';
import 'package:flutter/material.dart';

import '../consts/consts.dart';
import '../models/produto.dart';

class ProdutoActions extends StatefulWidget {
  ProdutoActions({super.key, required this.product});
  final Produto product;

  @override
  State<ProdutoActions> createState() => _ProdutoActionsState();
}

class _ProdutoActionsState extends State<ProdutoActions> {
  List<Map<String, dynamic>> acoesItems = [
    {"icon": Icons.chat, "label": "Lorem Ipsum", "navigateTo": "/menu"},
    {"icon": Icons.monetization_on, "label": "Lorem Ipsum", "navigateTo": null},
    {"icon": Icons.construction, "label": "Lorem Ipsum", "navigateTo": null},
    {"icon": Icons.chat, "label": "Lorem Ipsum", "navigateTo": null}
  ];

  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          child: Expanded(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 18, bottom: 10),
                      child: titleText("Ações para o produto"),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: buildHorizontalList(acoesItems),
                ),
                Padding(
                  padding: EdgeInsets.all(18),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(lightGrey),
                          borderRadius: BorderRadius.circular(15)),
                      child: ExpansionTile(
                        initiallyExpanded: isExpanded,
                        onExpansionChanged: (value) {
                          setState(() {
                            isExpanded = value;
                          });
                        },
                        iconColor: Color(darkGrey),
                        trailing: AnimatedRotation(
                          duration: Duration(milliseconds: 200),
                          turns: isExpanded ? 0.25 : 0.75,
                          child: Icon(Icons.arrow_back_ios),
                        ),
                        title: titleText("Dados do produto"),
                        children: [Text("123")],
                      ),
                    ),
                  ),
                )
              ],
            )),
      )),
    );
  }
}
