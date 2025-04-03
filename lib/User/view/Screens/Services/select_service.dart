import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Shop_Auth_bloc/Shopmodel/Shopmodel.dart';
import 'package:laundry/User/view/Screens/Services/service.dart';
import '../../../../Controller/bloc/ServiceManagement/Dropdownbloc/dropdownbloc_bloc.dart';
import '../../../../Controller/bloc/ServiceManagement/Shopadddproduct/Addproductmodel/Addproductmodel.dart';
import '../../../../Controller/bloc/ServiceManagement/Shopadddproduct/addproduct_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../Address/pickup_delivery.dart';
import '../../../../Widget/constands/colors.dart';

class SelectService extends StatefulWidget {
  const SelectService(this.shop, {super.key});

  final ShopModel shop;

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  int selectedCategoryIndex = 0;
  String? selectedService;
  String? selectedCategory;
  Set<Addproductmodel> selectedItems = {};
  String? selectedFabricType;
  String? selectedInstruction;

  void updateSelectedItems(Addproductmodel item, {bool remove = false}) {
    setState(() {
      if (remove) {
        selectedItems.remove(item);
      } else {
        if (!selectedItems.contains(item)) {
          selectedItems.add(item);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Select a Service",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            //Navigator.pushReplacement(
            //  context, MaterialPageRoute(builder: (context) => Userservice()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Select Service Type",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  items: widget.shop.selectServices != null &&
                          widget.shop.selectServices!.isNotEmpty
                      ? widget.shop.selectServices!.map((service) {
                          return DropdownMenuItem(
                            value: service,
                            child: Text(service),
                          );
                        }).toList()
                      : [],
                  onChanged: (value) {
                    setState(() {
                      selectedService = value;

                      context.read<DropdownblocBloc>().add(
                          Fetchshopproductcatogory_inuser(
                              service: selectedService,
                              shopid: widget.shop.shopid));
                      selectedCategory = null;

                      // context.read<ServiceBloc>().add(Fetchcatogoryimagesevent(
                      //     searchQuery: null,
                      //     Catogoty: selectedCategory,
                      //     Servicetype: selectedService));
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            selectedService != null
                ? Column(
                    children: [
                      BlocBuilder<DropdownblocBloc, DropdownblocState>(
                        builder: (context, state) {
                          if (state is fetchcatogorydropdownloading) {
                            return Loading_Widget();
                          } else if (state is FetchcatogotyError) {
                            return Center(child: Text(state.msg));
                          } else if (state is catogoryLoadedDOMAIN) {
                            return Container(
                              height: 50,
                              width: double.infinity,
                              // Makes it responsive
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        style: TextStyle(color: Colors.black),
                                        dropdownColor: Colors.white,
                                        isExpanded: true,
                                        hint: Text(
                                          "Choose Category",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                        value: selectedCategory,
                                        items:
                                            state.catogory.map((String place) {
                                          return DropdownMenuItem<String>(
                                            value: place,
                                            child: Text(
                                              place,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCategory = newValue;
                                            context.read<AddproductBloc>().add(
                                                FetchproductinUser(
                                                    catogory: selectedCategory,
                                                    service: selectedService,
                                                    searchQuery: null,
                                                    shopid:
                                                        widget.shop.shopid));
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                      selectedCategory != null
                          ? Container(
                              height: 300,
                              color: Colors.white,
                              child:
                                  BlocConsumer<AddproductBloc, AddproductState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  if (state is AddproductLoading) {
                                    return Center(child: Loading_Widget());
                                  } else if (state is addproductfail) {
                                    return Text(state.error.toString());
                                  } else if (state is AddproductLoaded) {
                                    if (state.product.isEmpty) {
                                      // Return "No data found" if txhe list is empty
                                      return Center(
                                        child: Text(
                                          "No data found",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                      itemCount: state.product.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: Image.asset(
                                              state
                                                  .product[index].product_image,
                                              width: 40,
                                              height: 40),
                                          title: Text(state
                                              .product[index].product_name),
                                          subtitle: Text(
                                              "₹${state.product[index].Productprice}"),
                                          trailing: IconButton(
                                            icon: Icon(Icons.add_circle_outline,
                                                color: Colors.green),
                                            onPressed: () {
                                              updateSelectedItems(
                                                  state.product[index]);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return SizedBox();
                                },
                              ),
                            )
                          : SizedBox()
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 20),
            Expanded(child: _buildAddedItemsSection()),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        titlePadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add item",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon:
                                    Icon(Icons.close_sharp, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        content: Container(
                          height: 400,
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Material Type",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    hint: Text("Select Material"),
                                    value: selectedFabricType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedFabricType = value;
                                      });
                                    },
                                    items: ["Cotton", "Silk", "Wool"]
                                        .map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text("Special Instructions",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    hint: Text("Select Instructions"),
                                    value: selectedInstruction,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedInstruction = value;
                                      });
                                    },
                                    items: [
                                      "None",
                                      "Hand Wash",
                                      "Low Heat Dry",
                                      "Use Mild Detergent"
                                    ].map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 40),
                                  child: Text("Add item",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Cancel",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              );
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PickupDelivery(widget.shop, selectedItems);
                },
              ));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  " Continue ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            color: defaultColor,
          ),
        ),
      ),
    );
  }

  Widget _buildAddedItemsSection() {
    return ExpansionTile(
      title: Text("Added Items", style: TextStyle(fontWeight: FontWeight.bold)),
      initiallyExpanded: true, // This keeps the ExpansionTile open by default
      children: selectedItems.map((item) {
        return ListTile(
          leading: Image.asset(item.product_image, width: 40, height: 40),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.product_name),
              Text(item.Productprice),
              Text(
                item.category,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: () => updateSelectedItems(item, remove: true),
          ),
        );
      }).toList(),
    );
  }
}

//

// updateSelectedItems(
//     state.product[index]);
