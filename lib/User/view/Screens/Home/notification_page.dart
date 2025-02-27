import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      "date": "Today Jan 22",
      "items": [
        {
          "title": "Special Offer",
          "message": "Exciting news! We’re offering special offer ....",
          "time": "6:30 PM"
        },
        {
          "title": "Order In Progress",
          "message": "Good news! Your order #ADG789O789 is .....",
          "time": "8:25 AM"
        },
      ]
    },
    {
      "date": "Yesterday Jan 21",
      "items": [
        {
          "title": "Parcel Picked Up",
          "message": "Your order #ADG789O789 has been picked ....",
          "time": "5:30 PM"
        },
      ]
    },
    {
      "date": "Jan 20",
      "items": [
        {
          "title": "Today’s Deal",
          "message": "Exclusive for today only! Get 50% off on our ....",
          "time": "12:30 PM"
        },
        {
          "title": "Order Confirmed",
          "message": "Hi Kavya, your order #ADG789O789 is ....",
          "time": "10:20 AM"
        },
        {
          "title": "Special Discount",
          "message": "Use code #AS34 at checkout to enjoy 20% ....",
          "time": "10:00 AM"
        },
        {
          "title": "Don’t Forget Your Order",
          "message": "You left something behind! Complete your ....",
          "time": "07:10 AM"
        },

      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Notifications", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final section = notifications[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section["date"],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 10),
              ...List.generate(section["items"].length, (i) {
                final notification = section["items"][i];
                return _buildNotificationCard(notification);
              }),
              SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, String> notification) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50], // Light blue background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification["title"]!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 4),
                Text(
                  notification["message"]!,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Text(
            notification["time"]!,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
