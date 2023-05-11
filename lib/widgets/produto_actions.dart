import 'package:flutter/material.dart';

import '../consts/consts.dart';
import '../models/produto.dart';

class ProdutoActions extends StatelessWidget {
  const ProdutoActions({super.key, required this.product});
  final Produto product;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Expanded(
          child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 18),
                child: titleText("Ações para o produto"),
              )
            ],
          ),
        ),
        )
      ),
    );
  }
}
