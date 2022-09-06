
 import 'package:admin/foodLayout/foodLayoutScreen.dart';
import 'package:admin/modules/login/loginCubit/loginCubit.dart';
import 'package:admin/modules/login/loginCubit/loginCubitStates.dart';
import 'package:admin/modules/register/registerScreen.dart';
import 'package:admin/modules/shared/casheHelper/sharedPreferance.dart';
import 'package:admin/modules/shared/componenet/component.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:custom_clippers/Clippers/sin_cosine_wave_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class AdminLoginScreen extends StatelessWidget {
   const AdminLoginScreen({Key? key}) : super(key: key);
   @override
   Widget build(BuildContext context) {
     var emailController =TextEditingController();
     var passwordController =TextEditingController();
     var formKey = GlobalKey<FormState>();
     return BlocProvider(
       create: (BuildContext context)=>AdminLoginCubit(InitialLoginState()),
       child: BlocConsumer<AdminLoginCubit,LoginCubitStates>(
         listener: (BuildContext context, state) {
           if(state is LoginSuccessState)
           {
             CasheHelper.SaveData(key: 'uId', value:state.uId )!.then((value)
             {
               Fluttertoast.showToast(msg: 'تم تسجيل الدخول بنجاح');
               NavigateAndFinsh(context, FoodLayoutScreen());
             });
           }
           else if(state is LoginErrorState)
           {
             Fluttertoast.showToast(msg: '${state.error}');
           }
         },
         builder: (BuildContext context, Object? state) {
           return AnnotatedRegion<SystemUiOverlayStyle>(
             value: SystemUiOverlayStyle(
               statusBarIconBrightness: Brightness.light,
               statusBarColor: Colors.transparent,
             ),
             child: Scaffold(
               body: SingleChildScrollView(
                 child: Column(
                   children: [
                     ClipRRect(
                       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0),bottomRight:Radius.circular(0) ),
                       child:  ClipPath(
                      //   clipper:SinCosineWaveClipper(),
                         child: Container(
                           decoration: BoxDecoration
                             (
                               image: DecorationImage(fit: BoxFit.cover,image:
                               AssetImage('Assets/images/adminLoginPage.jpg'),)),
                           height: 48.h,
                           padding: EdgeInsets.all(20),
                           //    color: HexColor('#dcfce7'),
                           alignment: Alignment.center,
                         ),
                       ),
                       /*
                     Container(
                       height: 300,
                         decoration: BoxDecoration
                           (
                             image: DecorationImage(fit: BoxFit.cover,image:
                             NetworkImage('https://images.unsplash.com/photo-1594723413117-a07053dd8fe8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'),))
                     ),

                          */
                     ),
                     Padding(
                       padding:  EdgeInsets.only(top: 2.h),
                       child: Container(
                         //     height: 57.h,
                         child: Padding(
                           padding:  EdgeInsets.only(
                             right: 2.h,
                             left: 2.h,
                           ),
                           child: Container(
                             //     height: 50.h,
                             child: Form(
                               key: formKey,
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   SizedBox(
                                     height: 0,
                                   ),
                                   Text(
                                     'تسجيل الدخول',
                                     style: TextStyle(
                                         fontSize: 20.sp,
                                         color: HexColor('#8d2422'),
                                         fontWeight: FontWeight.w600),
                                   ),
                                   Text(
                                     'سجل الدخول لاستقبال الطلبات',
                                     style: TextStyle(
                                         fontSize: 13.sp,
                                         color: Colors.grey,
                                         fontWeight: FontWeight.w600),
                                   ),
                                   SizedBox(
                                     height: 2.h,
                                   ),
                                   defultformfield(
                                     textStyle: TextStyle(fontSize: 13.sp),
                                     controle: emailController,
                                     prefix: IconBroken.Message,
                                     label: 'البريد الالكتروني',
                                     keyboard: TextInputType.emailAddress,
                                     validate: (value) {
                                       if (value.isEmpty) {
                                         return 'من فضلك ادخل البريد الالكتروني';
                                       }
                                     },
                                   ),
                                   SizedBox(
                                     height: 3.h,
                                   ),
                                   defultformfield(
                                     textStyle: TextStyle(fontSize: 13.sp),
                                     suffixPressed: () {
                                       AdminLoginCubit.get(context).ChangeSuffix();
                                     },
                                     suffix: AdminLoginCubit.get(context).Suffix,
                                     isPassword:
                                     AdminLoginCubit.get(context).UnvisibleBassword,
                                     controle: passwordController,
                                     keyboard: TextInputType.visiblePassword,
                                     prefix: IconBroken.Unlock,
                                     label: 'كلمه المرور',
                                     validate: (value) {
                                       if (value.isEmpty) {
                                         return 'من فضلك ادخل كلمه المرور';
                                       }
                                     },
                                   ),
                                   SizedBox(height: 4.h),
                                   ConditionalBuilder(
                                     condition: state is! LoadingLoginState,
                                     builder: (BuildContext context) => Container(
                                         width: 100.w,
                                         height: 7.h,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.all(
                                                 Radius.circular(40)),
                                             color: HexColor('#8d2422')),
                                         child: MaterialButton(
                                           /*
                                             style: ButtonStyle(
                                               splashFactory: NoSplash.splashFactory,
                                             ),
                                              */
                                           color: HexColor('#7a0000'),
                                           onPressed: () {
                                         if(formKey.currentState!.validate())
                                          {
                 AdminLoginCubit.get(context).checkForAdmin(email:emailController.text,password:passwordController.text,context: context);
           //  AdminLoginCubit.get(context).Login(email: emailController.text, password: passwordController.text);
                                            //  }
                                             }
                                           },
                                           child: Text(
                                             'تسجيل دخول',
                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 15.sp,
                                                 fontWeight: FontWeight.bold),
                                           ),
                                         )),
                                     fallback: (BuildContext context) => Center(
                                         child: CircularProgressIndicator()),
                                   ),
                                   /*
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       TextButton(
                                         onPressed: () {
                                           NavigateTo(context, RegisterScreen());
                                         },
                                         child: Text(
                                           'انشاء حساب',
                                           style: TextStyle(
                                             fontSize: 13.sp,
                                             fontWeight: FontWeight.w600,
                                             color: HexColor('#8d2422'),
                                           ),
                                         ),
                                       ),
                                       SizedBox(
                                         width: 1.2.w,
                                       ),
                                       Text('ليس لديك حساب؟',
                                           style: TextStyle(
                                             color: Colors.grey,
                                             fontSize: 11.sp,
                                           )),
                                       SizedBox(height: 2.h,),
                                     ],
                                   ),

                                    */
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           );
         },
       ),
     );
   }
 }
