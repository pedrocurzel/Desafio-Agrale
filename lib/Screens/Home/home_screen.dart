import 'package:agrale/screens/chassi/consulta_chassi_screen.dart';
import 'package:agrale/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class HomeScreen extends StatefulWidget {
  final Function changePageFunction;
  HomeScreen({Key? key, required this.changePageFunction}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> acompanhamentosItems = [
    {"icon": Icons.chat, "label": "Lorem Ipsum", "navigateTo": null},
    {"icon": Icons.monetization_on, "label": "Lorem Ipsum", "navigateTo": null},
    {"icon": Icons.construction, "label": "Lorem Ipsum", "navigateTo": null},
    {"icon": Icons.chat, "label": "Lorem Ipsum", "navigateTo": null}
  ];

  List<Map<String, dynamic>> consultasCard = [
    {"icon": Icons.search, "label": "Consulta por chassi", "navigateTo": 1},
    {"icon": Icons.question_mark, "label": "Lorem Ipsum", "navigateTo": 2}
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          buildConsultasSection(),
          SizedBox(
            height: 10,
          ),
          buildAcompanhamentosSection()
        ],
      );
  }

  Widget buildSectionTitle(String sectionLabel) {
    return Row(
      children: [titleText(sectionLabel)],
    );
  }

  Widget buildAcompanhamentosSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: buildSectionTitle("Acompanhamentos"),
        ),
        buildHorizontalList(acompanhamentosItems)
      ],
    );
  }

  Widget buildConsultasSection() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          buildSectionTitle("Consultas"),
          SizedBox(
            height: 10,
          ),
          for (var consultaCard in consultasCard)
            buildConsultaCard(consultaCard)
        ],
      ),
    );
  }

  Widget buildConsultaCard(dynamic consultaCard) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                if (consultaCard["navigateTo"] != null) {
                  widget.changePageFunction(consultaCard["navigateTo"]);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      consultaCard["icon"],
                      size: 40,
                      color: Color(darkGrey),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      consultaCard["label"],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(darkGrey)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
