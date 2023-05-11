import 'package:flutter/material.dart';

import '../models/produto.dart';

class ProdutoActions extends StatelessWidget {
  const ProdutoActions({super.key, required this.product});
  final Produto product;

  @override
  Widget build(BuildContext context) {
    return Text(product.name);
  }
}
