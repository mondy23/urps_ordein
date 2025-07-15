import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';

class SearchWithBotton extends StatelessWidget {
  final String btnName;
  final IconData icon;
  final Color searchBgColor;

  const SearchWithBotton({
    super.key,
    required this.btnName,
    required this.icon,
    required this.searchBgColor,
  });

  @override
  Widget build(BuildContext context) {
    // Mock business list
    final businesses = ['All', 'Business A', 'Business B', 'Business C'];
    String selectedBusiness = 'All';

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Search box
        Container(
          width: 260,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: searchBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search, color: Colors.grey),
              hintText: 'Search...',
              border: InputBorder.none,
              isDense: true,
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),

        SizedBox(width: 8,),

        // Business filter dropdown
        Container(
          width: 180,
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: StatefulBuilder(
              builder: (context, setState) {
                return DropdownButton<String>(
                  value: selectedBusiness,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white,),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedBusiness = newValue;
                      });
                    }
                  },
                  items: businesses.map((String business) {
                    return DropdownMenuItem<String>(
                      value: business,
                      child: Text(business),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),

        Spacer(),

        // Export button
        Container(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(btnName, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
