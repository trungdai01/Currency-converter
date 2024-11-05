import 'package:currency_converter/pages/converter_page.dart';
import 'package:currency_converter/pages/error_page.dart';
import 'package:currency_converter/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/utils/app_constants.dart';
import 'package:currency_converter/viewmodels/currency_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CurrencyViewModel>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<CurrencyViewModel>();

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: data.isLoading || (data.errorCode != null)
          ? null
          : AppBar(
              backgroundColor: AppColors.mainColor,
              foregroundColor: Colors.white,
              title: Center(
                child: Text(
                  "Currency Converter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimension.font36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            // If the app is loading, show the loading page.
            // If the app has an error, display the error page.
            // Otherwise, show the converter.
            if (data.isLoading) {
              return const LoadingPage();
            } else if (data.errorCode != null) {
              return ErrorPage(message: data.errorCode!);
            } else {
              return const ConverterPage();
            }
          },
        ),
      ),
    );
  }
}
