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
            return viewmaterial.material_type!
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
            return viewinstruction.instruction_type!
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

    on<Fetchcatogoryimagesevent>((event, emit) async {
      emit(CategoryLoading());
      try {
        CollectionReference categoryCollection =
            FirebaseFirestore.instance.collection('Service_Category');

        Query query = categoryCollection;

        // Apply filters for service and category if they are not null or empty
        if (event.Servicetype != null && event.Servicetype!.isNotEmpty) {
          query = query.where('service', isEqualTo: event.Servicetype);
        }
        if (event.Catogoty != null && event.Catogoty!.isNotEmpty) {
          query = query.where('category', isEqualTo: event.Catogoty);
        }

        QuerySnapshot snapshot = await query.get();

        // Extract and store unique product image URLs and image names using a Set
        Set<String> uniqueImageNames = {}; // To track unique names

        List<Map<String, String>> imagesList = snapshot.docs
            .map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              String image = data['product_image']?.toString() ?? '';
              String name = data['product_name']?.toString() ?? '';

              // Ensure unique names
              if (!uniqueImageNames.contains(name)) {
                uniqueImageNames.add(name);
                return {'image': image, 'name': name};
              }
              return null;
            })
            .where((element) => element != null)
            .cast<Map<String, String>>()
            .toList();

        emit(Categoryloadedimage(images: imagesList));
      } catch (e) {
        emit(Categoryfailerror(e.toString()));
      }
    });

    on<DeleteCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
         FirebaseFirestore.instance
            .collection("Service_Category")
            .doc(event.id)
            .delete();
        emit(RefreshCategory());
      } catch (e) {
        emit(Categoryfailerror(e.toString()));
      }
    });
    on<DeleteMaterial>((event, emit) async {
      emit(Loading());
      try {
        FirebaseFirestore.instance
            .collection("MaterialTypes")
            .doc(event.id)
            .delete();
        emit(RefreshMaterial());
      } catch (e) {
        emit(failerror(e.toString()));
      }
    });
    on<DeleteInstruction>((event, emit) async {
      emit(InstructionLoading());
      try {
        FirebaseFirestore.instance
            .collection("Instruction_Types")
            .doc(event.id)
            .delete();
        emit(RefreshInstruction());
      } catch (e) {
        emit(Instructionfailerror(e.toString()));
      }
    });
    on<EditCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        FirebaseFirestore.instance
            .collection("Service_Category")
            .doc(event.category.category_id)
            .update({
          "product_name": event.category.product_name,
          "product_image": event.category.product_image,
          "service": event.category.service,
          "category": event.category.category,
        });
        emit(RefreshCategory());
      } catch (e) {
        emit(Categoryfailerror(e.toString()));
      }
    });

    on<EditMaterial>((event, emit) async {
      emit(Loading());
      try {
        FirebaseFirestore.instance
            .collection("MaterialTypes")
            .doc(event.cloth.material_id)
            .update({
          "material_name": event.cloth.material_name,
          "material_type": event.cloth.material_type,
        });
        emit(RefreshMaterial());
      } catch (e) {
        emit(failerror(e.toString()));
      }
    });

    on<EditInstruction>((event, emit) async {
      emit(InstructionLoading());
      try {
        FirebaseFirestore.instance
            .collection("Instruction_Types")
            .doc(event.instruction.instruction_id)
            .update({
          "instruction_name": event.instruction.instruction_name,
          "instruction_type": event.instruction.instruction_type,
        });
        emit(RefreshInstruction());
      } catch (e) {
        emit(Instructionfailerror(e.toString()));
      }
    });
  }
}
