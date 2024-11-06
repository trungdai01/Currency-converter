import 'package:currency_converter/utils/app_constants.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: Dimension.height10),
          Text(
            "Getting ready",
            style: TextStyle(color: Colors.white, fontSize: Dimension.font24),
          ),
        ],
      ),
    );
  }
}
