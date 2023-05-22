import 'dart:io';

import 'package:agrale/models/selecao_atendimento_classes.dart';
import 'package:agrale/models/produto.dart';
import 'package:agrale/screens/solicitar_atendimento/foto_comentario/foto_comentario_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:agrale/services/image_picker.dart';
import 'package:image_picker/image_picker.dart';
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

  ImageService imageService = ImageService();
  File? fotoPlaqueta;
  File? fotoHodometro;
  bool semAcessoImagemPlaqueta = false;
  bool semAcessoImagemHodometro = false;

  List<Map<String, dynamic>> imagensAuxiliaresList = [];

  var hodometroFormKey = GlobalKey<FormState>();
  var hodometroInputController = TextEditingController();

  var atendimentoFormKey = GlobalKey<FormState>();
  var atendimentoTituloInputController = TextEditingController();
  var atendimentoDescricaoInputController = TextEditingController();
  var fotoComentarioController = TextEditingController();

  List<CategoriaAtendimento> categoriaAtendimentoList = [
    CategoriaAtendimento(
        "Atendimento Técnico", "images/atendimento_tecnico.png",
        isSelected: true),
    CategoriaAtendimento(
        "Atendimento Técnico 1", "images/atendimento_tecnico.png"),
    CategoriaAtendimento(
        "Atendimento Técnico 2", "images/atendimento_tecnico.png")
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

  late CameraController cameraController;

  Map<String, dynamic> selecao = {'categoriaSelecionada': null};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 8, vsync: this, initialIndex: 0);
    availableCameras()
    .then((cameras) {
      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      cameraController.initialize();
    });
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
            fotoPlaquetaWidget(),
            fotoHodometroWidget(),
            situacaoWidget(),
            imagensAuxiliares(),
            Text("8")
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(right: 20, left: 20),
          color: Colors.white,
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

  Widget imagensAuxiliares() {
    return Container(
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
                      baseTextSpan("Existem  ", false, alertTextColor,
                          fontSize: defaultSpanFontSize),
                      baseTextSpan("imagens ", true, alertTextColor,
                          fontSize: defaultSpanFontSize),
                      baseTextSpan("que podem ", false, alertTextColor,
                          fontSize: defaultSpanFontSize),
                      baseTextSpan("ajudar na resolução ", true, alertTextColor,
                          fontSize: defaultSpanFontSize),
                      baseTextSpan("do atendimento? Adicione-as abaixo ", false,
                          alertTextColor,
                          fontSize: defaultSpanFontSize),
                    ]),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              color: Color(darkGrey),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Adicionar Imagem",
                              style: TextStyle(color: Color(darkGrey)),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(double.infinity, 50),
                            backgroundColor: Color(adicionarImagensButtonColor),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () async {
                          var res = await Navigator.push(context, MaterialPageRoute(builder: (context) => FotoComentario()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Tamanho máximo do arquivo: 25MB"),
                    for (var imagem in imagensAuxiliaresList)
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(15),
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.black))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.file(
                                  imagem["imagem"],
                                  height: 150,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Comentário"),
                                      Text(
                                          imagem["comentario"] + "adsasdasdasd")
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [Text("zzz")],
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  dynamic cameraComComentario() {
    showGeneralDialog(
        context: context,
        barrierColor: Colors.black,
        pageBuilder: (_,__,___) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                Expanded(
                  child: CameraPreview(cameraController),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 0,
                                child: TextField(
                                  onChanged: (value) {print('aaaa');setState(() {});},
                                  controller: fotoComentarioController,
                                  decoration: InputDecoration(
                                    hintText: "Comentário",
                                    border: zerarBordasInput,
                                    enabledBorder: zerarBordasInput,
                                    focusedBorder: zerarBordasInput,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: fotoComentarioController.text.isNotEmpty ? () async {
                                print("1");
                                try {
                                  var a = await cameraController.takePicture();
                                  print("2");
                                } catch(e) {
                                  print(e);
                                  print("3");
                                }
                              } : null,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.send, color: Color(fotoComentarioController.text.isNotEmpty ? baseRed : lightGrey),),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }
    );
  }

  Widget situacaoWidget() {
    return Container(
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
                      baseTextSpan("Descreva a ", false, alertTextColor,
                          fontSize: defaultSpanFontSize),
                      baseTextSpan("situação ", true, alertTextColor,
                          fontSize: defaultSpanFontSize),
                      baseTextSpan("que necessita ", false, alertTextColor,
                          fontSize: defaultSpanFontSize),
                      baseTextSpan("de atendimento", true, alertTextColor,
                          fontSize: defaultSpanFontSize),
                    ]),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                    Form(
                      key: atendimentoFormKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              defaultInput(atendimentoTituloInputController,
                                  "Título", TextInputType.text, 100)
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              defaultInput(
                                  atendimentoDescricaoInputController,
                                  "Descrição",
                                  TextInputType.text,
                                  minLines: 15,
                                  maxLines: 30,
                                  1500)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget fotoHodometroWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(children: [
                    baseTextSpan("Adicione a foto do ", false, alertTextColor,
                        fontSize: defaultSpanFontSize),
                    baseTextSpan("Hodômetro ", true, alertTextColor,
                        fontSize: defaultSpanFontSize),
                  ]),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Form(
                key: hodometroFormKey,
                child: defaultInput(
                    hodometroInputController,
                    "Informe a quilometragem ou horas",
                    TextInputType.number,
                    50),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  fotoHodometro == null
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate,
                                          color: Color(darkGrey),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Adicionar Imagem",
                                          style:
                                              TextStyle(color: Color(darkGrey)),
                                        ),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(double.infinity, 50),
                                        backgroundColor:
                                            Color(adicionarImagensButtonColor),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    onPressed: () async {
                                      fotoHodometro = await getImage();
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tamanho máximo: 25MB",
                                  style: TextStyle(color: Color(darkGrey)),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  semAcessoImagemHodometro =
                                      !semAcessoImagemHodometro;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: semAcessoImagemHodometro,
                                    onChanged: (value) {
                                      setState(() {
                                        semAcessoImagemHodometro =
                                            !semAcessoImagemHodometro;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    activeColor: Color(baseRed),
                                  ),
                                  Text("Não tenho acesso à imagem")
                                ],
                              ),
                            )
                          ],
                        )
                      : SizedBox(),
                  fotoHodometro != null
                      ? Column(
                          children: [
                            Image.file(fotoHodometro!,
                                height:
                                    MediaQuery.of(context).size.height / 2.2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        fotoHodometro = null;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(appGrey),
                                    ))
                              ],
                            )
                          ],
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget defaultInput(
    TextEditingController controller,
    String hintText,
    TextInputType keyboardType,
    int maxLength, {
    int minLines = 1,
    int maxLines = 1,
  }) {
    return Expanded(
      child: TextFormField(
        maxLength: maxLength,
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Color(appGrey),
        //maxLines: maxLines,
        decoration: InputDecoration(
            counterText: "",
            suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: Icon(
                Icons.close,
                color: Color(appGrey),
              ),
            ),
            hintText: hintText,
            fillColor: Color(expansionBg),
            focusColor: Color(expansionBg),
            filled: true,
            focusedBorder: lightGreyInputBorder,
            enabledBorder: lightGreyInputBorder),
      ),
    );
  }

  Widget fotoPlaquetaWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(children: [
                    baseTextSpan("Adicione a foto ", false, alertTextColor,
                        fontSize: defaultSpanFontSize),
                    baseTextSpan("da plaqueta ", true, alertTextColor,
                        fontSize: defaultSpanFontSize),
                    baseTextSpan("com o ", false, alertTextColor,
                        fontSize: defaultSpanFontSize),
                    baseTextSpan("número do motor ", true, alertTextColor,
                        fontSize: defaultSpanFontSize),
                    baseTextSpan("ou ", false, alertTextColor,
                        fontSize: defaultSpanFontSize),
                    baseTextSpan("Chassi", true, alertTextColor,
                        fontSize: defaultSpanFontSize),
                  ]),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  fotoPlaqueta == null
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate,
                                          color: Color(darkGrey),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Adicionar Imagem",
                                          style:
                                              TextStyle(color: Color(darkGrey)),
                                        ),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(double.infinity, 50),
                                        backgroundColor:
                                            Color(adicionarImagensButtonColor),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    onPressed: () async {
                                      fotoPlaqueta = await getImage();
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tamanho máximo: 25MB",
                                  style: TextStyle(color: Color(darkGrey)),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  semAcessoImagemPlaqueta =
                                      !semAcessoImagemPlaqueta;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: semAcessoImagemPlaqueta,
                                    onChanged: (value) {
                                      setState(() {
                                        semAcessoImagemPlaqueta =
                                            !semAcessoImagemPlaqueta;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    activeColor: Color(baseRed),
                                  ),
                                  Text("Não tenho acesso à imagem")
                                ],
                              ),
                            )
                          ],
                        )
                      : SizedBox(),
                  fotoPlaqueta != null
                      ? Column(
                          children: [
                            Image.file(fotoPlaqueta!,
                                height:
                                    MediaQuery.of(context).size.height / 2.2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        fotoPlaqueta = null;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(appGrey),
                                    ))
                              ],
                            )
                          ],
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<File?> getImage() async {
    ImageSource? source = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 195,
              width: MediaQuery.of(context).size.width - 200,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context, null);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Escolha uma opção abaixo",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  button(
                      "Camera", Icons.add_a_photo, adicionarImagensButtonColor,
                      () {
                    Navigator.pop(context, ImageSource.camera);
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  button("Galeria", Icons.add_photo_alternate_rounded,
                      adicionarImagensButtonColor, () {
                    Navigator.pop(context, ImageSource.gallery);
                  })
                ],
              ),
            ),
          );
        });

    if (source != null) {
      return await imageService.getImage(source: source);
      //imageVariable = await imageService.getImage(source: source);
      //setState(() {});
    }
    return null;
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
                          fontSize: defaultSpanFontSize),
                      baseTextSpan(
                          "Grupo(s) de Ocorrência", true, alertTextColor,
                          fontSize: defaultSpanFontSize),
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
                    buildSelectionItem(ocorrencia, grupoOcorrenciaList, false,
                        multipleSelection: true)
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
                          fontSize: defaultSpanFontSize),
                      baseTextSpan("Linha de Produto?", true, alertTextColor,
                          fontSize: defaultSpanFontSize),
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

  Widget buildSelectionItem(
      ItemSelecionavel item, List<dynamic> itens, bool circularIconContainer,
      {bool multipleSelection = false}) {
    Color containerColor = !item.isSelected ? Colors.white : Color(selectedRed);
    Color textAndIconColor = !item.isSelected ? Colors.black : Colors.white;

    return InkWell(
      onTap: () {
        setState(() {
          if (!multipleSelection) {
            itens.forEach((element) {
              element.isSelected = false;
            });
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
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(circularIconContainer ? 100 : 20)),
              child: Image.asset(
                item.imageSrc,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              item.nome,
              style: TextStyle(fontSize: 22, color: textAndIconColor),
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
                          fontSize: defaultSpanFontSize),
                      baseTextSpan(
                          "Categoria de Atendimento", true, alertTextColor,
                          fontSize: defaultSpanFontSize),
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
                    buildSelectionItem(
                        categoria, categoriaAtendimentoList, true)
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
        //if (tabController.index == 2) {
        //  if (grupoOcorrenciaList
        //      .any((element) => element.isSelected == true)) {
        //    passarPag();
        //  } else {
        //    showDialog(
        //        context: context,
        //        builder: (context) {
        //          return selecaoObrigatoria();
        //        });
        //  }
        //} else if (tabController.index == 3) {
        //  if ((fotoPlaqueta != null) || (semAcessoImagemPlaqueta)) {
        //    passarPag();
        //  } else {
        //    showAlertDialog("Necessário adicionar uma foto ou marcar a opção");
        //  }
        //} else if (tabController.index == 4) {
        //  if ((fotoHodometro != null || semAcessoImagemHodometro) &&
        //      hodometroInputController.text != "") {
        //    passarPag();
        //  } else {
        //    showAlertDialog(
        //        "Necessário o campo preenchido e adicionar uma foto ou marcar a opção");
        //  }
        //} else if (tabController.index == 5) {
        //  if (atendimentoTituloInputController.text.isNotEmpty &&
        //      atendimentoDescricaoInputController.text.isNotEmpty) {
        //    passarPag();
        //  } else {
        //    showAlertDialog("Necessário os dois campos preenchidos");
        //  }
        //} else {
          passarPag();
        //}
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

  void showAlertDialog(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        });
  }

  Widget selecaoObrigatoria() {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        height: 240,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Seleção obrigatória",
                  style: TextStyle(
                      color: Color(alertTextColor),
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(children: [
                      baseTextSpan("Ao menos um ", false, alertTextColor),
                      baseTextSpan(
                          "Grupo de Ocorrência ", true, alertTextColor),
                      baseTextSpan(
                          "deve ser selecionado.", false, alertTextColor),
                    ]),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.infinity, 50),
                        backgroundColor: Color(0xFFE10000),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Fechar"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(String label, IconData icon, int bgColor, Function callback) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(double.infinity, 50),
                backgroundColor: Color(bgColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () {
              callback();
            },
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Color(darkGrey),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: TextStyle(color: Color(darkGrey)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void passarPag() {
    setState(() {
      tabController.animateTo(tabController.index + 1);
    });
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
              height: 325,
              width: MediaQuery.of(context).size.width,
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
