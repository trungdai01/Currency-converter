import 'package:currency_converter/services/api_client.dart';
import 'package:currency_converter/utils/app_constants.dart';
import 'package:currency_converter/providers/currency_provider.dart';
import 'package:currency_converter/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<CurrencyProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    var listCurrencies = context.watch<CurrencyProvider>().currencies;
    var fromCurrency = context.watch<CurrencyProvider>().fromCurrency;
    var toCurrency = context.watch<CurrencyProvider>().toCurrency;
    var exchangeRate = context.watch<CurrencyProvider>().exchangeRate;
    var convertResult = context.watch<CurrencyProvider>().convertResult;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Currency Converter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Image.asset(
                  'assets/images/main_icon.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Amount",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      double amount = double.parse(value);
                      context.read<CurrencyProvider>().computeResult(amount);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomDropdown(
                      items: context.watch<CurrencyProvider>().currencies,
                      value: fromCurrency,
                      onChanged: (newValue) => context.read<CurrencyProvider>().convertFrom(newValue!),
                    ),
                    IconButton(
                      onPressed: context.read<CurrencyProvider>().swapCurrencies,
                      icon: const Icon(
                        Icons.swap_horiz,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    CustomDropdown(
                      items: listCurrencies,
                      value: toCurrency,
                      onChanged: (newValue) => context.read<CurrencyProvider>().convertTo(newValue!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Rate $exchangeRate",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                convertResult.toStringAsFixed(3),
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
