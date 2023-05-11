import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class ConsultaChassiScreen extends StatefulWidget {
  const ConsultaChassiScreen({Key? key}) : super(key: key);

  @override
  State<ConsultaChassiScreen> createState() => _ConsultaChassiScreenState();
}

class _ConsultaChassiScreenState extends State<ConsultaChassiScreen> {

  TextEditingController chassiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    titleText("Consultar produto")
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              baseTextSpan("Informe um ", false),
                              baseTextSpan("número de motor ", true),
                              baseTextSpan("ou ", false),
                              baseTextSpan("Chassi ", true),
                              baseTextSpan("para prosseguir com o atendimento ", false),
                            ]
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Form(
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
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  controller: chassiController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15),
                                      hintText: "Digite aqui...",
                                      hintStyle: TextStyle(color: Color(lightGrey)),
                                      enabledBorder: zerarBordasInput(),
                                      focusedBorder: zerarBordasInput(),
                                      suffixIcon: chassiController.text != "" ? IconButton(
                                        onPressed: (){
                                          setState(() {
                                            chassiController.clear();
                                          });
                                        },
                                        icon: Icon(Icons.close, color: Colors.grey,),
                                      ) : null
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border: BorderDirectional(
                                              start: BorderSide(
                                                  color: Color(lightGrey),
                                                  width: 1
                                              )
                                          )
                                      ),
                                    ),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Color(baseRed), size: 30,))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  OutlineInputBorder zerarBordasInput() {
    return OutlineInputBorder(
        borderSide: BorderSide(
            width: 0,
            color: Colors.transparent,

        )
    );
  }


}
