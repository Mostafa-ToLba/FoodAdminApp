
import 'package:admin/modules/adminBloc/adminBlocStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBloc extends Cubit<AdminBlocStates> {
  static BuildContext? context;

  AdminBloc(AdminBlocStates InitialFoodAdminState)
      : super(InitialFoodAdminState);

  static AdminBloc get(context) => BlocProvider.of(context);

}