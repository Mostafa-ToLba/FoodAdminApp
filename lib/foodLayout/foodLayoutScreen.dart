
import 'package:admin/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:admin/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';


class FoodLayoutScreen extends StatelessWidget {
    FoodLayoutScreen({Key? key}) : super(key: key);
   @override
   Widget build(BuildContext context) {
         return WillPopScope(
           onWillPop: () async {
           bool? result= await showDialog<bool>(
             context: context,
             builder: (c) => AlertDialog(
               title: Text('Warning',style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
               content: Text('Do you really want to exit ?',style: TextStyle(fontSize: 13.sp,)),
               actions: [
                 TextButton(
                   child: Text('Yes',style: TextStyle(fontSize: 11.sp,)),
                   onPressed: () => Navigator.pop(c, true),
                 ),
                 TextButton(
                   child: Text('No',style: TextStyle(fontSize: 11.sp,)),
                   onPressed: () => Navigator.pop(c, false),
                 ),
               ],
             ),
           );
           if(result == null){
             result = false;
           }
           return result;
           },
           child: BlocProvider(
             create: (BuildContext context)=>FoodCubitAdmin(InitialFoodState())..getNotify()..setAdminOs(),
             child: BlocConsumer<FoodCubitAdmin,FoodCubitStates>(
               listener: (BuildContext context, state) {
                 print(FoodCubitAdmin.get(context).cartItmNumber.toString());
               },
               builder: (BuildContext context, Object? state) {
                 return Scaffold(
                   appBar: AppBar(
                     toolbarHeight: 7.5.h,
                     titleSpacing: 0,
                     actions: [
                       Padding(
                         padding:  EdgeInsets.only(right: 5.w),
                         child: TextButton(
                             onPressed: () {
                               FoodCubitAdmin.get(context).changeStatus();
                               FoodCubitAdmin.get(context).setStatus(
                                   FoodCubitAdmin.get(context).status);
                               //            FoodCubitAdmin.get(context).getStatus();
                             },
                             child: Text('مفتوح / مغلق',style: TextStyle(fontSize: 16.sp),)),
                       ),
                     ],

                     title: Padding(
                       padding:  EdgeInsets.only(left:1.w ),
                       child: Row(
                         children: [
                           Row(
                             children: [
                               SizedBox(width: 3.w,),
                               CircleAvatar(backgroundColor: Colors.black,radius: 16.sp,child:StreamBuilder <QuerySnapshot>(
                                 stream: FoodCubitAdmin.get(context).getMyOrder(),
                                 builder: (context, snapshot)
                                 {
                                   if(!snapshot.hasData||snapshot.data!.size==0)
                                     return Center(child: Text('0',style: TextStyle(color: Colors.white,fontSize:12.5.sp ),));
                                   else
                                   {
                                     return Text('${snapshot.data!.docs.length}',style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                                   }
                                   return Text('',style: TextStyle(color: Colors.white),);
                                 },
                               ), ),
                             ],
                           ),
                           SizedBox(width: 3.w,),
                           StreamBuilder <QuerySnapshot>(
                             stream: FoodCubitAdmin.get(context).getstatusfromdata(),
                             builder: (context, snapshot)
                             {
                               if(!snapshot.hasData)
                                 return Center(child: Text('',style: TextStyle(fontSize: 16.sp),));
                               else
                               {
                                 for(var doc in snapshot.data!.docs)
                                   return Row(
                                     children: [
                                       Text(doc['status']?'مفتوح الان':'مغلق الان',style: TextStyle(fontSize: 16.sp),),
                                       SizedBox(width: 3.5.w,),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 0),
                                         child: CircleAvatar( backgroundColor: doc['status']? Colors.green:Colors.red,radius: 5.sp,),
                                       ),
                                     ],
                                   );
                               }
                               return Text('');
                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                   body: FoodCubitAdmin.get(context).Screens[FoodCubitAdmin.get(context).currentIndex],
                   bottomNavigationBar: BottomNavigationBar(
                     onTap: (index)
                     {
                       FoodCubitAdmin.get(context).ChangeBottomNavItem(index, context);
                     },
                     currentIndex:FoodCubitAdmin.get(context).currentIndex ,
                     items:
                     [
                       BottomNavigationBarItem(icon: Icon(IconBroken.Home,size: 19.sp,),label: 'الرئيسية'),
                       BottomNavigationBarItem(icon: Icon(IconBroken.Edit,size: 19.sp,),label: 'تعديل المنيو'),
                       BottomNavigationBarItem(icon: Icon(IconBroken.User,size: 19.sp,),label: 'حسابي'),
                     ],),
                 );
               },
             ),
           ),
         );
   }
 }


