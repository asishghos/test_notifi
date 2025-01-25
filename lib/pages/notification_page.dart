import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    // Retrieve the message passed as arguments
    final message =
        ModalRoute.of(context)?.settings.arguments as RemoteMessage?;

    // Check if the message is null
    if (message == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Notification"),
        ),
        body: const Center(
          child: Text(
            "No notification data available.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    // Extract notification details
    final title = message.notification?.title ?? "No Title";
    final body = message.notification?.body ?? "No Body";
    final data = message.data.isNotEmpty ? message.data.toString() : "No Data";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification title
            _buildSectionHeader("Title"),
            _buildSectionContent(title),
            const SizedBox(height: 16),

            // Notification body
            _buildSectionHeader("Body"),
            _buildSectionContent(body),
            const SizedBox(height: 16),

            // Notification data
            _buildSectionHeader("Data"),
            _buildSectionContent(data),
          ],
        ),
      ),
    );
  }

  // Helper to build section headers
  Widget _buildSectionHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      ),
    );
  }

  // Helper to build section content
  Widget _buildSectionContent(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }
}
