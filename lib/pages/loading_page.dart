import 'dart:developer';

import 'package:currency_converter/utils/app_constants.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    log("${Dimension.screenHeight} ${Dimension.screenWidth}");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: Dimension.height15),
          Text(
            "Getting ready",
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimension.font20,
            ),
          ),
        ],
      ),
    );
  }
}
