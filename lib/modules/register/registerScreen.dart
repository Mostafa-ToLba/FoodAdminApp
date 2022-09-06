
import 'package:admin/modules/register/register_Cubit/registerCubit.dart';
import 'package:admin/modules/register/register_Cubit/registerCubitStates.dart';
import 'package:admin/modules/shared/componenet/component.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:custom_clippers/custom_clippers.dart';

//#bfffd6

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var phoneController = TextEditingController();
   var formKey = GlobalKey<FormState>();
   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> AdminRegisterCubit(RegisterCubitInitialState()),
      child: BlocConsumer<AdminRegisterCubit,RegisterCubitStates>(
        listener: (BuildContext context ,state)
        {
          if(state is RegisterErrorState)
          {
            Fluttertoast.showToast(msg: '${state.error}');
          }
          if(state is createUserSuccessState)
          {
            Fluttertoast.showToast(msg: 'تم انشاء الحساب بنجاح');
   //         NavigateTo(context, OnboardingScreen());
          }
        },
        builder: (BuildContext context,state)
        {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
            ),
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper:DirectionalWaveClipper(),
                          child: Container(
                            height: 300,
                            padding: EdgeInsets.all(20),
                            color: HexColor('#ffebed'),
                            alignment: Alignment.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(45),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(backgroundColor: Colors.white,),
                              IconButton(onPressed: ()
                              {
                                Navigator.pop(context);
                              }, icon: Icon(IconBroken.Arrow___Left_2,color:HexColor('#7a0000') ,)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20,left: 20,top: 110),
                          child: Center(
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children:
                                [
                                  Text('انشاء حساب',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color:HexColor('#7a0000')),),
                                  Text('انشأ حسابك الان لكي تتمكن من الدخول',style: TextStyle(fontSize: 16,color:Colors.grey,fontWeight: FontWeight.w600),),
                                  SizedBox(height: 50,),
                                  defultformfield(
                                    controle: nameController,
                                    keyboard: TextInputType.text,
                                    prefix: IconBroken.User,
                                    label: '* الاسم',
                                    validate:(value)
                                    {
                                      if(value.isEmpty)
                                      {
                                        return'من فضلك ادخل الاسم ';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30,),
                                  defultformfield(
                                    controle: emailController,
                                    keyboard: TextInputType.emailAddress,
                                    prefix: IconBroken.Message,
                                    label: '* البريد الالكتروني',
                                    validate:(value)
                                    {
                                      if(value.isEmpty)
                                      {
                                        return'من فضلك ادخل البريد الالكتروني ';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30,),
                                  defultformfield(
                                    isPassword:AdminRegisterCubit.get(context).UnvisibleBassword,
                                    suffixPressed:()
                                    {
                                      AdminRegisterCubit.get(context).ChangeSuffix();
                                    } ,
                                    suffix: AdminRegisterCubit.get(context).Suffix,
                                    controle: passwordController,
                                    keyboard: TextInputType.visiblePassword,
                                    prefix: IconBroken.Lock,
                                    label: '* كلمه المرور',
                                    validate:(value)
                                    {
                                      if(value.isEmpty)
                                      {
                                        return'من فضلك ادخل كلمه المرور';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30,),
                                  defultformfield(
                                    controle: phoneController,
                                    keyboard: TextInputType.phone,
                                    prefix: IconBroken.Call,
                                    label: '* رقم الموبايل',
                                    validate:(value)
                                    {
                                      if(value.isEmpty)
                                      {
                                        return'من فضلك ادخل رقم الموبايل';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('By signing you agree to our',style: TextStyle(fontSize: 15,color:HexColor('#7a0000') ),),
                                          Text(' team of use',style: TextStyle(fontSize: 15,color:Colors.grey),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(' and ',style: TextStyle(fontSize: 15,color:HexColor('#7a0000')),),
                                          Text('privacy notice',style: TextStyle(fontSize: 15,color:Colors.grey),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 60,),

                                  ConditionalBuilder(
                                      condition: state is! RegisterLoadingState,
                                      builder: (BuildContext context)=>Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                            width: 325,
                                            height: 55,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),color:  HexColor('#7a0000')),
                                            child: TextButton(
                                              style: ButtonStyle(
                                                splashFactory: NoSplash.splashFactory,
                                              ),
                                              onPressed: ()
                                            {
                                              if(formKey.currentState!.validate())
                                              {
                                                AdminRegisterCubit.get(context).Register(email: emailController.text,phone: phoneController.text,password:
                                                passwordController.text,name: nameController.text);
                                              }
                                            }
                                              ,child: Text('انشاء حساب',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),)
                                        ),
                                      ),
                                      fallback: (BuildContext context)=>Center(child: CircularProgressIndicator())
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],

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
