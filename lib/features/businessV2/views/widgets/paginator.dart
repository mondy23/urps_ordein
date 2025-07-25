import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';

class Paginator extends StatelessWidget {
  const Paginator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ControllerBtn(
          child: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
          onTap: () {
            // your logic here
          },
        ),

        ControllerBtn(
          child: Text('1', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
          onTap: () {
            // your logic here
          },
        ),

        ControllerBtn(
          child: Text('2', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
          onTap: () {
            // your logic here
          },
        ),

         ControllerBtn(
          child: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white),
          onTap: () {
            // your logic here
          },
        ),
      ],
    );
  }
}

class ControllerBtn extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const ControllerBtn({super.key, required this.child, required this.onTap});

  @override
  State<ControllerBtn> createState() => _ControllerBtnState();
}

class _ControllerBtnState extends State<ControllerBtn> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap,
        hoverColor: backgroundColor,
        child: Container(
          margin: const EdgeInsets.all(4),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isHovered
                ? primaryColor.withOpacity(0.8)
                : const Color(0xffC8C8C8),
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
