import 'package:agrale/Screens/Menu/menu_screen.dart';
import 'package:agrale/screens/solicitar_atendimento/solicitar_atendimento_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    {
      "icon": Icons.chat,
      "label": "Nova solicitação de atendimento",
      "navigateTo": null
    },
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
                acoesSection(),
                Row(
                  children: [dadosProdutoSection()],
                )
              ],
            )),
      )),
    );
  }

  Widget acoesSection() {
    return Column(
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
            child: SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: listCard(
                        Icons.chat, "Nova solicitação de atendimento",
                        callback: goToSolicitarAtendimento),
                  ),
                  listCard(Icons.question_mark, "Lorem Ipsum"),
                  listCard(Icons.question_mark, "Lorem Ipsum"),
                  listCard(Icons.question_mark, "Lorem Ipsum")
                ],
              ),
            )),
      ],
    );
  }

  void goToSolicitarAtendimento() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SolicitarAtendimentoScreen(
                  produto: widget.product,
                )));
  }

  Widget listCard(IconData iconName, String label, {Function? callback}) {
    return Container(
      decoration: BoxDecoration(borderRadius: appDefaultBorderRadius),
      //padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width / 2.5,
      child: Card(
        color: Color(baseRed),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: appDefaultBorderRadius),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: appDefaultBorderRadius,
          ),
          onTap: () {
            if (callback != null) {
              callback();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconName,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dadosProdutoSection() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Container(
          decoration: BoxDecoration(
              color: Color(expansionBg), borderRadius: appDefaultBorderRadius),
          child: Theme(
            data: ThemeData(fontFamily: 'Verdana')
                .copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor: Color(darkGrey),
              title: titleText("Dados do produto"),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: appDefaultBorderRadius),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        buildInfoRow("Produto: ", widget.product.name),
                        buildInfoRow("Motor: ", widget.product.engineNumber),
                        buildInfoRow("Chassi Secundário: ",
                            widget.product.secondaryFrameNumber),
                        buildInfoRow(
                            "Data da NF Fabricante: ",
                            DateFormat("dd/MM/yyyy")
                                .format(widget.product.builderNfDate)),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                          child: Divider(
                            height: 1,
                            color: Color(appGrey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 10),
                          child: Row(
                            children: [
                              titleText("Sobre a venda", fontSize: 18)
                            ],
                          ),
                        ),
                        buildInfoRow("Nome do Proprietário: ",
                            widget.product.venda.ownerName),
                        buildInfoRow("Cidade/UF: ",
                            "${widget.product.venda.city}/${widget.product.venda.uf}"),
                        buildInfoRow(
                            "Data da NF de Venda: ",
                            DateFormat("dd/MM/yyyy")
                                .format(widget.product.venda.sellNfDate)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String info, {bool isTitle = false}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: TextStyle(color: Color(darkGrey), fontSize: 15))),
          Flexible(
            child: Text(
              info,
              style: TextStyle(
                  color: Color(darkGrey),
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}

//trailing: AnimatedRotation(
//  duration: Duration(milliseconds: 200),
//  turns: isExpanded ? 0.25 : 0.75,
//  child: Icon(Icons.arrow_back_ios),
//)