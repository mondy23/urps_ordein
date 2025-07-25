import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/widgets/side_menu_widget.dart';

class MainPage extends StatefulWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isMenuVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (isMenuVisible)
              Expanded(
                flex: 2,
                child: SideMenuWidget(),
              ),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(isMenuVisible ? Icons.arrow_back : Icons.menu),
                          onPressed: () {
                            setState(() {
                              isMenuVisible = !isMenuVisible;
                            });
                          },
                        ),
                        const Text(
                          'Dashboard',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: isMenuVisible
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(left: 100, right: 100, top: 24, bottom: 24),
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
