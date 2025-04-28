import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../Bottom_navigation/btm_navigation.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({
    super.key,

    required this.orderid,
    required this.userName,
  });


  final String orderid;
  final String userName;

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String Ratingstatus = "0";
  TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Feedback",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/feedback.png',
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              "Share Your Feedback",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Please let us know about your experience",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 20),
            Text(
              "Give us your Order Feedback",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      Ratingstatus = (index + 1).toString();
                    });
                  },
                  icon: Icon(
                    index < int.parse(Ratingstatus) ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                );
              }),
            ),
            Text(
              "Rating: $Ratingstatus / 5",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Write your feedback (Optional)",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Please write here",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is UserSendreviewandratingSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavWrapper()),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (Ratingstatus == "0") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please give a rating")),
                        );
                      } else {
                        context.read<OrderBloc>().add(
                          UserSendreviewandratingevent(
                            orderid: widget.orderid,
                            Review: feedbackController.text,
                            Ratingstatus: Ratingstatus,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: state is UserSendreviewandratingloading
                        ? Loading_Widget()
                        : const Text(
                      "Submit",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
