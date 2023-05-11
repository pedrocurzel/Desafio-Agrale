import 'package:agrale/models/venda.dart';

class Produto {
  const Produto(
      {required this.name,
      required this.engineNumber,
      required this.frameNumber,
      required this.secondaryFrameNumber,
      required this.builderNfDate,
      required this.venda});

  final String name;
  final String engineNumber;
  final String frameNumber;
  final String secondaryFrameNumber;
  final DateTime builderNfDate;
  final Venda venda;
}
