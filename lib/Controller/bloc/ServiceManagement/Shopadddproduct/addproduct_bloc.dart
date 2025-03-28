import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'Addproductmodel/Addproductmodel.dart';

part 'addproduct_event.dart';
part 'addproduct_state.dart';

class AddproductBloc extends Bloc<AddproductEvent, AddproductState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

    on<FetchProduct>((event, emit) async {
      emit(AddproductLoading());
      User? shop = _auth.currentUser;
      if (shop != null) {
        try {
          CollectionReference productCollection =
              FirebaseFirestore.instance.collection('Shop_product');

          QuerySnapshot snapshot = await productCollection
              .where("shopid", isEqualTo: shop.uid)
              .get();

          List<Addproductmodel> product = snapshot.docs.map((doc) {
            return Addproductmodel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
            product = product.where((viewshops) {
              return viewshops.Productprice!
                  .toLowerCase()
                  .contains(event.searchQuery!.toLowerCase());
            }).toList();
          }
          emit(AddproductLoaded(product));
        } catch (e) {
          emit(addproductfail(error: e.toString()));
        }
      }
    });

    on<FetchproductinUser>((event, emit) async {
      emit(AddproductLoading());


        try {
          CollectionReference productCollection =
              FirebaseFirestore.instance.collection('Shop_product');

          QuerySnapshot snapshot = await productCollection
              .where("shopid", isEqualTo:event.shopid)
              .get();

          List<Addproductmodel> product = snapshot.docs.map((doc) {
            return Addproductmodel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
            product = product.where((viewshops) {
              return viewshops.Productprice!
                  .toLowerCase()
                  .contains(event.searchQuery!.toLowerCase());
            }).toList();
          }
          emit(AddproductLoaded(product));
        } catch (e) {
          emit(addproductfail(error: e.toString()));
        }

    });
    on<DeleteProduct>((event, emit) async {
      emit(AddproductLoading());
      try {
        FirebaseFirestore.instance
            .collection("Shop_product")
            .doc(event.productid)
            .delete();
        emit(ProductDelete());
      } catch (e) {
        print(e);
      }
    });
  }
}
