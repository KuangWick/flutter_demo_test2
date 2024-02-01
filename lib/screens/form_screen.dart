import 'package:demo_test/main.dart';
import 'package:demo_test/provider/transaction_provider.dart';
import 'package:demo_test/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/transactions.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Colors.purple[300],
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Platform save information"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Title"),
                  autofocus: false,
                  controller: titleController,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return "Please enter title name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "amount"),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (str) {
                    if (str!.isEmpty) {
                      return "Please enter your amount";
                    }
                    if (double.parse(str) <= 0) {
                      return "Please enter your number much than 0";
                    }
                    return null;
                  },
                ),
                TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var title = titleController.text;
                        var amount = amountController.text;

                        Transactions statement = Transactions(
                            title: title,
                            amount: double.parse(amount),
                            date: DateTime.now());

                        var provider = Provider.of<TransactionProvider>(context,
                            listen: false);
                        provider.addTransaction(statement);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return const MyHomePage(title: 'Account User');
                                }));
                      }
                    },
                    style: raisedButtonStyle,
                    child: const Text("Add information"))
              ],
            ),
          ),
        ));
  }
}
