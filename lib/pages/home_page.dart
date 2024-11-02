import 'package:currency_converter/services/api_client.dart';
import 'package:currency_converter/utils/app_constants.dart';
import 'package:currency_converter/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiClient apiClient = ApiClient();
  List<String> currencies = [];
  String fromCurrency = "usd";
  String toCurrency = "eur";

  double changeRate = 0.0;
  double total = 0.0;
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    (() async {
      List<String> currencyList = await getCurrencyList();
      var rate = await getRate(fromCurrency, toCurrency);
      setState(() {
        currencies = currencyList;
        changeRate = rate;
      });
    })();
  }

  Future<List<String>> getCurrencyList() async {
    return await apiClient.getCurrencies();
  }

  Future<double> getRate(String fromCurrency, String toCurrency) async {
    return await apiClient.getRate(fromCurrency, toCurrency);
  }

  void _swapCurrencies() async {
    String temp = fromCurrency;
    setState(() {
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
    double rate = await getRate(fromCurrency, toCurrency);
    setState(() => changeRate = rate);
    if (amountController.text != '') {
      double amount = double.parse(amountController.text);
      setState(() => total = amount * changeRate);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    labelText: "Input amount to convert",
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
                  onChanged: (value) {
                    if (value != '') {
                      double amount = double.parse(value);
                      setState(() => total = amount * changeRate);
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
                      currencies,
                      fromCurrency,
                      (newValue) async {
                        setState(() => fromCurrency = newValue!);
                        double rate = await getRate(fromCurrency, toCurrency);
                        setState(() => changeRate = rate);
                      },
                    ),
                    IconButton(
                      onPressed: _swapCurrencies,
                      icon: const Icon(
                        Icons.swap_horiz,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    CustomDropdown(
                      currencies,
                      toCurrency,
                      (newValue) async {
                        setState(() => toCurrency = newValue!);
                        double rate = await getRate(fromCurrency, toCurrency);
                        setState(() => changeRate = rate);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Rate $changeRate",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                total.toStringAsFixed(3),
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
