import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'Addproductmodel/Addproductmodel.dart';

part 'addproduct_event.dart';
part 'addproduct_state.dart';

class AddproductBloc extends Bloc<AddproductEvent, AddproductState> {
  AddproductBloc() : super(AddproductInitial()) {
    on<Addproductevent>((event, emit) async {
      emit(AddproductLoading());
      try {
        var orderRef = FirebaseFirestore.instance
            .collection("Shop_product")
            .doc(); // Generate ID
        String productid = orderRef.id; // Get the generated ID
        await orderRef.set({
          "productid": productid,
          "service": event.model.service,
          "category": event.model.category,
          "product_name": event.model.product_name,
          "product_image": event.model.product_image,
          "shopid": event.model.shopid,
          "Productprice": event.model.Productprice,
        });

        emit(Addproductsuccess());
      } catch (e) {
        emit(addproductfail(error: e.toString()));
      }
    });
  }
}
