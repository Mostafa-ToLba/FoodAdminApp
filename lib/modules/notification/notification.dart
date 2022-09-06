
 import 'package:admin/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:admin/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:admin/modules/shared/componenet/component.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class sendNotification extends StatelessWidget {
    sendNotification({Key? key}) : super(key: key);
   var TextController =TextEditingController();
    var notifacationController =TextEditingController();
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<FoodCubitAdmin,FoodCubitStates>(
       listener: (BuildContext context, state) {  },
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
           body: Padding(
             padding:  EdgeInsets.all(3.h),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children:
               [
                 TextFormField(
                   maxLines: 10,
                   minLines: 1,
                   style: TextStyle(color: Colors.black),
                   cursorColor: Colors.blue,
                   autofocus: false,
                   controller: notifacationController,
                   decoration:
                   InputDecoration(
                     hintStyle: TextStyle(color: Colors.grey),
                     focusColor: Colors.blue,
                     fillColor: Colors.blue,
                     contentPadding: EdgeInsets.symmetric(horizontal: 0),
                     hintText: 'اكتب هنا عنوان رساله الاشعار',
                   ),
                 ),
                 SizedBox(height: 5.h,),
                 TextFormField(
                   maxLines: 10,
                   minLines: 1,
                   style: TextStyle(color: Colors.black),
                   cursorColor: Colors.blue,
                   autofocus: false,
                   controller: TextController,
                   decoration:
                   InputDecoration(
                     hintStyle: TextStyle(color: Colors.grey),
                     focusColor: Colors.blue,
                     fillColor: Colors.blue,
                     contentPadding: EdgeInsets.symmetric(horizontal: 0),
                     hintText: 'اكتب هنا رساله الاشعار',
                   ),
                 ),
                 SizedBox(height: 5.h,),
                 OutlinedButton(onPressed: ()
                 {
                   FoodCubitAdmin.get(context).sendToeveryOne().then((value)
                   {
                     FoodCubitAdmin.get(context).postNotificationToEveryOne(heading:'${notifacationController.text}',content:TextController.text);
                     TextController.clear();
                     notifacationController.clear();
                   });
                 }, child: Text('ارسل الاشعار',style: TextStyle(fontSize: 18.sp),)),
               ],
             ),
           ),
         );
       },
     );
   }
 }
