
 import 'package:admin/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:admin/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:admin/models/AdminMenuEditingModel/homeTwoModel.dart';
import 'package:admin/models/checkenModel/checkenModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';


class EditMenu extends StatelessWidget {
    EditMenu({Key? key}) : super(key: key);
   var ListController = ScrollController();
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<FoodCubitAdmin,FoodCubitStates>(
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object? state) {
         return Scaffold(
           body:SingleChildScrollView(
             physics: BouncingScrollPhysics(),
             child: Padding(
               padding:  EdgeInsets.only(bottom: 1.2.h,right: 1.3.h,left: 1.3.h,top: .1.h),
               child: Column(
                 children: [
                   Container(
                     height: 30.h,
                     width: double.infinity,
                     child:Container(
                       height: 35.h,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10) ),
                           image: DecorationImage(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/easy-eat-5dd80.appspot.com/o/descriptionImage.png?alt=media&token=68acd7e8-2a2d-4338-96f7-1e9a0194268b'),
                             fit: BoxFit.fill,
                           )
                       ),
                     ) ,
                   ),
                   SizedBox(
                     height: 2.h,
                   ),
                   Row(
                     children: [
                       SizedBox(
                         width: 10.sp,
                       ),
                       Text(
                         'Categories',
                         style: TextStyle(
                             color: Colors.black, fontSize: 15.sp),
                       ),
                     ],
                   ),
                   SizedBox(
                     height: 10.sp,
                   ),
                   Container(
                     height: 12.h,
                     child: StreamBuilder <QuerySnapshot>(
                       stream: FoodCubitAdmin.get(context).getListHori(),
                       builder: (context, snapshot)
                       {
                         if(!snapshot.hasData||snapshot.data!.size==0)
                           return Center(child: Text('',style: TextStyle(fontSize: 20),));
                         else
                         {
                           List<getListHoriModel>ListHoriModel =[];
                           List<String>Ids =[];
                           for(var doc in snapshot.data!.docs)
                           {
                             ListHoriModel.add(getListHoriModel(name:doc['name'],image:doc['image']));
                             Ids.add(doc.id);
                           }
                           return ListView.separated(
                               controller: ListController,
                               scrollDirection: Axis.horizontal,
                               shrinkWrap: true,
                               itemBuilder: (context, index) =>BuildTextButton(context,index,ListHoriModel[index],Ids[index]),
                               separatorBuilder: (context, index) =>
                                   SizedBox(
                                     width: .5.w,
                                   ),
                               itemCount: ListHoriModel.length);
                         }
                       },
                     ),
                   ),
                   StreamBuilder <QuerySnapshot>(
                     stream: FoodCubitAdmin.get(context).getListHoriz(FoodCubitAdmin.get(context).Number),
                     builder: (context, snapshot)
                     {
                       if(!snapshot.hasData)
                         return Center(child: Text(''));
                       else
                       {
                         List<checkenModel>Orders =[];
                         List<String>IdsOfItem =[];
                         for(var doc in snapshot.data!.docs)
                         {
                           Orders.add(checkenModel(name:doc['name'],description: doc['description']
                               ,price:doc['price'],image:doc['image'],availability:doc['availability'] ));
                           IdsOfItem.add(doc.id);
                         }
                         return ConditionalBuilder(
                           condition: Orders.length > 0,
                           builder: (BuildContext context) => Container(
                             child: GridView.count(
                               crossAxisCount: 2,
                               shrinkWrap: true,
                               childAspectRatio: 1 / 1.3,
                               crossAxisSpacing: 2,
                               mainAxisSpacing: 2,
                               physics: NeverScrollableScrollPhysics(),
                               children: List.generate(Orders.length, (index) => BuilView(Orders[index],context,IdsOfItem[index])),
                             ),
                           ),
                           fallback: (BuildContext context) =>
                               Center(child: CircularProgressIndicator()),
                         );
                       }
                     },
                   ),
                 ],
               ),
             ),
           ),
         );
       },
     );
   }
 }
 BuildTextButton(context,index, getListHoriModel listHoriModel, String id)=>Padding(
   padding:  EdgeInsets.only(left: 1.h),
   child: Container(
     child: Column(
       children: [
         Container(
           padding: EdgeInsetsDirectional.only(top: .1.h,bottom: .2.h,end: .5.h,start: .5.h),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.all(
                 Radius.circular(3.h)),
             color: FoodCubitAdmin.get(context).selectedIndex != null && FoodCubitAdmin.get(context).selectedIndex == index ? HexColor('#8d2422')
             // HexColor('#EBFDF2')
                 : HexColor('#ffebed'),
           ),

           child: TextButton(
             onPressed: () {
               FoodCubitAdmin.get(context).onSelected(index);
               FoodCubitAdmin.get(context).getId(id);
             },
             child: Row(
               mainAxisAlignment:
               MainAxisAlignment.start,
               children: [
                 CircleAvatar(
                   child: Image(
                     image: NetworkImage(
                       '${listHoriModel.image}',
                     ),
                     fit: BoxFit.cover,
                     height: 4.5.h,
                     width: 4.1.h,
                   ),
                   backgroundColor:
                   Colors.white,
                   radius: 3.h,
                 ),
                 SizedBox(
                   width: 1.w,
                 ),
                 Text(
                   '${listHoriModel.name}',
                   style: TextStyle(
                     fontSize: 12.sp,
                     fontWeight:
                     FontWeight.bold,
                     color: FoodCubitAdmin.get(
                         context)
                         .selectedIndex !=
                         null &&
                         FoodCubitAdmin.get(
                             context)
                             .selectedIndex ==
                             index
                         ? Colors.white
                         : Colors.black,
                   ),
                 ),
               ],
             ),
           ),

         ),
         SizedBox(
           height: .6.h,
         ),
         if (FoodCubitAdmin.get(context).selectedIndex != null && FoodCubitAdmin.get(context).selectedIndex == index)
           LayoutBuilder(
             builder: (context,constraints)=>
                 Container(
                   height: .4.h,
                   width: 30.w,
                   color: HexColor('#8d2422'),
                 ),
           ),
       ],
     ),
   ),
 );
 Widget BuilView(checkenModel model, context, String idsOfItem) => InkWell(
   child: Container(
     color: Colors.grey[100],
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Expanded(
           child: Padding(
             padding:  EdgeInsets.only(left: .4.h,right: .4.h),
             child:Stack(
               alignment: AlignmentDirectional.topCenter,
               children: [
                 Container(
                   width: double.infinity,
                   height: 20.h,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       image: DecorationImage(
                           fit: BoxFit.cover,
                           image: NetworkImage('${model.image}'
                           ))),
                 ),
                 if(model.availability==false)
                   Container(
                     color: Colors.black54,
                     //     height: 5.h,
                     width: double.infinity,
                     child: Padding(
                       padding:  EdgeInsets.all(.5.h),
                       child: Text('غير متاح الان',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13.sp),),
                     ),
                   ),
               ],
             ),
           ),
         ),
         SizedBox(
           height: .2.h,
         ),
         Container(
           child: Text(
             '${model.name}',
             style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
             maxLines: 2,
           ),
         ),
         Container(
           width: double.infinity,
           child: Padding(
             padding:  EdgeInsets.only(left: .5.h,right: .5.h),
             child: Center(
               child: Text(
                 '${model.description}',
                 maxLines: 3,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(fontSize: 10.5.sp, color: Colors.grey,),textAlign: TextAlign.center,
               ),
             ),
           ),
         ),
         Row(
           children: [
             Expanded(
               child: Container(
                 padding: EdgeInsets.zero,
                 color: Colors.green,
                 child: OutlinedButton( onPressed: ()
                 {
                   FoodCubitAdmin.get(context).changeStatusOfAvailability().then((value)
                   {
                     FoodCubitAdmin.get(context).setStatusOfAvilabilty(idOfDoc:idsOfItem,setAvailabilitybyadmin: FoodCubitAdmin.get(context).Availability );
                   });
                 }, child: Text(model.availability!?'متاح':'غير متاح',style: TextStyle(fontSize: 15.sp,color: Colors.white),)),
               ),
             ),
           ],
         ),
         SizedBox(height: .5.h,),
       ],
     ),
   ),
 );