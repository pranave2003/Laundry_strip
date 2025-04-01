import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          "workinprogress": "0"
        });

        emit(orderSuccess());
      } catch (e) {
        print(e);
        emit(orderFailure(e.toString()));
      }
    });

    on<Fetchorders>((event, emit) async {
      emit(orderfetchloading());

      try {
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('Orders');

        Query query = usersCollection;
        query = query.where("status", isEqualTo: event.status);
        query = query.where("shopid", isEqualTo: event.shopid);
        query = query.where("Rejected", isEqualTo: event.Rejected);
        query = query.where("Delivered", isEqualTo: event.Deliverd);
        QuerySnapshot snapshot = await query.get();
        print("fetch order");
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
  }
}
