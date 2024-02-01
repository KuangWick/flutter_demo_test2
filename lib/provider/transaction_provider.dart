import 'package:demo_test/db/transaction_db.dart';
import 'package:demo_test/model/transactions.dart';
import 'package:flutter/foundation.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction(){
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbName: "transaction.db");
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbName: "transaction.db");
    await db.insertData(statement);

    transactions = await db.loadAllData();
    notifyListeners();
  }
}
