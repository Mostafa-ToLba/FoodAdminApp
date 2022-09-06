class getOrders{
  String? name;
  int? price;
  int? num ;
  String? text;
  var total;
  bool? color;
  bool? orderIsOk;
  bool? confirmOrder;
  bool? sendOrder;

  String? username='';
  String? phone='';
  String? location='';
  String? uId='';
  String? time='';


  getOrders({this.name,this.price,this.num,this.text,this.username,this.phone,this.location,this.uId,this.time, this.total, this.color,this.orderIsOk,this.confirmOrder,this.sendOrder});

  getOrders.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    price=json['price'];
    num=json['num'];
    text=json['text'];
    color=json['color'];
    orderIsOk=json['orderIsOk'];
    confirmOrder=json['confirmOrder'];
    sendOrder=json['sendOrder'];

    username=json['username'];
    phone=json['phone'];
    location=json['location'];
    uId=json['uId'];
    time=json['time'];
    total=json['total'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'price':price,
      'num':num,
      'text':text,
      'color':color,
      'orderIsOk':orderIsOk,
      'confirmOrder':confirmOrder,
      'sendOrder':sendOrder,

      'username':username,
      'phone':phone,
      'location':location,
      'uId':uId,
      'time':time,
      'total':total,
    };
  }

}
