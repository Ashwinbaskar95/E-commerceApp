class productData {
  int? id;
  String? name;
  String? model;
  String? price;
  String? imageUrl;
  String? category;
  String? manufacturedate;
  String? manufactureaddress;

  productData(
      {this.id,
      this.name,
      this.model,
      this.price,
      this.imageUrl,
      this.category,
      this.manufactureaddress,
      this.manufacturedate});

  productData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    category = json['category'];
    manufactureaddress = json['manufacture address'];
    manufacturedate = json['manufacture date'];
  }
}
