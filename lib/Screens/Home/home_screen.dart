import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const List<Map<String, dynamic>> acompanhamentosItems = [
    {
      "icon": Icons.chat,
      "label": "Lorem Ipsum",
      "navigateTo": null
    },
    {
      "icon": Icons.monetization_on,
      "label": "Lorem Ipsum",
      "navigateTo": null
    },
    {
      "icon": Icons.construction,
      "label": "Lorem Ipsum",
      "navigateTo": null
    },
    {
      "icon": Icons.chat,
      "label": "Lorem Ipsum",
      "navigateTo": null
    }
  ];

  static const List<Map<String, dynamic>> consultasCard = [
    {
      "icon": Icons.search,
      "label": "Consulta por chassi",
      "navigateTo": null
    },
    {
      "icon": Icons.question_mark,
      "label": "Lorem Ipsum",
      "navigateTo": null
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildConsultasSection(),
        SizedBox(height: 10,),
        buildAcompanhamentosSection()
      ],
    );
  }

  Widget buildSectionTitle(String sectionLabel) {
    return Row(
      children: [
        titleText(sectionLabel)
      ],
    );
  }

  Widget buildAcompanhamentosSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: buildSectionTitle("Acompanhamentos"),
        ),
        buildAcompanhamentosList()
      ],
    );
  }

  Widget buildAcompanhamentosList() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 10),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: acompanhamentosItems.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                color: Color(baseRed),
                child: InkWell(
                  onTap: (){},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(acompanhamentosItems[index]["icon"] as IconData, color: Colors.white, size: 30,),
                      Text(acompanhamentosItems[index]["label"] as String , style: TextStyle(
                          color: Colors.white,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildConsultasSection() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          buildSectionTitle("Consultas"),
          SizedBox(height: 10,),
          for(var consultaCard in consultasCard)
            buildConsultaCard(consultaCard["icon"] as IconData, consultaCard["label"] as String)
        ],
      ),
    );
  }

  Widget buildConsultaCard(IconData iconName, String label) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            elevation: 4,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(iconName, size: 40, color: Color(darkGrey),),
                    SizedBox(width: 15,),
                    Text(label, style: TextStyle(
                        fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(darkGrey)
                    ),)
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
