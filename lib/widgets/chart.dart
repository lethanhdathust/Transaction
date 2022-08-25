import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/modules/transaction.dart';
import 'chart_bar.dart';

// Return the recentTransaction ,the day and the amount of the day
class Chart extends StatelessWidget {
  final List<Transaction> recentTransacations;
  Chart(this.recentTransacations);

  // Create a list has 7 elements which each element is a object  
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransacations.length; i++) {
        if (recentTransacations[i].date.day == weekDay.day &&
            recentTransacations[i].date.month == weekDay.month &&
            recentTransacations[i].date.year == weekDay.year) {
          totalSum += recentTransacations[i].amount;
        }
      }
      return {
        'day': DateFormat.EEEE().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }
// Return the total spending
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double ) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // iterate through the list and return 7 Charbar
          children: groupedTransactionValues.map((e) {
            return 
            Flexible(
              fit: FlexFit.tight,
              child: CharBar(e['day'] as String, e['amount'] as double,
                 totalSpending == 0 ? 0.0 :  ( (e['amount'] as double) / totalSpending) ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
