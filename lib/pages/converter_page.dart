import 'package:currency_converter/utils/app_constants.dart';
import 'package:currency_converter/viewmodels/currency_view_model.dart';
import 'package:currency_converter/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var abbreviations = context.watch<CurrencyViewModel>().abbreviations;
    var baseCurrency = context.watch<CurrencyViewModel>().baseCurrency;
    var targetCurrency = context.watch<CurrencyViewModel>().targetCurrency;
    var exchangeRate = context.watch<CurrencyViewModel>().exchangeRate;
    var convertResult = context.watch<CurrencyViewModel>().convertResult;
    var inputValidate = context.watch<CurrencyViewModel>().isValidate;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter amount",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                      // errorText: inputValidate ? null : "Please enter a valid amount",
                    ),
                    onChanged: (value) {
                      context.read<CurrencyViewModel>().inputValidate(value);
                    },
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 15,
                    child: Text(
                      inputValidate ? "" : "Please enter a valid amount",
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0, top: 5),
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
                        items: abbreviations,
                        value: baseCurrency,
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
                        items: abbreviations,
                        value: targetCurrency,
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
                    "1 ${baseCurrency.toUpperCase()} = $exchangeRate ${targetCurrency.toUpperCase()}",
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
    );
  }
}
