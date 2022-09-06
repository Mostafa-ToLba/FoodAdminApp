
import 'package:admin/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:admin/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:admin/models/addToCartModel/addToCartModel.dart';
import 'package:admin/models/getOrdersModel/getOrdersModel.dart';
import 'package:admin/modules/OrderDetail/OrderDetail.dart';
import 'package:admin/modules/shared/componenet/component.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,) {
        return BlocConsumer<FoodCubitAdmin,FoodCubitStates>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              body:StreamBuilder <QuerySnapshot>(
                stream: FoodCubitAdmin.get(context).LoadOrders(),
                builder: (context, snapshot)
                {
                  if(!snapshot.hasData||snapshot.data!.size==0)
                    return Center(child: Text('لا يوجد طلبات حتي الان',style: TextStyle(fontSize: 16.sp),));
                  else
                  {
                    List<getOrders>Orders =[];
                    List<String>Ids =[];
                    for(var doc in snapshot.data!.docs)
                    {
                      Orders.add(getOrders(name:doc['name'],location:doc['location'],phone:doc['phone'],total:doc['total'],time:doc['time'],color:doc['color'],orderIsOk:doc['orderIsOk'],confirmOrder:doc['confirmOrder'],sendOrder:doc['sendOrder']));
                      Ids.add(doc.id);
                    }
                    return ListView.separated(
                        itemBuilder: (context,index)=>BuiltOrderItem(Orders[index],context,Ids[index],),
                        separatorBuilder: (context,index)=>SizedBox(height: .5.h,),
                        itemCount: Orders.length);
                  }
                },
              ),
            );
          },
        );
  }
}
Widget BuiltOrderItem(getOrders order,context, String id)=> InkWell(
  onTap: ()
  {
  //  FoodCubitAdmin.get(context).getOsofUser(id);
    NavigateTo(context, OrderDetail(id));
  },
  child:   Dismissible(
    key: Key(id.toString()),
    onDismissed: (direction){
      FoodCubitAdmin.get(context).DeleteOrderr(id); },
    child: Padding(
      padding:  EdgeInsets.all(.8.h),
      child: Column(
        children: [
          Container(
            child: Padding(
              padding:  EdgeInsets.only(right: 3.w,left: 3.w,bottom: 1.5.h,top: .5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 InkWell(child: Center(child: Icon(order.orderIsOk==false?IconBroken.Shield_Fail:IconBroken.Shield_Done,
                     size: 25.sp,color:order.orderIsOk==false? HexColor('#8f0000'):HexColor('#04ff00'))),
                   onTap:(){
                   if(order.orderIsOk==true)
                      false;
                   if(order.orderIsOk==false)
                   {
                     FoodCubitAdmin.get(context).ShowDialogForSendNotificationMistakeOrder(context,id: id);
                   }
                   } ,
                 ),
                  Row(
                    children: [
                      Text('الاسم : ',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp),),
                      Spacer(),
                      Text('${order.name}',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp)),
                    ],
                  ),
                  SizedBox(height:.6.h,),
                  Container(height: .2.h,width:double.infinity,color:order.color!?Colors.white: Colors.black,),
                  SizedBox(height:.6.h,),
                  Row(
                    children: [
                      Text('رقم الموبايل : ',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp)),
                      Spacer(),
                      Expanded(child: Text('${order.phone}',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp))),
                    ],
                  ),
                  SizedBox(height:.6.h,),
                  Container(height: .2.h,width:double.infinity,color:order.color!?Colors.white: Colors.black,),
                  SizedBox(height:.6.h,),
                  Row(
                    children: [
                      Text('العنوان :',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp)),
                      Spacer(),
                      Expanded(child: Text('${order.location}',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp),)),
                    ],
                  ),
                  SizedBox(height:.6.h,),
                  Container(height: .2.h,width:double.infinity,color:order.color!?Colors.white: Colors.black,),
                  SizedBox(height:.6.h,),
                  Row(
                    children: [
                      Text('الاجمالي :',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp)),
                      Spacer(),
                      Text('${order.total!.round()} ج',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp)),
                    ],
                  ),
                  SizedBox(height:.6.h,),
                  Container(height: .2.h,width:double.infinity,color:order.color!?Colors.white: Colors.black,),
                  SizedBox(height:.6.h,),
                  Row(
                    children: [
                      Text('الوقت :',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp)),
                      Spacer(),
                      Text('${order.time}',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp)),
                    ],
                  ),
                  Container(height: .2.h,width:double.infinity,color:order.color!?Colors.white: Colors.black,),
                  SizedBox(height:.6.h,),
                  Row(
                    children: [
                      Text('قبول الطلب : ',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp),),
                      Spacer(),
                      Icon(order.confirmOrder==false?Icons.close:Icons.done,color: order.color!?Colors.white: Colors.black,),
                    ],
                  ),
                  Container(height: .2.h,width:double.infinity,color:order.color!?Colors.white: Colors.black,),
                  SizedBox(height:.6.h,),
                  Row(
                    children: [
                      Text('ارسال الدليفري : ',style: TextStyle(color:order.color!?Colors.white: Colors.black,fontSize: 11.sp),),
                      Spacer(),
                      Icon(order.sendOrder==false?Icons.close:Icons.done,color: order.color!?Colors.white: Colors.black,),
                    ],
                  ),
                  SizedBox(height:.6.h,),
                  Container(height:.2.h,width:double.infinity,color:order.color!?Colors.white: Colors.black,),
                  SizedBox(height: 1.2.h,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(2.sp),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: MaterialButton(onPressed: ()
                        {
                          FoodCubitAdmin.get(context).ShowDialogForSendNotification2blElTalab(context,id: id);

                        }, child: Text('اقبل الطلب',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(width: 1.w,),
                      Container(
                        padding: EdgeInsetsDirectional.all(2.sp),
                        color: Colors.black,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 2.w),
                          child: TextButton(onPressed: ()
                          {
                            FoodCubitAdmin.get(context).ShowDialogForSendNotificationEb3tEltalab(context,id: id);
                          }, child: Text('ابعت الدليفري',style: TextStyle(color: Colors.white,fontSize:13.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                        ),
                      ),
                      SizedBox(width: 1.w,),
                      Container(
                        padding: EdgeInsetsDirectional.all(2.sp),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: MaterialButton(onPressed: ()
                        {
                          FoodCubitAdmin.get(context).changeColorOfOrder(id);
                        }, child: Text('تم',style: TextStyle(color: Colors.white,fontSize:  13.sp,),)),
                      ),
                      Spacer(),
                      if(order.color==false)
                      Icon(Icons.done,size: 20.sp,),
                    ],
                  )
                ],
              ),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: order.color!?Colors.red:Colors.white,
              border: Border.all(color: HexColor('#8d2422')),),

          ),
        ],
      ),
    ),
  ),
);
Widget BuiltItem(AddToCart listOfOrder)=>Container(
  child: Padding(
    padding: const EdgeInsets.all(15),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${listOfOrder.num}x',style: TextStyle(fontSize: 18,color: HexColor('#184a2c')),),
              SizedBox(width: 15,),
              Text('${listOfOrder.name}',style: TextStyle(fontSize: 18,color: HexColor('#184a2c')),),
              Spacer(),
              Text('${listOfOrder.price}',style: TextStyle(fontSize: 18,color: HexColor('#184a2c')),),
              SizedBox(width: 10,),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(onPressed:()
                {

                }, icon: Icon(Icons.close) ,),
              ),
            ],
          ),
          SizedBox(height: 2,),
          Text('description',),
        ],
      ),
    ),
  ),
  height: 130,
  width: double.infinity,
  color: HexColor('EBFDF2'),
);
