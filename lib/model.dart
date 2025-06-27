class CategoryModel{
  String name;
   String image;

  CategoryModel({required  this.name,required  this.image});
}



class ProductModel {
  final String name;
  final String image;
  final String price;
  final String rate;
  final String rateCount;
   int quantity;

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.rate,
    required this.rateCount,
    this.quantity=0,
  });
}