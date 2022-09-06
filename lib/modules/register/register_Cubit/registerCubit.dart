

import 'package:admin/models/registerModel/registemModel.dart';
import 'package:admin/modules/register/register_Cubit/registerCubitStates.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminRegisterCubit extends Cubit<RegisterCubitStates> {
  AdminRegisterCubit(RegisterCubitStates RegisterCubitInitialState) : super(RegisterCubitInitialState);


  static AdminRegisterCubit get(context)=> BlocProvider.of(context);

  Future Register({
    required String email,
    required String name,
    required String phone,
    required String password,
  })
  async {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password).then((value)
    {
      createUser(name: name,phone: phone,uId:value.user!.uid,email: email,password: password,);
    }).catchError((error)
    {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }
//......

  void createUser({
    String? email,
    String? name,
    String? phone,
    String? password,
    String? uId,
  }) {
    UserModel userModel = UserModel(email: email, name: name, phone: phone, uId: uId,osUserID: '',password:password,AdminOrUser: 'Admin');
    FirebaseFirestore.instance.collection('users').doc(uId).set(
        userModel.toMap()).then((value) {
          emit(createUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(createUserErrorState());
    });
  }

  //........


  bool UnvisibleBassword=true ;
  IconData Suffix= IconBroken.Hide;
  ChangeSuffix () {
    UnvisibleBassword = !UnvisibleBassword;
    UnvisibleBassword ? Suffix= IconBroken.Hide : Suffix =IconBroken.Show;
    emit(ChangeSuffixRegisterState());
  }
}