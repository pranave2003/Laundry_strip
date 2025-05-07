import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:laundry/Controller/bloc/ServiceManagement/Shopadddproduct/Addproductmodel/Addproductmodel.dart';
import 'package:laundry/Controller/bloc/Shop_Auth_bloc/Shopmodel/Shopmodel.dart';
import 'package:laundry/Widget/constands/Loading.dart';
import 'package:laundry/Widget/constands/colors.dart';
import '../../../../Controller/bloc/Authbloc/Userauthmodel/Usermodel.dart';
import '../../../../Controller/bloc/Authbloc/auth_bloc.dart';
import '../Orders/order_summary.dart';

class PickupDelivery extends StatefulWidget {
  PickupDelivery(this.shop, this.selectedItems, {super.key});
  final ShopModel shop;
  Set<Addproductmodel> selectedItems;
  @override
  State<PickupDelivery> createState() => _PickupDeliveryState();
}

class _PickupDeliveryState extends State<PickupDelivery> {
  DateTime? _pickupDate;
  DateTime? _deliveryDate;
  String? _selectedTimeSlot;
  String? _selectedDeliveryTimeSlot;
  String _selectedAddress = "Home";

  final List<String> _timeSlots = [
    "9:00 am to 10:00 am",
    "10:00 am to 11:00 am",
    "11:00 am to 12:00 am",
    "12:00 am to 1:00 pm",
    "1:00 pm to 2:00 pm",
    "2:00 pm to 3:00 pm",
    "3:00 pm to 4:00 pm",
    "4:00 pm to 5:00 pm",
  ];

  Future<void> _selectDate(BuildContext context, bool isPickupDate) async {
    DateTime initialDate = isPickupDate
        ? (_pickupDate ?? DateTime.now())
        : (_deliveryDate ?? DateTime.now().add(const Duration(days: 4)));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isPickupDate) {
          _pickupDate = picked;
        } else {
          _deliveryDate = picked;
        }
      });
    }
  }

  void _validateAndProceed() {
    if (_pickupDate == null ||
        _deliveryDate == null ||
        _selectedTimeSlot == null ||
        _selectedDeliveryTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select all required fields."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSummaryPage(
            shop: widget.shop,
            widget.selectedItems,
            pickupdate: DateFormat("dd/MM/yyyy").format(_pickupDate!),
            deliveryDate: DateFormat("dd/MM/yyyy").format(_deliveryDate!),
            selectedDeliveryTimeSlot: _selectedDeliveryTimeSlot,
            selectedTimeSlot: _selectedTimeSlot,
            Userid: userid,
            username: username,

            address: address),
      ),
    );
  }

  String? userid;
  String? username;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Pickup and Delivery Address {}",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Type Selection (Radio Buttons + Add Address Button)

            Row(
              children: [
                _buildRadioButton("Home"),
              ],
            ),
            const SizedBox(height: 12),

            // Address Details
            // Address Details
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Userloading) {
                  return const Center(child: Loading_Widget());
                } else if (state is UserByidLoaded) {
                  final user = state.Userdata;
                  userid = user.uid;
                  username = user.name;
                  address =
                      "${user.name}, ${user.place}, ${user.District}, ${user.state}, ${user.post}, ${user.pin}, ${user.phone}";

                  return Container(
                    width: double.infinity, // This ensures it takes full width
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user.name} (Home)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${user.name}, ${user.state}, ${user.District}, ${user.place}, ${user.pin}",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Phone:  ${user.phone}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),

            const SizedBox(height: 26),

            // Date Pickers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDatePicker("Select Pickup Date", _pickupDate, true),
                const SizedBox(
                  width: 8,
                ),
                _buildDatePicker("Expect Delivery Date", _deliveryDate, false),
              ],
            ),
            const SizedBox(height: 26),

            // Time Slot Selection
            const Text(
              "Pickup Time Slot",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Time Slots
            Wrap(
              spacing: 20.0,
              runSpacing: 8.0,
              children: _timeSlots.map((slot) {
                return _buildTimeSlotButton(slot);
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Delivery Time Slot",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Time Slots
            Wrap(
              spacing: 20.0,
              runSpacing: 8.0,
              children: _timeSlots.map((slot) {
                return _buildDeliveryTimeSlotButton(slot);
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),

            // Continue Button
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: MaterialButton(
                onPressed: _validateAndProceed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Continue ",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                color: defaultColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Address Radio Button
  Widget _buildRadioButton(String text) {
    return Expanded(
      child: Row(
        children: [
          Radio(
            value: text,
            groupValue: _selectedAddress,
            onChanged: (value) {
              setState(() {
                _selectedAddress = value.toString();
              });
            },
            activeColor: Secondary,
          ),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // Widget for Date Picker
  Widget _buildDatePicker(String label, DateTime? date, bool isPickupDate) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => _selectDate(context, isPickupDate),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date != null
                        ? DateFormat("dd/MM/yyyy").format(date)
                        : "--/--/----",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Icon(Icons.calendar_today,
                      size: 18, color: Colors.blue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Time Slot Button
  Widget _buildTimeSlotButton(String timeSlot) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeSlot = timeSlot;
        });
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              _selectedTimeSlot == timeSlot ? Secondary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            timeSlot,
            style: TextStyle(
              color:
                  _selectedTimeSlot == timeSlot ? Colors.white : Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryTimeSlotButton(String timeSlot) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDeliveryTimeSlot = timeSlot;
        });
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _selectedDeliveryTimeSlot == timeSlot
              ? Secondary
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            timeSlot,
            style: TextStyle(
              color: _selectedDeliveryTimeSlot == timeSlot
                  ? Colors.white
                  : Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
