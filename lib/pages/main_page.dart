import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/widgets/side_menu_widget.dart';

class MainPage extends StatelessWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(flex: 2, child: SideMenuWidget()),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                      border: Border.all(color: borderColor),
                    ),
                  ),
                  Expanded(flex: 9, child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
