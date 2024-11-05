import 'package:currency_converter/utils/app_constants.dart';
import 'package:currency_converter/viewmodels/currency_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  const ErrorPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: Dimension.font20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Dimension.height15),
          ElevatedButton(
            onPressed: () => Provider.of<CurrencyViewModel>(context, listen: false).initData(),
            child: Text(
              "Retry",
              style: TextStyle(
                fontSize: Dimension.font20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
