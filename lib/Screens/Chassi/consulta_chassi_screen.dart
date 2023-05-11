import 'package:agrale/models/produto.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../models/venda.dart';
import '../../widgets/produto_actions.dart';

class ConsultaChassiScreen extends StatefulWidget {
  const ConsultaChassiScreen({Key? key}) : super(key: key);

  @override
  State<ConsultaChassiScreen> createState() => _ConsultaChassiScreenState();
}

class _ConsultaChassiScreenState extends State<ConsultaChassiScreen> {
  TextEditingController chassiController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final chassiRegex = RegExp(
      r"^[0-9]{2}[A-Z]{2}[0-9]{2}[A-Z]{1}[0-9]{2}[A-Z]{2}[0-9]{6}$",
      caseSensitive: false);
  final motorRegex =
      RegExp(r"^[a-z]{1}[0-9]{1}[a-z]{1}[0-9]{6}$", caseSensitive: false);

  bool isSearching = false;
  Produto? produto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(lightGrey),
                  width: 1
                )
              )
            ),
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: [titleText("Consultar produto")],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          baseTextSpan("Informe um ", false),
                          baseTextSpan("número de motor ", true),
                          baseTextSpan("ou ", false),
                          baseTextSpan("Chassi ", true),
                          baseTextSpan(
                              "para prosseguir com o atendimento ", false),
                        ]),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color(lightGrey),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  enabled: !isSearching,
                                  maxLength: 20,
                                  onChanged: (value) => setState(() {}),
                                  //validator: (text) => validateInput(text),
                                  controller: chassiController,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding: EdgeInsets.only(left: 15),
                                      hintText: "Digite aqui...",
                                      hintStyle:
                                          TextStyle(color: Color(lightGrey)),
                                      enabledBorder: zerarBordasInput(),
                                      focusedBorder: zerarBordasInput(),
                                      errorBorder: zerarBordasInput(),
                                      focusedErrorBorder: zerarBordasInput(),
                                      disabledBorder: zerarBordasInput(),
                                      suffixIcon: chassiController.text != "" ? IconButton(
                                        onPressed: () {
                                          if (!isSearching) {
                                            chassiController.clear();
                                            setState(() {
                                              isSearching = false;
                                              produto = null;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Color(lightGrey),
                                        ),
                                      ) : null),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border: BorderDirectional(
                                              start: BorderSide(
                                                  color: Color(lightGrey),
                                                  width: 1))),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          if (validateText() && !isSearching) {
                                            beginSearch();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.search,
                                          color: isSearching
                                              ? Color(lightGrey)
                                              : Color(baseRed),
                                          size: 30,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          isSearching ? Padding(padding: EdgeInsets.only(top: 20), child: CircularProgressIndicator(color: Color(baseRed),),) : SizedBox(),
          produto != null ? ProdutoActions(product: produto!) : SizedBox(),
        ],
      ),
    );
  }

  Future<Produto?> searchProduct() async {
    produto = await Future.delayed(Duration(seconds: 5), () {
      //return null;
      return Produto(
          name: "name",
          engineNumber: "engineNumber",
          frameNumber: "frameNumber",
          secondaryFrameNumber: "secondaryFrameNumber",
          builderNfDate: DateTime.now(),
          venda: Venda(
              city: "city",
              ownerName: "ownerName",
              sellNfDate: DateTime.now(),
              uf: "uf"));
    });
    setState(() {
      isSearching = false;
    });

    if (produto == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Produto não encontrado"),
            );
          });
    }
  }

  void beginSearch() async {
    print("search begin");
    setState(() {
      isSearching = true;
    });
    await searchProduct();
  }

  bool validateText() {
    return chassiRegex.hasMatch(chassiController.text) ||
        motorRegex.hasMatch(chassiController.text);
  }

  InputBorder errorBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1));
  }

  OutlineInputBorder zerarBordasInput() {
    return OutlineInputBorder(
        borderSide: BorderSide(
      width: 0,
      color: Colors.transparent,
    ));
  }
}
