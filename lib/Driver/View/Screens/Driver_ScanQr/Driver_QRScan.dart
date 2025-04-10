import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../Btm_Nav/Driver_Btm_Nav.dart';

// import 'package:url_launcher/url_launcher.dart';

class DriverScanQr extends StatefulWidget {
  const DriverScanQr({super.key});

  @override
  State<DriverScanQr> createState() => _DriverScanQrState();
}

class _DriverScanQrState extends State<DriverScanQr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String scannedData = "";

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blurred Background Image
          ImageFiltered(
            imageFilter:
                ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust blur intensity
            child: Image.asset(
              "assets/scanner/qrimageblur.png", // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // QR Scanner
          // QRView(
          //   key: qrKey,
          //   onQRViewCreated: _onQRViewCreated,
          //   overlay: QrScannerOverlayShape(
          //     borderColor: Colors.white,
          //     borderRadius: 12,
          //     borderLength: 30,
          //     borderWidth: 8,
          //     cutOutSize: 250,
          //   ),
          // ),

          // Blurred Background Overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // Centered QR Code with Text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Instruction Text
                const Text(
                  "Scan the QR code to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const Text(
                  "complete the delivery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),

                // QR Code Placeholder (Optional)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            "assets/scanner/qr.png",
                            // Update with actual QR image path
                            height: 180,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Scan Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Page2();
                      },
                    ));
                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  label: const Text("Scan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool _hasPermission = false;
  String _barcodeData = '';

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      setState(() {
        _hasPermission = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please turn on permission in settings'),
          backgroundColor: Colors.red, // optional
          duration: Duration(seconds: 3), // optional
        ),
      );
    }
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    setState(() {
      if (capture.barcodes.isNotEmpty) {
        _barcodeData = capture.barcodes.first.rawValue ?? "No Data Found";
      }
    });
  }

  // Future<void> _launchURL(String url) async {
  //   Uri uri = Uri.parse(url);
  //   // if (await canLaunchUrlString(url)) {
  //   launchUrl(uri, mode: LaunchMode.externalApplication);
  //   // } else {
  //   //   Get.snackbar('Error', 'Could not launch $url');
  //   //   print('Could not launch $url');
  //   // }
  // }

  // Future<void> testLaunch() async {
  //   const url = 'https://www.google.com';
  //   Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     print("Could not launch $url");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Colors.transparent,
      body: Center(
        child: _hasPermission
            ? _barcodeData.isEmpty
                ? SizedBox(
                    width: 300,
                    height: 300,
                    child: MobileScanner(onDetect: _onBarcodeDetected),
                  )
                : BlocProvider(
                    create: (context) => OrderBloc()
                      ..add(FetchOrderDetailsById(orderid: _barcodeData)),
                    child: BlocConsumer<OrderBloc, OrderState>(
                      listener: (context, state) {
                        if (state is Scannersuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeliverySuccessPage(),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is orderloadingbyid) {
                          return const Center(child: Loading_Widget());
                        } else if (state is Ordererror) {
                          return Center(
                            child: Text(
                              state.error.toString(),
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (state is OrderByidLoaded) {
                          final order = state.order;

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "Order Update",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Order Details Card
                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildInfoRow("Order ID",
                                            order.orderid.toString()),
                                        _buildInfoRow("Username",
                                            order.username.toString()),
                                        _buildInfoRow("Shop Name",
                                            order.shopname.toString()),
                                        _buildInfoRow(
                                            "Amount", "₹ ${order.Totalcharge}"),
                                        _buildInfoRow("Status", order.status),
                                        _buildInfoRow(
                                            "Order Date", order.Orderdate),
                                        _buildInfoRow(
                                            "Pickup Date", order.pickupdate),
                                        _buildInfoRow(
                                            "Pickup Time", order.pickupTime),
                                        _buildInfoRow("Delivery Date",
                                            order.Deliverydate),
                                        _buildInfoRow("Delivery Time",
                                            order.DeliveryTime),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30),

                                // Delivery Button
                                BlocConsumer<OrderBloc, OrderState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (order.PIckup == "0") {
                                          context.read<OrderBloc>().add(
                                                Deliverd_scann_event(
                                                    orderid: _barcodeData,
                                                    picked: "1",
                                                    Deliverd: "0"),
                                              );
                                        } else if (order.Delivered == "0") {
                                          context.read<OrderBloc>().add(
                                                Deliverd_scann_event(
                                                    orderid: _barcodeData,
                                                    Deliverd: "1",
                                                    picked: "1"),
                                              );
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        decoration: BoxDecoration(
                                          color: order.PIckup == "0"
                                              ? Colors.blue
                                              : Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: state is scanndeliverdLoading
                                              ? const Loading_Widget()
                                              : order.PIckup == "0"
                                                  ? Text(
                                                      "Mark as Piked",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  : Text(
                                                      "Mark as Delivered",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  )
            : const Text(
                'Camera permission is required to scan QR codes.',
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$title:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class DeliverySuccessPage extends StatefulWidget {
  const DeliverySuccessPage({super.key});

  @override
  State<DeliverySuccessPage> createState() => _DeliverySuccessPageState();
}

class _DeliverySuccessPageState extends State<DeliverySuccessPage> {
  int _countdown = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
        _navigateToNextPage();
      }
    });
  }

  void _navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const DriverBottomNavWrapper()), // Replace with your actual page
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
              const SizedBox(height: 20),
              const Text(
                'Successfully Completed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your item has been delivered.\nThank you for shopping with us!',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                'Redirecting in $_countdown seconds...',
                style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy HomePage
