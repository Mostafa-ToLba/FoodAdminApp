import 'package:admin/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:admin/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:admin/modules/login/login_screen.dart';
import 'package:admin/modules/notification/notification.dart';
import 'package:admin/modules/shared/componenet/component.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends StatelessWidget {
   UserProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        FoodCubitAdmin.get(context).GetUserDataFunction();
        return BlocConsumer<FoodCubitAdmin,FoodCubitStates>(
          listener:(context,state)
          {
            if(state is SocialCubitSignOutSuccessState)
            {
              Fluttertoast.showToast(msg: 'تم تسجيل الخروج بنجاح');
            }
          },
          builder:(context,state)
          {
            nameController.text=FoodCubitAdmin.get(context).getUserData.name!;
            emailController.text=FoodCubitAdmin.get(context).getUserData.email!;
            phoneController.text=FoodCubitAdmin.get(context).getUserData.phone!;
            passwordController.text=FoodCubitAdmin.get(context).getUserData.password!;
            return SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(1.2.h),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children:
                    [
                      Container(height: 19.h,width:double.infinity,child: Image(image: AssetImage('Assets/images/logo.png'))),
                      Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children:
                          [
                            SizedBox(height: 3.h,),
                            defultformfield(
                              controle: nameController,
                              keyboard: TextInputType.text,
                              prefix: IconBroken.User,
                              label: 'الاسم',
                            ),
                            SizedBox(height: 3.h,),
                            defultformfield(
                              controle: emailController,
                              keyboard: TextInputType.emailAddress,
                              prefix: IconBroken.Message,
                              label: 'البريد الالكتروني',
                            ),
                            SizedBox(height: 3.h,),
                            defultformfield(
                              suffixPressed:()
                              {

                              } ,
                              controle: passwordController,
                              keyboard: TextInputType.visiblePassword,
                              prefix: IconBroken.Lock,
                              label: 'كلمه المرور',
                            ),
                            SizedBox(height: 3.h,),
                            defultformfield(
                              controle: phoneController,
                              keyboard: TextInputType.phone,
                              prefix: IconBroken.Call,
                              label: 'رقم الموبايل',
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: OutlinedButton(onPressed: ()
                                  {
                                    FoodCubitAdmin.get(context).SignUpshowAlertDialog(context);

                                  }, child: Text('تسجيل الخروج',style: TextStyle(fontSize: 17.sp),)),
                                ),
                                SizedBox(width: 3.w,),
                                Expanded(
                                  child: OutlinedButton(onPressed: ()
                                  {
                                    NavigateTo(context,  sendNotification());

                                  }, child: Text('ارسال اشعار',style: TextStyle(fontSize: 17.sp),)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } ,
        );
      },
    );
  }
}
