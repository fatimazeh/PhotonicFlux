import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String description;
  final DateTime timestamp;
  final IconData icon;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    this.isRead = false,
  });
}
