import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/utils/app_constants.dart';
import 'package:currency_converter/viewmodels/currency_view_model.dart';
import 'package:currency_converter/widgets/custom_drop_down.dart';

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
    Provider.of<CurrencyViewModel>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    var listCurrencies = context.watch<CurrencyViewModel>().currencies;
    var fromCurrency = context.watch<CurrencyViewModel>().fromCurrency;
    var toCurrency = context.watch<CurrencyViewModel>().toCurrency;
    var exchangeRate = context.watch<CurrencyViewModel>().exchangeRate;
    var convertResult = context.watch<CurrencyViewModel>().convertResult;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Currency Converter",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //   Padding(
              //     padding: const EdgeInsets.all(40),
              //     child: Image.asset(
              //       'assets/images/main_icon.png',
              //       width: MediaQuery.of(context).size.width / 2,
              //     ),
              //   ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter Amount",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          double amount = double.parse(value);
                          context.read<CurrencyViewModel>().setNewAmount(amount);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "From",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        CustomDropdown(
                          items: listCurrencies,
                          value: fromCurrency,
                          onChanged: (newValue) => context.read<CurrencyViewModel>().convertFrom(newValue!),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(""),
                        const SizedBox(height: 5),
                        IconButton(
                          onPressed: context.read<CurrencyViewModel>().swapCurrencies,
                          icon: const Icon(
                            Icons.swap_horiz,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("To", style: TextStyle(fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 5),
                        CustomDropdown(
                          items: listCurrencies,
                          value: toCurrency,
                          onChanged: (newValue) => context.read<CurrencyViewModel>().convertTo(newValue!),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CurrencyViewModel>().computeResult();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    backgroundColor: AppColors.secondColor,
                  ),
                  child: const Text(
                    "Convert",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "1 ${fromCurrency.toUpperCase()} = $exchangeRate ${toCurrency.toUpperCase()}",
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
            ],
          ),
        ),
      ),
    );
  }
}
