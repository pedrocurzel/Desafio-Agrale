import 'package:agrale/models/produto.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class SolicitarAtendimentoScreen extends StatefulWidget {
  const SolicitarAtendimentoScreen({super.key, required this.produto});
  final Produto produto;

  @override
  State<SolicitarAtendimentoScreen> createState() =>
      _SolicitarAtendimentoScreenState();
}

class _SolicitarAtendimentoScreenState extends State<SolicitarAtendimentoScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 8, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        cancelarSolicitacao();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: toolbarDefaultSettings,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                cancelarSolicitacao();
              },
              icon: Icon(Icons.close),
              color: Color(darkGrey)),
          title: Column(
            children: [
              defaultAppBarText("Nova solicitação de atendimento"),
              defaultAppBarText(widget.produto.engineNumber),
            ],
          ),
          backgroundColor: Colors.white,
          bottom: defaultAppBarBottom,
        ),
        body: TabBarView(
          controller: tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text("1"),
            Text("2"),
            Text("3"),
            Text("4"),
            Text("5"),
            Text("6"),
            Text("7"),
            Text("8")
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(right: 20, left: 20),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Row(
                  children: [
                    tabController.index == 0 ? cancelButton() : voltarButton(),
                  ],
                )
              ),
              tabController.index < 7
                    ? proximoButton()
                    : concluirButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget cancelButton() {
    return TextButton(
      onPressed: () {
        cancelarSolicitacao();
      },
      child: Text(
        "Cancelar Solicitação",
        style: TextStyle(color: Color(darkGrey)),
      ),
    );
  }

  Widget concluirButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Icon(
        Icons.check,
        size: 35,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          fixedSize: Size(80, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    );
  }

  Widget proximoButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          tabController.animateTo(tabController.index + 1);
        });
      },
      child: Icon(
        Icons.arrow_forward,
        size: 35,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(baseRed),
          fixedSize: Size(80, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    );
  }

  Widget voltarButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          tabController.animateTo(tabController.index - 1);
        });
      },
      child: Text(
        "Voltar",
        style: TextStyle(color: Color(darkGrey)),
      ),
    );
  }

  void cancelarSolicitacao() async {
    var dialogResponse = await showDialog(
        //barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Color(alertTextColor),
                    ))
              ],
            ),
            content: Container(
              height: 285,
              width: MediaQuery.of(context).size.width - 130,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cancelar solicitação",
                        style: TextStyle(
                            color: Color(alertTextColor),
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 200,
                    child: Text(
                      "A solicitação ainda não foi criada. Ao cancelar, você perderá os dados informados. Deseja cancelar?",
                      style:
                          TextStyle(color: Color(alertTextColor), fontSize: 15),
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  buildAlertButtons("Cancelar solicitação", () {
                    return Navigator.pop(context, "cancelou");
                  }, isCancelButton: true),
                  buildAlertButtons("Salvar Rascunho", () {}),
                  buildAlertButtons("Continuar solicitação", () {})
                ],
              ),
            ),
          );
        });
    if (dialogResponse == "cancelou") {
      Navigator.pop(context);
    }
  }

  buildAlertButtons(String text, Function callback,
      {bool isCancelButton = false}) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              callback();
            },
            child: Text(
              text,
              style: TextStyle(
                  color: Color(!isCancelButton ? darkGrey : alertTextColor)),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    !isCancelButton ? Colors.transparent : Color(appYellow),
                shadowColor:
                    !isCancelButton ? Colors.transparent : Colors.black,
                side:
                    !isCancelButton ? BorderSide(color: Color(appGrey)) : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }

  void avancarPag() {}

  Widget defaultAppBarText(String text) {
    return Text(text, style: TextStyle(color: Color(darkGrey), fontSize: 15));
  }
}
