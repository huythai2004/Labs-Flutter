import 'package:flutter/material.dart';
import 'package:lab8bflutter/model/exchange_rate.dart';
import 'package:lab8bflutter/services/currency_services.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {

  final CurrencyService services = CurrencyService();
  late Future<ExchangeRate> exchangeRates;

  final TextEditingController controller = TextEditingController();
  String result = "";

  @override
  void initState() {
    super.initState();
    exchangeRates = services.fetchRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Currency Converter")),
      body: FutureBuilder<ExchangeRate>(
        future: exchangeRates,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No data"));
          }

          final data = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Enter amount in USD",
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {

                    double usd =
                        double.tryParse(controller.text) ?? 0;

                    double rate =
                    (data.rates["VND"] ?? 0).toDouble();

                    double vnd = usd * rate;

                    setState(() {
                      result =
                      "$usd USD = ${vnd.toStringAsFixed(2)} VND";
                    });

                  },
                  child: const Text("Convert"),
                ),

                const SizedBox(height: 20),

                Text(
                  result,
                  style: const TextStyle(fontSize: 20),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}