
 import 'dart:async';
import 'package:admin/foodLayout/foodLayoutScreen.dart';
import 'package:admin/modules/login/login_screen.dart';
import 'package:admin/modules/shared/componenet/component.dart';
import 'package:admin/modules/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({Key? key}) : super(key: key);

   @override
   _SplashScreenState createState() => _SplashScreenState();
 }

 class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()
    {
      if(uId!= null)
      {
        NavigateAndFinsh(context, FoodLayoutScreen());
      }else
      {
        NavigateAndFinsh(context, AdminLoginScreen());
      }
    });
  }
   @override
   Widget build(BuildContext context) {
     return AnnotatedRegion<SystemUiOverlayStyle>(
       value: SystemUiOverlayStyle(
         statusBarColor: Colors.transparent,
         statusBarIconBrightness:  Brightness.light,
       ),
       child: Scaffold(
         body: Container(
           child: ClipRRect(
             child: Stack(
               alignment: Alignment.center,
               children: [
                 /*
                       Container(
                         height: 100.h,
                         decoration: BoxDecoration(
                             image: const DecorationImage(fit: BoxFit.cover,image:
                             const AssetImage('Assets/images/hh.jpg'),)),),

                        */
                 Container(
                     height: 100.h,
                     /*
                         child: Card(
                           elevation: 8,
                           color: Colors.grey,
                           shadowColor: Colors.grey,
                           margin: EdgeInsets.only(bottom: 0),
                           clipBehavior: Clip.antiAliasWithSaveLayer,
                           child: CachedNetworkImage(
                             imageUrl: 'https://images.unsplash.com/photo-1525164286253-04e68b9d94c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                             imageBuilder: (context, imageProvider) => Container(
                               decoration: BoxDecoration(
                                 image: DecorationImage(
                                     image: imageProvider,fit: BoxFit.cover),
                               ),
                             ),
                             placeholder: (context, url) => Center(
                               child: Shimmer.fromColors(
                                 baseColor: Colors.grey[200]!,
                                 highlightColor: Colors.grey[100]!,
                                 child: Container(
                                   height: 100.h,
                                   color: Colors.grey[700],
                                 ),
                               ),
                             ),
                             errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                           ),
                         ),

                          */
                     decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover,image:AssetImage('Assets/images/hh.jpg',) ))
                 ),
                 Padding(
                   padding:  EdgeInsets.only(bottom:  5.h),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                             width: 19.h,      //It will take a 30% of screen height
                             height: 19.h,
                             decoration: BoxDecoration(
                                 image: const DecorationImage(fit: BoxFit.cover,image:
                                 const AssetImage('Assets/images/logo.png'),)),),
                           SizedBox(width: 13,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                             ],
                           ),
                         ],
                       ),
                       SizedBox(height: 20,),
                       //      Container(height: 4.h,width:4.h ,child: CircularProgressIndicator(color: Colors.white,)),
                     ],
                   ),
                 ),
               ],
             ),
           ),
         ),
       ),
     );
   }
 }
