import 'package:flutter/material.dart';
import '../modules/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions,this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 322,
        // if i size the height 322 , we can scroll inside of this 322px box.(SingleChillScrollView)

//ListView has an infinite height and Column takes all the height it can get =>
//=> There will be an error => Use container to set the height for the ListView
        child: transactions.isEmpty
            ? Center(
              child: Column(

                  children: [
                    Text(
                      "No transactions add yet!",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: 100,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          //fit the image to cover  the parent widget(container)
                          fit: BoxFit.fill,
                        )),
                  ],
                ),
            )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                                child:
                                    Text('\$${transactions[index].amount}'))),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: IconButton(
                          onPressed: () {deleteTransaction(transactions[index].id);},
                          icon: Icon(Icons.delete),
                          color: Colors.red),
                    ),
                  );
                },
              )
              );
  }
}
