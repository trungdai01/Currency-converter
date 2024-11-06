import 'package:currency_converter/utils/app_constants.dart';
import 'package:currency_converter/viewmodels/currency_view_model.dart';
import 'package:currency_converter/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  late TextEditingController amountController;
  final resultFormat = NumberFormat("#,##0.000", "en_US");
  final rateFormat = NumberFormat("#,##0.##########", "en_US");

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimension.height15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(Dimension.height10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter amount",
                      style: TextStyle(color: Colors.white, fontSize: Dimension.font18),
                    ),
                    SizedBox(height: Dimension.height5),
                    TextFormField(
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimension.font24,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimension.radius5),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimension.radius5),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      onChanged: (value) => context.read<CurrencyViewModel>().inputValidate(value),
                    ),
                    SizedBox(height: Dimension.height5),
                    SizedBox(
                      height: Dimension.height15 + Dimension.height5,
                      child: Text(
                        inputValidate ? "" : "Please enter a valid amount",
                        style: TextStyle(color: Colors.redAccent, fontSize: Dimension.font16),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: Dimension.height10,
                  right: Dimension.height10,
                  left: Dimension.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From",
                          style: TextStyle(color: Colors.white, fontSize: Dimension.font18),
                        ),
                        SizedBox(height: Dimension.height5),
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
                        SizedBox(height: Dimension.height5),
                        IconButton(
                          onPressed: context.read<CurrencyViewModel>().swapCurrencies,
                          icon: Icon(
                            Icons.swap_horiz,
                            size: Dimension.font40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "To",
                          style: TextStyle(color: Colors.white, fontSize: Dimension.font18),
                        ),
                        SizedBox(height: Dimension.height5),
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
              SizedBox(height: Dimension.height40),
              Container(
                width: double.infinity,
                height: Dimension.height40 + Dimension.height10,
                padding: EdgeInsets.symmetric(horizontal: Dimension.height10),
                child: ElevatedButton(
                  onPressed: () => context.read<CurrencyViewModel>().computeResult(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimension.radius5)),
                    backgroundColor: AppColors.secondColor,
                  ),
                  child: Text(
                    "Convert",
                    style: TextStyle(fontSize: Dimension.font30, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: Dimension.height40),
              Padding(
                padding: EdgeInsets.all(Dimension.radius8),
                child: Column(
                  children: [
                    Text(
                      "1 ${baseCurrency.toUpperCase()} = ${rateFormat.format(exchangeRate)} ${targetCurrency.toUpperCase()}",
                      style: TextStyle(color: Colors.white, fontSize: Dimension.font20),
                    ),
                    SizedBox(height: Dimension.height10 * 2),
                    Text(
                      resultFormat.format(convertResult),
                      style: TextStyle(color: Colors.greenAccent, fontSize: Dimension.font40),
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
