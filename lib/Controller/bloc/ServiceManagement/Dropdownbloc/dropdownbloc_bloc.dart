import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'dropdownbloc_event.dart';
part 'dropdownbloc_state.dart';

class DropdownblocBloc extends Bloc<DropdownblocEvent, DropdownblocState> {
  DropdownblocBloc() : super(DropdownblocInitial()) {
    on<DropdownblocEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<Fetchcatogorybydropdown>((event, emit) async {
      try {
        emit(
            fetchcatogorydropdownloading()); // Emit loading state before fetching data

        await for (var snapshot in FirebaseFirestore.instance
            .collection('Service_Category')
            .where("service", isEqualTo: event.service)
            .snapshots()) {
          // Use a Set to avoid duplicate categories
          Set<String> domainSet =
              snapshot.docs.map((doc) => doc['category'] as String).toSet();

          List<String> uniqueDomain = domainSet.toList();

          print("Unique Domain: $uniqueDomain");

          if (!emit.isDone) {
            emit(catogoryLoadedDOMAIN(uniqueDomain));
          }
        }
      } catch (e) {
        if (!emit.isDone) {
          emit(FetchcatogotyError(e.toString()));
        }
      }
    });

    on<Fetchshopproductcatogory_inuser>((event, emit) async {
      try {
        emit(
            fetchcatogorydropdownloading()); // Emit loading state before fetching data

        await for (var snapshot in FirebaseFirestore.instance
            .collection('Shop_product')
            .where("service", isEqualTo: event.service)
            .where("shopid", isEqualTo: event.shopid)
            .snapshots()) {
          // Use a Set to avoid duplicate categories
          Set<String> domainSet =
              snapshot.docs.map((doc) => doc['category'] as String).toSet();

          List<String> uniqueDomain = domainSet.toList();

          print("Unique Domain: $uniqueDomain");

          if (!emit.isDone) {
            emit(catogoryLoadedDOMAIN(uniqueDomain));
          }
        }
      } catch (e) {
        if (!emit.isDone) {
          emit(FetchcatogotyError(e.toString()));
        }
      }
    });
  }
}
