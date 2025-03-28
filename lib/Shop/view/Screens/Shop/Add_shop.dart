import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/ServiceManagement/service_bloc.dart';
import 'package:laundry/Shop/view/Screens/Shop/view.dart';
import 'package:laundry/Widget/constands/Loading.dart';
import '../../../../Controller/bloc/ServiceManagement/Dropdownbloc/dropdownbloc_bloc.dart';
import '../../../../Controller/bloc/ServiceManagement/Shopadddproduct/Addproductmodel/Addproductmodel.dart';
import '../../../../Controller/bloc/ServiceManagement/Shopadddproduct/addproduct_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/colors.dart';

class Shop_Add extends StatefulWidget {
  @override
  _Shop_AddState createState() => _Shop_AddState();
}

class _Shop_AddState extends State<Shop_Add> {
  final List<Map<String, String>> services = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash + Fold"},
    {"icon": "assets/icon/wash_iron.png", "name": "Wash + Iron"},
    {"icon": "assets/icon/steam_iron.png", "name": "Steam Iron"},
    {"icon": "assets/icon/dry_clean.png", "name": "Dry Clean"},
    {"icon": "assets/icon/bag_service.png", "name": "Bag Service"},
    {"icon": "assets/icon/shoe_service.png", "name": "Shoe Service"},
    {"icon": "assets/icon/stain_removal.png", "name": "Stain Removal"},
    {"icon": "assets/icon/household_service.png", "name": "Household Service"},
  ];

  TextEditingController pricecontroller = TextEditingController();
  // String? selectedDCatogory;
  String? selectedImage; // Store selected image path
  String? selectedImagename; // Store selected image path
  String? selectedService;
  String? shopid;

  String? selectedCategory;

  _adddproduct() {
    var product = Addproductmodel(
        service: selectedService.toString(),
        category: selectedCategory.toString(),
        product_name: selectedImagename.toString(),
        product_image: selectedImage.toString(),
        shopid: shopid.toString(),
        Productprice: pricecontroller.text);
    context.read<AddproductBloc>().add(Addproductevent(model: product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ShopAuthblocBloc, ShopAuthblocState>(
              builder: (context, state) {
                if (state is Shoploading) {
                  return const Center(child: Loading_Widget());
                } else if (state is ShopByidLoaded) {
                  final shop = state.userData;
                  shopid = shop.shopid;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/shop_img/img3.png", height: 180),
                      SizedBox(height: 10),
                      Text('${shop.shop_name ?? ''}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("Laundry Capacity: ${shop.LaundryCapacity ?? ''} "),
                      Text("Owner: ${shop.owner_name ?? ''}"),
                      Text(
                          "Address: ${shop.District ?? ''}, ${shop.city ?? ''}, ${shop.post ?? ''}"),
                      SizedBox(height: 20),
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
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            items: shop.selectServices != null &&
                                    shop.selectServices!.isNotEmpty
                                ? shop.selectServices!.map((service) {
                                    return DropdownMenuItem(
                                      value: service,
                                      child: Text(service),
                                    );
                                  }).toList()
                                : [],
                            onChanged: (value) {
                              setState(() {
                                selectedService = value;
                                selectedCategory =
                                    null; // Reset category on service change

                                context.read<DropdownblocBloc>().add(
                                    Fetchcatogorybydropdown(
                                        service: selectedService));
                                selectedCategory = null;
                                context.read<ServiceBloc>().add(
                                    Fetchcatogoryimagesevent(
                                        searchQuery: null,
                                        Catogoty: selectedCategory,
                                        Servicetype: selectedService));
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
            SizedBox(height: 10),
            selectedService == null
                ? SizedBox()
                : BlocBuilder<DropdownblocBloc, DropdownblocState>(
                    builder: (context, state) {
                      if (state is fetchcatogorydropdownloading) {
                        return Loading_Widget();
                      } else if (state is FetchcatogotyError) {
                        return Center(child: Text(state.msg));
                      } else if (state is catogoryLoadedDOMAIN) {
                        return Container(
                          height: 50,
                          width: double.infinity, // Makes it responsive
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
                                    items: state.catogory.map((String place) {
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
                                        context.read<ServiceBloc>().add(
                                            Fetchcatogoryimagesevent(
                                                searchQuery: null,
                                                Catogoty: selectedCategory,
                                                Servicetype: selectedService));
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
            selectedCategory == null
                ? SizedBox()
                : Column(
                    children: [
                      SizedBox(height: 30),
                      Container(
                        height: 150,
                        color: Colors.grey.shade50,
                        child: BlocBuilder<ServiceBloc, ServiceState>(
                          builder: (context, state) {
                            if (state is CategoryLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is Categoryloadedimage) {
                              return state.images.isEmpty
                                  ? Center(child: Text("No images found"))
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 6,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: 1,
                                      ),
                                      itemCount: state.images.length,
                                      itemBuilder: (context, index) {
                                        String imageUrl =
                                            state.images[index]['image']!;
                                        String imageName =
                                            state.images[index]['name']!;

                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedImage =
                                                  imageUrl; // Update selected image
                                              selectedImagename = imageName;

                                              print(selectedImage);
                                              print(selectedImagename);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: selectedImage == imageUrl
                                                    ? Colors
                                                        .blue // Red border for selected image
                                                    : Colors.transparent,
                                                width: 3,
                                              ),
                                            ),
                                            child: Image.asset(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            }
                            return SizedBox();
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Text(selectedImagename ?? ""),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          controller: pricecontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Price for product",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BlocConsumer<AddproductBloc, AddproductState>(
          listener: (context, state) {
            if (state is Addproductsuccess) {
              Navigator.pop(context, true);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: _adddproduct,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state is AddproductLoading
                        ? Center(child: Loading_Widget())
                        : Text(
                            " Add Product ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                color: defaultColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
