import 'package:admin/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:admin/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:admin/models/addToCartModel/addToCartModel.dart';
import 'package:admin/models/getOrdersModel/getOrdersModel.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class OrderDetail extends StatelessWidget {
  String id;

  OrderDetail(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Builder(
      builder: (BuildContext context) {
        //  FoodCubit.get(context).getOrdersToAdmin();
        return BlocConsumer<FoodCubitAdmin, FoodCubitStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return Scaffold(
                appBar: AppBar(
                  leadingWidth: 15.w,
                  toolbarHeight: 7.h,
                  leading:IconButton(iconSize: 16.sp,icon: Icon(IconBroken.Arrow___Left_2,size: 16.sp,), onPressed: ()
                  {
                    Navigator.pop(context);
                  },) ,
                ),
                body: StreamBuilder<QuerySnapshot>(
                  stream: FoodCubitAdmin.get(context).OrderDetails(id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: Text('there is no orders'));
                    else {
                      List<getOrders> Orders = [];
                      for (var doc in snapshot.data!.docs) {
                        Orders.add(getOrders(
                          name: doc['name'],
                          num: doc['num'],
                          price: doc['price'],
                          uId: doc['uId'],
                          username: doc['username'],
                          text: doc['text'],
                          phone: doc['phone'],
                          time: doc['time'],
                          location: doc['location'],
                        ));
                      }
                      return ListView.separated(
                          itemBuilder: (context, index) =>
                              BuiltOrderItem(Orders[index], context),
                          separatorBuilder: (context, index) => SizedBox(
                                height: .5.h,
                              ),
                          itemCount: Orders.length);
                    }
                  },
                ));
          },
        );
      },
    );
  }
}

Widget BuiltOrderItem(getOrders order, context) => Padding(
      padding: EdgeInsets.all(1.5.h),
      child: Column(
        children: [
          Container(
            child: Padding(
              padding:  EdgeInsets.all(1.5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${order.num} x',
                            style: TextStyle(
                                fontSize: 14.sp, color:Colors.black),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                            child: Text(
                              '${order.name}',
                              style: TextStyle(
                                  fontSize: 14.sp,color:Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Container(height: .1.h,color: Colors.grey[400],),
                      SizedBox(
                        height: .5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'الاضافات :',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Spacer(),
                          Expanded(
                              child: Text(order.text!=''?'${order.text}':'لا توجد اضافات',style: TextStyle(fontSize: 14.sp),)),
                        ],
                      ),
                      Container(height: .1.h,color: Colors.grey[400],),
                    ],
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        ' السعر : ',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Spacer(),
                      Text(
                        '${order.price}ج ',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  Container(height: .1.h,color: Colors.grey[400],),
                ],
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor('#8d2422')),),
            width: double.infinity,
          ),
        ],
      ),
    );
Widget BuiltItem(AddToCart listOfOrder) => Container(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${listOfOrder.num}x',
                    style: TextStyle(fontSize: 18, color: HexColor('#184a2c')),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${listOfOrder.name}',
                    style: TextStyle(fontSize: 18, color: HexColor('#184a2c')),
                  ),
                  Spacer(),
                  Text(
                    '${listOfOrder.price}',
                    style: TextStyle(fontSize: 18, color: HexColor('#184a2c')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'description',
              ),
            ],
          ),
        ),
      ),
      height: 130,
      width: double.infinity,
      color: HexColor('EBFDF2'),
    );
