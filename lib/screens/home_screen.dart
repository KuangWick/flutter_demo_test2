import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/transactions.dart';
import '../provider/transaction_provider.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget? widget) {
            var count = provider.transactions.length;
            if (count <= 0) {
              return const Center(
                child: Text(
                  "Nothing other information",
                  style: TextStyle(fontSize: 30),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: FittedBox(
                            child: Text(
                              NumberFormat.currency(locale: "en_US")
                                  .format(data.amount),
                            ),
                          ),
                        ),
                        title: Text(data.title),
                        subtitle:
                            Text(DateFormat("dd/MM/yyyy").format(data.date)),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
