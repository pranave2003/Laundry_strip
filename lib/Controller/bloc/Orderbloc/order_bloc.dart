import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'OrderModel/Order_Model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  OrderBloc() : super(OrderInitial()) {
    on<placeorder>((event, emit) async {
      emit(orderverLoading());
      try {
        DocumentReference docRef = firestore.collection('Orders').doc();

        await docRef.set({
          'orderId': docRef.id,
          'userId': event.order.userid,
          'username': event.order.username,
          'items': event.order.items.map((item) => item.toJson()).toList(),
          'totalAmount': event.order.Totalcharge,
          'status': "0",
          'Delivered': "0",
          'orderDate': event.order.Orderdate,
          "shopid": event.order.shopid,
          "shopname": event.order.shopname,
          "pickupdate": event.order.pickupdate,
          "pickupTime": event.order.pickupTime,
          "Deliverydate": event.order.Deliverydate,
          "DeliveryTime": event.order.DeliveryTime,
          "timestamp": DateTime.now().toString(),
          "deliveryaddress": event.order.deliveryaddress,
          "Driverid": "",
          "Drivername": "",
          "Drivernumber": "",
          "PIckup": "0",
          "Rejectreason": "",
          "Rejected": "0",
          "workinprogress": "0",
          "Review": event.order.Review,
          "Ratingstatus": event.order.Ratingstatus,
        });

        emit(orderSuccess());
      } catch (e) {
        print(e);
        emit(orderFailure(e.toString()));
      }
    });

    on<Fetchorders>((event, emit) async {
      emit(orderfetchloading());
      print("datassss ${event.driverId.toString()}");
      try {
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('Orders');

        Query query = usersCollection;
        query = query.where("shopid", isEqualTo: event.shopid);
        query = query.where("userId", isEqualTo: event.userid);
        query = query.where("Driverid", isEqualTo: event.driverId);
        query = query.where("PIckup", isEqualTo: event.Picked);
        if (event.status != null) {
          query = query.where("status", isEqualTo: event.status);
        }
        if (event.Rejected != null) {
          query = query.where("Rejected", isEqualTo: event.Rejected);
        }
        if (event.Deliverd != null) {
          query = query.where("Delivered", isEqualTo: event.Deliverd);
        }

        QuerySnapshot snapshot = await query.get();

        List<OrderModel> product = snapshot.docs.map((doc) {
          return OrderModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          product = product.where((viewuser) {
            return viewuser.shopname!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(OrderLoaded(product));
      } catch (e) {
        emit(OrderFailure(e.toString()));
      }
    });

    on<FetchOrderDetailsById>((event, emit) async {
      emit(orderloadingbyid());

      try {
        final doc = await FirebaseFirestore.instance
            .collection('Orders')
            .doc(event.orderid)
            .get();

        print("Document fetched");

        if (doc.exists && doc.data() != null) {
          OrderModel userData = OrderModel.fromMap(doc.data()!);
          print("userData: $userData");
          emit(OrderByidLoaded(userData));
        } else {
          emit(Ordererror(error: "please Recheck"));
        }
      } catch (e) {
        print(e);
        emit(Ordererror(error: e.toString()));
      }
    });

    on<Acceptorderevent>((event, emit) async {
      emit(ActionLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .update({"status": event.status});

        emit(orderRefresh());
      } catch (e) {
        print(e);
        emit(OrderFailure(e.toString()));
      }
    });

    on<Updateworkingprogress>((event, emit) async {
      emit(ActionLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .update({"workinprogress": event.Progress});

        emit(orderRefresh());
      } catch (e) {
        print(e);
        emit(OrderFailure(e.toString()));
      }
    });

    on<DeliverdUpdate>((event, emit) async {
      emit(ActionLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .update({"Delivered": event.Deliverd});

        emit(orderRefresh());
      } catch (e) {
        print(e);
        emit(OrderFailure(e.toString()));
      }
    });

    on<pickupdelivery>((event, emit) async {
      emit(ActionLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .update({"PIckup": event.pickup});

        emit(orderRefresh());
      } catch (e) {
        print(e);
        emit(OrderFailure(e.toString()));
      }
    });

    on<Assigndriver>((event, emit) async {
      emit(ActionLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .update({
          "Driverid": event.driverid,
          "Drivername": event.drivername,
          "Drivernumber": event.drivernumber,
          "PIckup": event.PIckup
        });

        emit(orderRefresh());
      } catch (e) {
        print(e);
        emit(OrderFailure(e.toString()));
      }
    });

    on<Deliverd_scann_event>((event, emit) async {
      emit(scanndeliverdLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .update(
          {"Delivered": event.Deliverd, "PIckup": event.picked},
        );

        emit(Scannersuccess());
      } catch (e) {
        emit(Deliverderror(error: e.toString()));
      }
    });
    // on<UserSendreviewandratingevent>((event, emit) async {
    //   emit(UserSendreviewandratingloading());
    //   try {
    //     // Simulate or call your actual API/repository function
    //     await Future.delayed(Duration(seconds: 1)); // simulate delay
    //     // Replace with your logic like: await orderRepo.sendReview(event)
    //
    //     emit(UserSendreviewandratingSuccess());
    //   } catch (e) {
    //     emit(UserSendreviewandratingfailerror(e.toString()));
    //   }
    // });

    on<UserSendreviewandratingevent>((event, emit) async {
      emit(UserSendreviewandratingloading());

      try {
        if (event.orderid == null ||
            event.Review == null ||
            event.Ratingstatus == null) {
          emit(UserSendreviewandratingfailerror('Missing fields'));
          return;
        }

        await FirebaseFirestore.instance
            .collection(
                'Orders') // <- Make sure you save under the correct collection
            .doc(event.orderid) // <- Save inside a document for that order
            .update(
          {
            'orderid': event.orderid,
            'Review': event.Review,
            'Ratingstatus': event.Ratingstatus,
            //'timestamp': FieldValue.serverTimestamp(),
          },
        ); // Merge if order already exists

        emit(UserSendreviewandratingSuccess());
      } catch (e) {
        emit(UserSendreviewandratingfailerror(e.toString()));
      }
    });


    on<FetchUserFeedbackEvent>((event, emit) async {
      emit(UserFeedbackLoading());
      try {
        final feedbackData = await _fetchFeedback(event.orderid); // Fetch feedback data

        if (feedbackData == null) {
          emit(UserFeedbackError('No feedback found for this order.'));
        } else {
          // Check if feedback fields exist before using them
          final rating = feedbackData['Ratingstatus'] ?? '';
          final review = feedbackData['Review'] ?? '';

          if (rating.isEmpty && review.isEmpty) {
            emit(UserFeedbackError('No review or rating available.'));
          } else {
            emit(UserFeedbackLoaded(
              rating: rating,
              review: review,
            ));
          }
        }
      } catch (e) {
        // Catch any exception during the fetch process
        emit(UserFeedbackError('Error fetching feedback: ${e.toString()}'));
      }
    });

    // on<FetchUserFeedbackEvent>((event, emit) async {
    //   emit(UserFeedbackLoading());
    //   try {
    //     final feedbackData =
    //         await _fetchFeedback(event.orderid); // ✅ Now will work fine
    //
    //     if (feedbackData == null) {
    //       emit(UserFeedbackError('No feedback found'));
    //     } else {
    //       emit(UserFeedbackLoaded(
    //         rating: feedbackData['Ratingstatus'] ?? '',
    //         review: feedbackData['Review'] ?? '',
    //       ));
    //     }
    //   } catch (e) {
    //     emit(UserFeedbackError(e.toString()));
    //   }
    // });

  }

  // ✅ Move _fetchFeedback outside constructor but inside class
  Future<Map<String, dynamic>?> _fetchFeedback(String orderId) async {
    final doc = await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderId)
        .get();
    if (doc.exists) {
      return doc.data();
    }
    return null;
  }
}
