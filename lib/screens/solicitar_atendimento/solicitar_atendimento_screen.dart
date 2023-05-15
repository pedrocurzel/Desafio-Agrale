import 'package:agrale/models/selecao_atendimento_classes.dart';
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

  List<CategoriaAtendimento> categoriaAtendimentoList = [
    CategoriaAtendimento("Atendimento Técnico", "images/atendimento_tecnico.png", isSelected: true),
    CategoriaAtendimento("Atendimento Técnico 1", "images/atendimento_tecnico.png"),
    CategoriaAtendimento("Atendimento Técnico 2", "images/atendimento_tecnico.png")
  ];

  List<LinhaProduto> linhaProdutoList = [
    LinhaProduto("Caminhão", "images/caminhao.png", isSelected: true),
    LinhaProduto("Chassi", "images/chassi.png"),
    LinhaProduto("Marruá", "images/marrua.png"),
    LinhaProduto("Trator", "images/trator.png")
  ];

  List<GrupoOcorrencia> grupoOcorrenciaList = [
    GrupoOcorrencia("Arrefecimento", "images/arrefecimento.png"),
    GrupoOcorrencia("Cabine e Carroceria", "images/cabine_carroceria.png"),
    GrupoOcorrencia("Eixo Dianteiro", "images/eixo_dianteiro.png"),
    GrupoOcorrencia("Eixo Traseiro", "images/eixo_traseiro.png"),
    GrupoOcorrencia("Freios", "images/freios.png"),
    GrupoOcorrencia("Motor", "images/motor.png"),
    GrupoOcorrencia("Pós Tratamento", "images/pos_tratamento.png"),
    GrupoOcorrencia("Sistema Elétrico", "images/sistema_eletrico.png"),
    GrupoOcorrencia("Sistema Hidráulico", "images/sistema_hidraulico.png"),
    GrupoOcorrencia("Sistema Pneumático", "images/sistema_pneumatico.png"),
    GrupoOcorrencia("Suporte e Travessas", "images/suporte_e_travessas.png"),
    GrupoOcorrencia("Suspensão", "images/suspensao.png"),
    GrupoOcorrencia("Transmissão", "images/transmissao.png"),
  ];

  Map<String, dynamic> selecao = {'categoriaSelecionada': null};

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
            categoriaAtendimento(),
            linhaDeProduto(),
            gruposDeOcorrencia(),
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
              )),
              tabController.index < 7 ? proximoButton() : concluirButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget gruposDeOcorrencia() {
    return Container(
      //padding: EdgeInsets.all(25),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(children: [
                      baseTextSpan("Selecione o(s) ", false, alertTextColor,
                          fontSize: 35),
                      baseTextSpan(
                          "Grupo(s) de Ocorrência", true, alertTextColor,
                          fontSize: 35),
                    ]),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var ocorrencia in grupoOcorrenciaList)
                    buildSelectionItem(ocorrencia, grupoOcorrenciaList, false, multipleSelection: true)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget linhaDeProduto() {
    return Container(
      //padding: EdgeInsets.all(25),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(children: [
                      baseTextSpan("Qual a ", false, alertTextColor,
                          fontSize: 35),
                      baseTextSpan(
                          "Linha de Produto?", true, alertTextColor,
                          fontSize: 35),
                    ]),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var linha in linhaProdutoList)
                    buildSelectionItem(linha, linhaProdutoList, false)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSelectionItem(ItemSelecionavel item, List<dynamic> itens, bool circularIconContainer, {bool multipleSelection = false}) {
    Color containerColor = !item.isSelected ? Colors.white : Color(selectedRed);
    Color textAndIconColor = !item.isSelected ? Colors.black : Colors.white;

    return InkWell(
      onTap: (){
        setState(() {
          if (!multipleSelection) {
            itens.forEach((element) {element.isSelected = false;});
            item.isSelected = true;
          } else {
            item.isSelected = !item.isSelected;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
        color: containerColor,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(circularIconContainer ? 25 : 10),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(circularIconContainer ? 100 : 20)
              ),
              child: Image.asset(
                item.imageSrc,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              item.nome,
              style: TextStyle(fontSize: 25, color: textAndIconColor),
            )
          ],
        ),
      ),
    );
  }

  Widget categoriaAtendimento() {
    return Container(
      //padding: EdgeInsets.all(25),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(children: [
                      baseTextSpan("Selecione a ", false, alertTextColor,
                          fontSize: 35),
                      baseTextSpan(
                          "Categoria de Atendimento", true, alertTextColor,
                          fontSize: 35),
                    ]),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var categoria in categoriaAtendimentoList)
                    buildSelectionItem(categoria, categoriaAtendimentoList, true)
                ],
              ),
            ),
          )
        ],
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
                  buildAlertButtons("Continuar solicitação", () {
                    Navigator.pop(context);
                  })
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

  Widget defaultAppBarText(String text) {
    return Text(text, style: TextStyle(color: Color(darkGrey), fontSize: 15));
  }
}
