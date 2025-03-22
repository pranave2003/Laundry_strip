import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'InstructionModel/Bag_Instruction_Model.dart';
import 'MaterialModel/Material_Model.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    on<MaterialAddevent>(
      (event, emit) async {
        emit(Loading());
        try {
          var orderRef = FirebaseFirestore.instance
              .collection("MaterialTypes")
              .doc(); // Generate ID
          String Materialid = orderRef.id; // Get the generated ID

          await orderRef.set({
            "material_id": Materialid,
            "material_type": event.cloth.material_type,
            "material_name": event.cloth.material_name
          });

          emit(meterialSuccess());
        } catch (e) {
          emit(failerror(e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );
  }
}
