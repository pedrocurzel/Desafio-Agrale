import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../consts/consts.dart';

class FotoComentario extends StatefulWidget {
  FotoComentario({Key? key, this.foto, this.comentario}) : super(key: key);
  File? foto;
  String? comentario;
  @override
  State<FotoComentario> createState() => _FotoComentarioState();
}

class _FotoComentarioState extends State<FotoComentario> {

  late CameraController cameraController;
  TextEditingController fotoComentarioController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (widget.comentario != null) {
      fotoComentarioController.text = widget.comentario!;
    }
  }

  Future<bool> prepareCamera() async {
    try {
      var cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      await cameraController.initialize();
      return true;
    } catch(e) {
      return false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: prepareCamera(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Column(
                children: [
                  Expanded(
                    child: widget.foto == null ? CameraPreview(cameraController) : Image.file(widget.foto!),
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
                                onTap: () async {
                                  try {
                                    var image = await cameraController.takePicture();
                                    setState(() {
                                      widget.foto = File(image.path);
                                    });
                                    print("2");
                                  } catch(e) {
                                    print(e);
                                    print("3");
                                  }
                                } ,
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
              );
            } else {
              return Text("Erro ao inicializar a câmera");
            }
          }
          return CircularProgressIndicator();
        },
      )
    );
  }
}
