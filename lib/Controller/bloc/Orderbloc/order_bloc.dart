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
          'status': event.order.status,
          'orderDate': event.order.Orderdate,
          "shopid": event.order.shopid,
          "shopname": event.order.shopname,
          "pickupdate": event.order.pickupdate,
          "pickupTime": event.order.pickupTime,
          "Deliverydate": event.order.Deliverydate,
          "DeliveryTime": event.order.DeliveryTime,
          "timestamp": DateTime.now().toString()
        });

        emit(orderSuccess());
      } catch (e) {
        emit(orderFailure(e.toString()));
      }
    });

    on<Fetchorders>((event, emit) async {
      emit(orderfetchloading());
      try {
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('Orders');

        Query query = usersCollection;
        QuerySnapshot snapshot = await query.get();

        List<OrderModel> users = snapshot.docs.map((doc) {
          return OrderModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          users = users.where((viewuser) {
            return viewuser.shopname!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }
        print(users.toString());
        emit(orderloaded(users));
      } catch (e) {
        emit(Order_fetch_failerror(e.toString()));
      }
    });
  }
}
