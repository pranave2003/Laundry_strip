import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'Service_Model/Category_Model.dart';
import 'Service_Model/Instruction_Model.dart';
import 'Service_Model/Material_Model.dart';

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
    on<FetchMaterial>((event, emit) async {
      emit(InstructionLoading());
      try {
        CollectionReference MaterialCollection =
        FirebaseFirestore.instance.collection('MaterialTypes');

        Query query = MaterialCollection;
        QuerySnapshot snapshot = await query.get();

        List<MaterialModel> cloth = snapshot.docs.map((doc) {
          return MaterialModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          cloth = cloth.where((viewmaterial) {
            return viewmaterial.material_name!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Materialloaded(cloth));
      } catch (e) {
        emit(failerror(e.toString()));
      }
    });


    on<InstructionAddEvent>(
      (event, emit) async {
        emit(Loading());
        try {
          var orderRef = FirebaseFirestore.instance
              .collection("Instruction_Types")
              .doc(); // Generate ID
          String Instructionid = orderRef.id; // Get the generated ID

          await orderRef.set({
            "instruction_id": Instructionid,
            "instruction_type": event.instruction.instruction_type,
            "instruction_name": event.instruction.instruction_name
          });

          emit(InstructionSuccess());
        } catch (e) {
          emit(Instructionfailerror(e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );


    on<FetchInstruction>((event, emit) async {
      emit(InstructionLoading());
      try {
        CollectionReference InstructionCollection =
        FirebaseFirestore.instance.collection('Instruction_Types');

        Query query = InstructionCollection;
        QuerySnapshot snapshot = await query.get();

        List<InstructionModel> instruction = snapshot.docs.map((doc) {
          return InstructionModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          instruction = instruction.where((viewinstruction) {
            return viewinstruction.instruction_name!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Instructionloaded(instruction));
      } catch (e) {
        emit(Instructionfailerror(e.toString()));
      }
    });

///////
    on<CategoryAddEvent>(
          (event, emit) async {
        emit(CategoryLoading());
        try {
          var orderRef = FirebaseFirestore.instance
              .collection("Service_Category")
              .doc(); // Generate ID
          String categoryid = orderRef.id; // Get the generated ID

          await orderRef.set({
            "category_id": categoryid,
            "service": event.category.service,
            "category": event.category.category,
            "product_name": event.category.product_name,
            "product_image": event.category.product_image
          });

          emit(CategorySuccess());
        } catch (e) {
          emit(Categoryfailerror(e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );


    on<FetchCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        CollectionReference CategoryCollection =
        FirebaseFirestore.instance.collection('Service_Category');

        Query query = CategoryCollection;
        QuerySnapshot snapshot = await query.get();

        List<CategoryModel> category = snapshot.docs.map((doc) {
          return CategoryModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          category = category.where((viewcategory) {
            return viewcategory.service!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Categoryloaded(category));
      } catch (e) {
        emit(Categoryfailerror(e.toString()));
      }
    });

    on<DeleteCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        FirebaseFirestore.instance.collection("Service_Category").doc(event.id).delete();
        emit(RefreshCategory());
      } catch (e) {
        emit(Categoryfailerror(e.toString()));
      }
    });
    on<DeleteMaterial>((event, emit) async {
      emit(Loading());
      try {
        FirebaseFirestore.instance.collection("MaterialTypes").doc(event.id).delete();
        emit(RefreshMaterial());
      } catch (e) {
        emit(failerror(e.toString()));
      }
    });
    on<DeleteInstruction>((event, emit) async {
      emit(InstructionLoading());
      try {
        FirebaseFirestore.instance.collection("Instruction_Types").doc(event.id).delete();
        emit(RefreshInstruction());
      } catch (e) {
        emit(Instructionfailerror(e.toString()));
      }
    });

  }
}
