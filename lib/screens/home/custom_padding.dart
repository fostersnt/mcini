// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:mcini/utilities/app_colors.dart';

class CustomPadding extends StatelessWidget {
  final Size screenSize;
  final String category;
  const CustomPadding({
    super.key,
    required this.screenSize,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Text(
          category,
          style: TextStyle(
            color: AppColors.blueColor,
            fontSize: screenSize.width * 0.05,
          ),
        ),
      ),
    );
  }
}
