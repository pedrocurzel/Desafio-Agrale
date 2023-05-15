import 'package:flutter/cupertino.dart';

class ItemSelecionavel {
  ItemSelecionavel(this.nome, this.imageSrc, {this.isSelected = false});

  String nome;
  String imageSrc;
  bool isSelected;
}

class CategoriaAtendimento extends ItemSelecionavel {
  CategoriaAtendimento(super.nome, super.imageSrc, {super.isSelected = false});
}

class LinhaProduto extends ItemSelecionavel {
  LinhaProduto(super.nome, super.imageSrc, {super.isSelected = false});
}

class GrupoOcorrencia extends ItemSelecionavel {
  GrupoOcorrencia(super.nome, super.imageSrc, {super.isSelected = false});
}