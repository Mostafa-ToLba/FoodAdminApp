
import 'package:admin/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:admin/models/addToCartModel/addToCartModel.dart';
import 'package:admin/models/checkenModel/checkenModel.dart';
import 'package:admin/models/homeModel/homeModel.dart';
import 'package:admin/models/makeOrder/makeOrder.dart';
import 'package:admin/models/registerModel/registemModel.dart';
import 'package:admin/modules/editMenu/editMenu.dart';
import 'package:admin/modules/login/login_screen.dart';
import 'package:admin/modules/profileScreen/profileScreen.dart';
import 'package:admin/modules/shared/casheHelper/sharedPreferance.dart';
import 'package:admin/modules/shared/componenet/component.dart';
import 'package:admin/modules/shared/constants/constants.dart';
import 'package:admin/modules/shared/styles/icon_broken.dart';
import 'package:admin/modules/userProfile/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';

class FoodCubitAdmin extends Cubit<FoodCubitStates> {
  static BuildContext? context;

  FoodCubitAdmin(FoodCubitStates InitialFoodState) : super(InitialFoodState);

  static FoodCubitAdmin get(context) => BlocProvider.of(context);

  final List<String> HorizonatalList = [
    'Recommended',
    'Pizza',
    'Crep',
    'Meet',
    'Sandwitch',
    'Checken',
  ];
  int selectedIndex = 0;

  onSelected(int index) {
    selectedIndex = index;
    emit(ChangeHorizontalListColor());
  }

  List<Widget> Screens =
  [
    ProfileScreen(),
    EditMenu(),
    UserProfile(),
  ];

  int currentIndex = 0;

  ChangeBottomNavItem(int index, context) {
    currentIndex = index;
    emit(ChangeNavBarItemState());
  }

  List<String>HorizontalFormFire = [];
  List<String>HorizontalFormFireImages = [];

  getHorizontalList() {
    if (HorizontalFormFire.isEmpty) {
      FirebaseFirestore.instance.collection('horizontal').get().then((value) {
        value.docs.forEach((element) {
          HorizontalFormFire.add(element.data()['name']);
          HorizontalFormFireImages.add(element.data()['image']);
        });
        emit(getHorizontalListSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(getHorizontalListErrorState());
      });
    }
  }

  // checkenModel checkenmodel=checkenModel();
  List<checkenModel> Models = [];

  getChecken() {
    // Models =[];
    if (Models.isEmpty) {
      FirebaseFirestore.instance.collection('horizontal').doc(
          '0elWQCQicbNEe3V5NSU0').get().then((value) {
        value.reference.collection('CheckenList1').get().then((value) {
          value.docs.forEach((element) {
            Models.add(checkenModel.fromJson(element.data()));
          });
          emit(getCheckenListSuccessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(getCheckenListErrorState());
      });
    }
  }

  List<checkenModel> MashwyList = [];

  getMashwy() {
    // Models =[];
    if (MashwyList.isEmpty) {
      FirebaseFirestore.instance.collection('horizontal').doc(
          'q6mmOQSf9X1JSzp4dETh').get().then((value) {
        value.reference.collection('mashwyat').get().then((value) {
          value.docs.forEach((element) {
            MashwyList.add(checkenModel.fromJson(element.data()));
          });
          emit(getMashwyatSuccessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(getMashwyatErrorState());
      });
    }
  }

  //getRecommended
  List<checkenModel> Recommended = [];

  getRecommneded() {
    if (Recommended.isEmpty) {
      FirebaseFirestore.instance.collection('horizontal').doc(
          'KZmHNHuMG7MXva0sxun1').get().then((value) {
        value.reference.collection('recommendedList').get().then((value) {
          value.docs.forEach((element) {
            Recommended.add(checkenModel.fromJson(element.data()));
          });
          emit(getRecommendedListSuccessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(getRecommendedListErrorState());
      });
    }
  }

  //getCrep
  List<checkenModel> Crep = [];

  getCrep() {
    if (Crep.isEmpty) {
      FirebaseFirestore.instance.collection('horizontal').doc(
          'POLHprPyrsJIlPDpUbQn').get().then((value) {
        value.reference.collection('crepList').get().then((value) {
          value.docs.forEach((element) {
            Crep.add(checkenModel.fromJson(element.data()));
          });
          emit(getCrepListSuccessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(getCrepListErrorState());
      });
    }
  }

  //getpizza
  List<checkenModel> Pizza = [];

  getPizza() {
    if (Pizza.isEmpty) {
      FirebaseFirestore.instance.collection('horizontal').doc(
          'VbgjOSbCCNNvIRATPvq7').get().then((value) {
        value.reference.collection('pizzaList').get().then((value) {
          value.docs.forEach((element) {
            Pizza.add(checkenModel.fromJson(element.data()));
          });
          emit(getPizzaListSuccessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(getPizzaListErrorState());
      });
    }
  }

  //getMeet
  List<checkenModel> Meet = [];

  getMeet() {
    if (Meet.isEmpty) {
      FirebaseFirestore.instance.collection('horizontal').doc(
          'iww4jgb1Y4FPqkjAIF4m').get().then((value) {
        value.reference.collection('meetList').get().then((value) {
          value.docs.forEach((element) {
            Meet.add(checkenModel.fromJson(element.data()));
          });
          emit(getMeetListSuccessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(getMeetListErrorState());
      });
    }
  }

  int number = 1;

  Plus() {
    number++;
    emit(plusSuccessState());
  }

  Minus() {
    number--;
    emit(minusSuccessState());
  }

  Future addToCartFunction({
    String? name,
    int? price,
    int? num,
    String? text,
  }) async {
    AddToCart addToCart = AddToCart(
      name: name,
      price: price,
      num: num,
      text: text,
      username: '',
      phone: '',
      location: '',
      time: '',
      uId: '',
      total: 0,
    );
    FirebaseFirestore.instance.collection('users').
    doc(FirebaseAuth.instance.currentUser!.uid).
    collection('addToCart').add(addToCart.toMap()).then((value) {
      emit(addToCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(addToCartErrorState());
    });
    deleteNull();
  }


  List<AddToCart>GetCartList1 = [];
  List<AddToCart>GetCartList = [];
  List<String>Ids = [];

  Future getCart() async {
    GetCartList = [];
    Ids = [];
    emit(getCartLoadingState());
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['name'] != null && element.data()['num'] != null &&
            element.data()['price'] != null)
          GetCartList.add(AddToCart.fromJson(element.data()));
        Ids.add(element.id);
      });
    }).then((value) {
      getNumerOfItemInCart();
      emit(getCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getCartErrorState());
    });
  }

  Future getCart2() async {
    GetCartList = [];
    Ids = [];
    emit(getCartLoadingState());
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid)
        .collection('addToCart')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        if (element.data()['name'] != null && element.data()['num'] != null &&
            element.data()['price'] != null)
          GetCartList.add(AddToCart.fromJson(element.data()));
        Ids.add(element.id);
      });
      getNumerOfItemInCart();
      emit(getCartSuccessState());
    });
  }


  var Total;

  Future totalPrice() async {
    Total = 0;
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['name'] != null && element.data()['num'] != null &&
            element.data()['price'] != null)
          Total += element.data()['price'];
      });
      emit(getTotalSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getTotalErrorState());
    });
  }

  Future deleteOrder(id) async {
    emit(deleteItemCartLoadingState());
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid)
        .collection('addToCart').doc(id).delete().then((value) {
      getCart2();
      totalPrice();
      getNumerOfItemInCart();
      emit(deleteItemCartSuccessState());
    }).catchError((error) {
      emit(deleteItemCartErrorState());
    });
  }

  Future deleteNull() async {
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).
    collection('addToCart').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['name'] == null && element.data()['num'] == null &&
            element.data()['price'] == null) {
          FirebaseFirestore.instance.collection('users').doc(
              FirebaseAuth.instance.currentUser!.uid).
          collection('addToCart').doc(element.id).delete();
        }
      });
    });
  }

  int? cartItmNumber;

  Future getNumerOfItemInCart() async {
    emit(getCartItemNumerLoadingState());
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid)
        .collection('addToCart').get().then((value) {
      cartItmNumber = value.docs.length;
      emit(getCartItemNumerSuccessState());
    });
    emit(getCartItemNumerSuccessState());
  }


  int? dataLength;

  Future<List<QueryDocumentSnapshot<
      Map<String, dynamic>>>> getSliderImageFromDb() async {
    var fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await fireStore.collection(
        'slider').get();
    dataLength = snapshot.docs.length;
    return snapshot.docs;
  }

  Future showAlertDialog(BuildContext context,
      {LocationController, NameController, PhoneController, total}) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء", style: TextStyle(fontSize: 17),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("اكمال الطلب", style: TextStyle(fontSize: 17)),
      onPressed: () async {
        await updateCart(location: LocationController,
            phone: PhoneController,
            username: NameController, total: total)
            .then((value) {
          makeOrder2();
          updateOrders();
          deleteOrdersInCart();
          //       SendNotificationToSomeOne(content:'وصل اوردر جديد',playerIds:['2a0186ce-6270-11ec-82a3-9efbc10504e3'],heading:'قصر الشام ' );
        }).then((value) {
          //      NavigateAndFinsh(context, OrderDoneScreen());
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تاكيد الطلب "),
      content: Text("هل حقا تريد اكمال الطلب ؟"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  makeOrder({
    String? name,
    String? phone,
    String? uId,
    String? location,
    int? num,
    int? price,
    String? instructions,
    String? time,
    String? itemName,
  }) {
    makeOrderModel orderModel = makeOrderModel(name: name,
        phone: phone,
        uId: FirebaseAuth.instance.currentUser!.uid,
        location: location,
        num: num,
        price: price,
        instructions: instructions,
        time: time,
        itemName: itemName);

    FirebaseFirestore.instance.collection('orders').doc(
        FirebaseAuth.instance.currentUser!.uid).set(orderModel.toMap()).then((
        value) {
      FirebaseFirestore.instance.collection('orders').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('userOrders').
      add(orderModel.toMap()).then((value) {
        emit(makeOrderSuccessState());
      }).catchError((error) {
        emit(makeOrderErrorState());
      }).catchError((error) {
        print(error.toString());
        emit(makeOrderErrorState());
      });
    });
  }

  Future makeOrder2() async {
    //   AddToCart addToCart;
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance.collection('orderss').doc(
            FirebaseAuth.instance.currentUser!.uid).set({
          'name': element.data()['username'],
          'location': element.data()['location'],
          'phone': element.data()['phone'],
          'total': element.data()['total'],
          'time': element.data()['time'],
          'uId': element.data()['uId'],
        }).then((value) {
          emit(makeOrderSuccessState());
        });
        FirebaseFirestore.instance.collection('orderss').doc(
            FirebaseAuth.instance.currentUser!.uid)
            .collection('cartOrders')
            .add(element.data());
        emit(makeOrderSuccessState());
      });
    }).then((value) {
      updateOrders();
      //    updateCart();
      //    emit(makeOrderSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(makeOrderErrorState());
    });
  }

  Future updateCart({
    required String location,
    required String phone,
    required String username,
    required int total,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.update(
            {
              'location': location,
              'phone': phone,
              'username': username,
              'time': DateFormat.yMMMMd().add_jm().format(DateTime.now()),
              'uId': FirebaseAuth.instance.currentUser!.uid,
              'total': total,
            });
        emit(updateCartSuccessState());
      });
      emit(updateCartSuccessState());
    }).then((value) {
      emit(updateCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(updateCartErrorState());
    });
  }

  HomeModel? homeModel;

  getOrdersToAdmin() {
    FirebaseFirestore.instance.collection('orderss').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('cartOrder').get().then((value) {
          value.docs.forEach((element) {
            homeModel = HomeModel.fromJson(element.data());
            emit(getOrdersToAdminSuccessState());
          });
          emit(getOrdersToAdminSuccessState());
        });
        emit(getOrdersToAdminSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(getOrdersToAdminErrorState());
    });
  }

  Stream<QuerySnapshot> LoadOrders() {
    return FirebaseFirestore.instance.collection('orderss').snapshots();
  }


  Stream<QuerySnapshot> OrderDetails(id) {
    return FirebaseFirestore.instance.collection('orderss').doc(
        id)
        .collection('cartOrders')
        .snapshots();
  }

  bool color = true;

  changeColorofOrder(id) {
    color = !color;
    emit(changeColorofOrderState());
    color = false;
  }

  Future deleteOrdersInCart() async {
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
        emit(deleteItemCartSuccessState());
      }
      emit(deleteItemCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(deleteItemCartErrorState());
    });
  }

  Future DeleteOrderByAdmin(id) async {
    await FirebaseFirestore.instance.collection('orderss').doc(id)
        .delete()
        .then((value) {
      FirebaseFirestore.instance.collection('orderss').doc(id).collection(
          'cartOrders').get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
        emit(deleteOrderByAdmin());
      });
      emit(deleteOrderByAdmin());
    }).catchError((error) {
      print(error.toString());
      emit(deleteOrderByAdminErrorState());
    });
  }

  Future DeleteOrder(id) async {
    await FirebaseFirestore.instance.collection('orderss').doc(id).collection(
        'cartOrders').get().then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
      emit(deleteOrderByAdmin());
    }).then((value) {
      FirebaseFirestore.instance.collection('orderss').doc(id).delete();
      emit(deleteOrderByAdmin());
    }).catchError((error) {
      print(error.toString());
      emit(deleteOrderByAdminErrorState());
    });
  }

  DeleteOrderr(id) async {
  //  emit(deleteOrderByAdminLoadingState());
    await FirebaseFirestore.instance.collection('orderss').doc(id).collection(
        'cartOrders').get().then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
      FirebaseFirestore.instance.collection('orderss').doc(id).delete();
      //    emit(deleteOrderByAdmin());
    }).then((value) {
      emit(deleteOrderByAdmin());
    }).catchError((error) {
      print(error.toString());
      emit(deleteOrderByAdminErrorState());
    });
 //   emit(deleteOrderByAdmin());
  }


  bool status = true;

  changeStatus() {
    status = !status;
    emit(changeStatusState());
  }

  setStatus(setonlinebyadmin) {
    FirebaseFirestore.instance.collection('online')
        .doc('kmxXeXAPxa88b4EjGSJW')
        .update({'status': setonlinebyadmin})
        .then((value) {
      emit(changeStatusState());
    }).catchError((error) {
      print(error.toString());
      emit(changeStatusErrorState());
    });
  }

  bool getstatus = true;

  getStatus() {
    FirebaseFirestore.instance.collection('online').snapshots().listen((event) {
      event.docs.forEach((element) {
        getstatus = element.data()['status'];
      });
    });
  }

  Stream<QuerySnapshot> getstatusfromdata() {
    return FirebaseFirestore.instance.collection('online').snapshots();
  }


  updateOrders() {
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection('orderss').doc(
            FirebaseAuth.instance.currentUser!.uid).update(
            {
              'location': element.data()['location'],
              'name': element.data()['username'],
              'phone': element.data()['phone'],
              'time': element.data()['time'],
              'total': element.data()['total'],
            }).then((value) {
          emit(updateOrdersState());
        });
      });
      emit(updateOrdersState());
    });
  }


  //oneSignal  ///////////////////////////////////////////////////////////////////////////
  Future getNotify() async {
    OneSignal.shared.getPermissionSubscriptionState().then((state) {
      DocumentReference ref = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      ref.update({
        'osUserID': state.subscriptionStatus.userId,
      }).then((value) {
        emit(getNotiftyState());
      });
    });
    emit(getNotiftyState());
  }


  SendNotificationToSomeOne({content, playerIds, heading}) {
    OneSignal.shared.postNotification(OSCreateNotification(
      additionalData: {
        'data': 'this is our data',
      },
      subtitle: 'MyChat',
      androidSmallIcon: '${IconBroken.Message}',
      playerIds: playerIds,
      content: content,
      heading: heading,
    ));
    emit(pushNotificationToSomeone());
  }

  String? osOfUser;

  String? name;

  Future getOsofUser(id) async {
    await FirebaseFirestore.instance.collection('users').doc(id).get().then((
        value) {
      osOfUser = value.data()!['osUserID'];
      name = value.data()!['name'];
    }).then((value) {
      emit(pushNotificationToSomeone());
    });
  }

  UserModel getUserData = UserModel(osUserID: '',
      phone: '',
      uId: '',
      name: '',
      password: '',
      email: '');

  Future GetUserDataFunction() async {
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      getUserData = UserModel.fromJson(value.data()!);
      emit(getUserDataState());
    }).then((value) {
      emit(getUserDataState());
    }).catchError((error) {
      emit(getUserDataErrorState());
    });
  }

  Future signOut() async
  {
    await FirebaseAuth.instance.signOut().then((value) {
      //   uId='${null}';
      CasheHelper.removeData(key: 'uId', value: uId).then((value) {
        emit(SocialCubitSignOutSuccessState());
      });
      print('signOut UiD == ${uId}');
    }).catchError((error) {
      print(error.toString());
      emit(SocialCubitSignOutErrorState());
    });
  }

  Future changeColorOfOrder(id) async
  {
    FirebaseFirestore.instance.collection('orderss').doc(id).update(
        {'color': false});
  }

  //for Sending Notifcation To everyone
  List<String>? usersNotify = [];

  Future sendToeveryOne() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        usersNotify!.add(element.data()['osUserID']);
      });
      emit(usersaddtoList());
    }).catchError((error) {
      print(error.toString());
    });
  }

  //for Sending Notifcation To everyone
  Future postNotificationToEveryOne({content, heading}) async {
    OneSignal.shared.postNotification(OSCreateNotification(
      additionalData: {
        'data': 'this is our data',
      },
      subtitle: 'MyChat',
      androidSmallIcon: '${IconBroken.Message}',
      playerIds: usersNotify,
      content: content,
      heading: heading,
    ));
    emit(pushNotificationToSomeone());
  }

  Stream<QuerySnapshot> getListHori() {
    return FirebaseFirestore.instance.collection('homeTwo').snapshots();
  }

  Stream<QuerySnapshot> getListHoriz(id) {
    return FirebaseFirestore.instance.collection('homeTwo').doc(id)
        .collection('get')
        .snapshots();
  }

  bool Availability = true;

  Future changeStatusOfAvailability() async {
    Availability = !Availability;
    emit(changeStatusOfAvailabilityState());
  }


  String Number = '0';

  getId(id) {
    Number = id;
    emit(getIdState());
  }

  Future setStatusOfAvilabilty({idOfDoc, setAvailabilitybyadmin}) async {
    var update = FirebaseFirestore.instance.collection('homeTwo')
        .doc(Number).collection('get').doc(idOfDoc);

    update.update({'availability': setAvailabilitybyadmin})
        .then((value) {
      //   emit(upDateMenuState());
    }).catchError((error) {
      print(error.toString());
      //   emit(upDateMenuErrorState());
    });
  }


  Stream<QuerySnapshot> getMyOrder() {
    return FirebaseFirestore.instance.collection('myOrders').snapshots();
  }

  Stream<QuerySnapshot> ListenAboutOrderIsOk() {
    return FirebaseFirestore.instance.collection('orderss').snapshots();
  }

  Future<void> update() async {
    FirebaseFirestore.instance.collection('orderss').snapshots();
    emit(updateState());
  }


  Future ShowDialogForSendNotification2blElTalab(BuildContext context,
      {id}) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("ارسال",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
      ),
      onPressed: () async {
        FoodCubitAdmin.get(context).getOsofUser(id).then((value) {
          FoodCubitAdmin.get(context).SendNotificationToSomeOne(
              content: ' الطلب بتاعك اتقبل وجاري تحضيره يا ${FoodCubitAdmin.get(context).name}',
              playerIds: ['${FoodCubitAdmin.get(context).osOfUser}'], heading: 'قصرالشام ');
        });
       await ConfirmOrder(id);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'تم الارسال بنجاح');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
      content: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("هل تريد ارسال الاشعار ؟",
            style: TextStyle(fontSize: 15.sp,)),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future ShowDialogForSendNotificationEb3tEltalab(BuildContext context,
      {id}) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("ارسال",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
      ),
      onPressed: () async {
        FoodCubitAdmin.get(context).getOsofUser(id).then((value) {
          FoodCubitAdmin.get(context).SendNotificationToSomeOne(
              content: ' الطلب بتاعك جاهز وخارج دلوقتي من المطعم يا ${FoodCubitAdmin
                  .get(context)
                  .name}', playerIds: ['${FoodCubitAdmin
              .get(context)
              .osOfUser}'
          ], heading: 'قصرالشام ');
        });
       await SendOrder(id);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'تم الارسال بنجاح');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
      content: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("هل تريد ارسال الاشعار ؟",
            style: TextStyle(fontSize: 15.sp,)),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future ShowDialogForSendNotificationMistakeOrder(BuildContext context,
      {id}) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("ارسال",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
      ),
      onPressed: () async {
        FoodCubitAdmin.get(context).getOsofUser(id).then((value) {
          FoodCubitAdmin.get(context).SendNotificationToSomeOne(
              content: ' لم يتم قبول الطلب من فضلك قم بارساله مره اخري ',
              playerIds: ['${FoodCubitAdmin
                  .get(context)
                  .osOfUser}'
              ],
              heading: 'قصرالشام ');
        });
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'تم الارسال بنجاح');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
      content: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("هل تريد ارسال الاشعار ؟",
            style: TextStyle(fontSize: 15.sp,)),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future setAdminOs() async {
    OneSignal.shared.getPermissionSubscriptionState().then((state) {
      DocumentReference ref = FirebaseFirestore.instance
          .collection('osOfAdmin')
          .doc('USuCyBQ4T4vv83JlPDAy');
      ref.update({
        'admin': state.subscriptionStatus.userId,
      }).then((value) {
        emit(updateOsOfAdmin());
      }).catchError((error) {
        print(error.toString());
        emit(updateOsOfAdminError());
      });
    });
  }

  Future SignUpshowAlertDialog(BuildContext context,) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء", style: TextStyle(fontSize: 15.sp),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("تسجيل الخروج", style: TextStyle(fontSize: 15.sp)),
      ),
      onPressed: () async {
        signOut().then((value) {
          NavigateAndFinsh(context, AdminLoginScreen());
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تسجيل الخروج ", style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
      content: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text(
            "هل تريد تسجيل الخروج ؟", style: TextStyle(fontSize: 14.sp)),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future ConfirmOrder(id) async
  {
    FirebaseFirestore.instance.collection('orderss').doc(id).update(
        {'confirmOrder': true});
  }

  Future SendOrder(id) async
  {
    FirebaseFirestore.instance.collection('orderss').doc(id).update(
        {'sendOrder': true});
  }
}