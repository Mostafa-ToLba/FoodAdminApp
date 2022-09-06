
import 'package:admin/modules/login/loginCubit/loginCubitStates.dart';
import 'package:admin/modules/shared/componenet/component.dart';
import 'package:admin/modules/shared/constants/constants.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginCubit extends Cubit<LoginCubitStates> {
  AdminLoginCubit(LoginCubitStates InitialLoginState) : super(InitialLoginState);


  static AdminLoginCubit get(context) => BlocProvider.of(context);


  Future Login ({
    required String email ,
    required String password ,
  })

  async {
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value)
    {
      emit(LoginSuccessState(value.user!.uid));
     uId = value.user!.uid;
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }


  bool UnvisibleBassword=true ;
  IconData Suffix= IconBroken.Hide;
  ChangeSuffix () {
    UnvisibleBassword = !UnvisibleBassword;
    UnvisibleBassword ? Suffix =IconBroken.Hide : Suffix= IconBroken.Show ;
    emit(ChangeSuffixLoginState());
  }

  Future checkForAdmin({email,password,context})
  async {
   await FirebaseFirestore.instance.collection('users').get().then((value)
    {
        for(var element in value.docs)
        {
          if(element['email']==email&&element['password']==password&&element['AdminOrUser']=='Admin')
          {
            Login(email: email, password: password);
          }
          else if(element['email']!=email||element['password']!=password||element['AdminOrUser']!='Admin')
            {
              defaultToast(message: 'خطأ في البيانات التي تم ادخالها', color: Colors.black,context: context);
            }
        }
    });
  }
}