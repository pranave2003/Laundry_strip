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
  List<String> categories = ["All", "Men", "Women", "Kids", "Household"];

  Map<String, List<Map<String, dynamic>>> categoryItems = {
    "All": [
      {
        "name": "Shirt Full Standard Pack",
        "price": 80,
        "icon": "assets/Dress/shirt.png"
      },
      {
        "name": "T-Shirt Full Standard Pack",
        "price": 100,
        "icon": "assets/Dress/t-shirt.png"
      },
      {
        "name": "Jacket Standard Pack",
        "price": 200,
        "icon": "assets/Dress/jacket.png"
      },
      {"name": "T-Shirt", "price": 150, "icon": "assets/Dress/wmtshirt.png"},
      {"name": "Gown", "price": 150, "icon": "assets/Dress/wmgown.png"},
      {
        "name": "Baby Clothes Pack",
        "price": 120,
        "icon": "assets/Dress/frock.png"
      },
      {"name": "Carpet", "price": 250, "icon": "assets/Dress/carpet.png"},
    ],
    "Men": [
      {
        "name": "Shirt Full Standard Pack",
        "price": 80,
        "icon": "assets/Dress/shirt.png"
      },
      {
        "name": "T-Shirt Full Standard Pack",
        "price": 100,
        "icon": "assets/Dress/t-shirt.png"
      },
      {
        "name": "Jacket Standard Pack",
        "price": 200,
        "icon": "assets/Dress/jacket.png"
      },
    ],
    "Women": [
      {"name": "T-Shirt", "price": 100, "icon": "assets/Dress/wmtshirt.png"},
      {"name": "Gown", "price": 150, "icon": "assets/Dress/wmgown.png"},
    ],
    "Kids": [
      {"name": "Frock", "price": 120, "icon": "assets/Dress/frock.png"},
      {
        "name": "Flared Frock",
        "price": 60,
        "icon": "assets/Dress/flared_frock.png"
      },
    ],
    "Household": [
      {"name": "Carpet", "price": 250, "icon": "assets/Dress/carpet.png"},
      {"name": "Curtains", "price": 300, "icon": "assets/Dress/curtain.png"},
    ],
  };

  List<Map<String, dynamic>> displayedItems = [];

  @override
  void initState() {
    super.initState();
    displayedItems = List.from(categoryItems["All"]!);
  }

  void updateCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
      displayedItems = List.from(categoryItems[categories[index]]!);
    });
  }

  Set<Addproductmodel> selectedItems = {};

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
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PickupDelivery();
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
      appBar: AppBar(
        title: Text("Select a Service",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Service()));
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
            // _buildCategoryFilter(),
            SizedBox(height: 20),
            // Expanded(child: _buildServiceItemList(displayedItems)),
            Expanded(child: _buildAddedItemsSection()),
          ],
        ),
      ),
    );
  }

  // Widget _buildCategoryFilter() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       children: List.generate(categories.length, (index) {
  //         return GestureDetector(
  //           onTap: () => updateCategory(index),
  //           child: Container(
  //             margin: EdgeInsets.only(right: 10),
  //             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
  //             decoration: BoxDecoration(
  //               color:
  //                   selectedCategoryIndex == index ? Colors.blue : Colors.white,
  //               borderRadius: BorderRadius.circular(8),
  //               border: Border.all(color: defaultColor),
  //             ),
  //             child: Text(categories[index],
  //                 style: TextStyle(
  //                   color: selectedCategoryIndex == index
  //                       ? Colors.white
  //                       : Colors.blue,
  //                   fontWeight: FontWeight.bold,
  //                 )),
  //           ),
  //         );
  //       }),
  //     ),
  //   );
  // }
  //
  // Widget _buildServiceItemList(List<Map<String, dynamic>> items) {
  //   return ListView.builder(
  //     itemCount: items.length,
  //     itemBuilder: (context, index) {
  //       var item = items[index];
  //       return ListTile(
  //         leading: Image.asset(item["icon"], width: 40, height: 40),
  //         title: Text(item["name"]),
  //         subtitle: Text("₹ ${item["price"]}"),
  //         trailing: IconButton(
  //           icon: Icon(Icons.add_circle_outline, color: Colors.green),
  //           onPressed: () => updateSelectedItems(item),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildServiceItemList(List<Map<String, dynamic>> items) {
  //   return ListView.builder(
  //     itemCount: items.length,
  //     itemBuilder: (context, index) {
  //       var item = items[index];
  //       return ListTile(
  //         leading: Image.asset(item["icon"], width: 40, height: 40),
  //         title: Text(item["name"]),
  //         subtitle: Text("₹ ${item["price"]}"),
  //         trailing: IconButton(
  //           icon: Icon(Icons.add_circle_outline, color: Colors.green),
  //           onPressed: () {
  //             var product = Addproductmodel(
  //               product_image: item["icon"],
  //               product_name: item["name"],
  //               Productprice: item["price"],
  //             );
  //             updateSelectedItems(product);
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildAddedItemsSection() {
    return ExpansionTile(
      title: Text("Added Items", style: TextStyle(fontWeight: FontWeight.bold)),
      initiallyExpanded: true, // This keeps the ExpansionTile open by default
      children: selectedItems.map((item) {
        return ListTile(
          leading: Image.asset(item.product_image, width: 40, height: 40),
          title: Text(item.product_name),
          trailing: IconButton(
            icon: Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: () => updateSelectedItems(item, remove: true),
          ),
        );
      }).toList(),
    );
  }
}
