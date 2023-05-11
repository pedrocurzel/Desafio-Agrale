class Venda {
  const Venda({
    required this.ownerName,
    required this.city,
    required this.uf,
    required this.sellNfDate
  });

  final String ownerName;
  final String city;
  final String uf;
  final DateTime sellNfDate;
}
