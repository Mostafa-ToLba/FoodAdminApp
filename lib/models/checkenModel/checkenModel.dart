
class checkenModel{

  String? image;
  String? name;
  int? price;
  String? description;
  bool? availability;

  checkenModel({ this.description,this.name, this.image,this.price,this.availability});

  checkenModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    image=json['image'];
    price=json['price'];
    description=json['description'];
    availability=json['availability'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'image':image,
      'price':price,
      'description':description,
      'availability':availability,
    };
  }

}
