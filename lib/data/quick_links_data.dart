import 'package:flutter/material.dart';
import 'package:urps_ordein/models/quick_links_model.dart';

class QuickLinksData {
  final data = <QuickLinksModel>[
    QuickLinksModel(icon: Icons.add, title: 'Create New Business'),
    QuickLinksModel(icon: Icons.remove_red_eye, title: 'View All Transactions'),
    QuickLinksModel(icon: Icons.settings, title: 'API Key Management'),
  ];
}