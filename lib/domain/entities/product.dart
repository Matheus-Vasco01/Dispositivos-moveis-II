//arquivo para definier qual a entidade principal do dominio

class Product {
  final int id;
  final String title;
  final double price;
  final String image;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });
}
