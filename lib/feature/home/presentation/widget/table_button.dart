import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableButtonWidget extends StatelessWidget {
  const TableButtonWidget({
    super.key,
    required this.icon,
    required this.action,
    required this.backgroundColor,
    required this.iconColor,
  });

  final IconData icon;
  final Function() action;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(5),
        child: Icon(
          icon,
          size: 12,
          color: iconColor,
        ),
      ),
    );
  }
}
