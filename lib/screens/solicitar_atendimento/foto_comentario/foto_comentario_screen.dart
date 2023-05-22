import 'dart:io';

import 'package:agrale/services/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../consts/consts.dart';

class FotoComentario extends StatefulWidget {
  FotoComentario({Key? key, this.foto, this.comentario}) : super(key: key);
  File? foto;
  String? comentario;
  @override
  State<FotoComentario> createState() => _FotoComentarioState();
}

class _FotoComentarioState extends State<FotoComentario> {

  TextEditingController fotoComentarioController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if(widget.comentario == null && widget.foto == null) {
      takePhoto();
    } else {
      setState(() {
        fotoComentarioController.text = widget.comentario!;
      });
    }
  }

  Future<void> takePhoto() async {
    setState(() {
      widget.foto = null;
    });
    var imageService = ImageService();
    var image = await imageService.getImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        widget.foto = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.foto != null ? Column(
          children: [
            Expanded(
              child: Container(
                color: Color(alertTextColor),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context, null);
                          }, icon: Icon(Icons.close     , color: Colors.white, size: 30,)),
                          IconButton(onPressed: (){
                            takePhoto();
                          }, icon: Icon(Icons.camera_alt, color: Colors.white, size: 30,))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.file(widget.foto!,
                            width: MediaQuery.of(context).size.width,
                            //height: MediaQuery.of(context).size.height / 2,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            //Expanded(
            //  child: Stack(
            //    children: [
            //      Positioned(child: Image.file(widget.foto!)),
            //      Positioned(child: IconButton(
            //        onPressed: () {
            //          Navigator.pop(context, null);
            //        },
            //        icon: Icon(Icons.close, size: 50,),
            //      ), left: 10, top: 10,),
            //      Positioned(child: IconButton(
            //        onPressed: () {
            //          takePhoto();
            //        },
            //        icon: Icon(Icons.loop, size: 50,),
            //      ), right: 10, top: 10,)
            //    ],
            //  ),
            //),
            Container(
              color: Color(expansionBg),
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: fotoComentarioController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Valor obrigatório!";
                            }
                            return null;
                          },
                          maxLines: 4,
                          minLines: 4,
                          decoration: InputDecoration(
                            hintText: "Inserir comentário",
                            border: zerarBordasInput,
                            focusedBorder: zerarBordasInput,
                            disabledBorder: zerarBordasInput,
                            enabledBorder: zerarBordasInput,
                            filled: true,
                            fillColor: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: (){
                        if (formKey.currentState!.validate()) {
                          saveAuxilio();
                        }
                      },
                      icon: Icon(Icons.send),
                    ),
                  )
                ],
              )
            )
          ],
        ) : Container(),
      ),
    );
  }

  void saveAuxilio() {
    Navigator.pop(context, {
      "comentario": fotoComentarioController.text,
      "imagem": widget.foto
    });
  }
}
