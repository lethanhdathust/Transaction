import 'package:flutter/material.dart';
import 'package:second_app/widgets/chart.dart';
import 'modules/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helo mu baby',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ),
        fontFamily: "QuickSand",
        //? It is old version and i do not how to use this
        //       buttonTheme: ButtonThemeData(
        // buttonColor: Color(0xffff914d), // Background color (orange in my case).
        // textTheme: ButtonTextTheme.accent,
        // colorScheme:
        //   Theme.of(context).colorScheme.copyWith(secondary: Color.fromARGB(255, 60, 13, 13)), // Text color
// ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.black,
            ), //button color
            foregroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 252, 252, 252),
            ), //text (and icon)
          ),
        ),
        //colorScheme: ColorScheme(secondary: Colors.deepOrange,brightness: Brightness.light),
        //Some Widget will use accentColor first and use primarySwatch like insure
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              color: Color.fromARGB(255, 32, 72, 104),
              fontWeight: FontWeight.bold,
            ),
            labelMedium: TextStyle(
              color: Color.fromARGB(255, 91, 197, 156),
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 27, 40, 21),
            fontFamily: 'OpenSans',
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomeApp(),
    );
  }
}
// use

class MyHomeApp extends StatefulWidget {
  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  // String? titleInput;

  final List<Transaction> _userTramsaction = [
    //
    //  Transaction( id: 't1', title: "New Shoes", amount: 69.4, date: DateTime.now()),
    // Transaction(id: 't2', title: "Book", amount: 14.4, date: DateTime.now()),
  ];
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final List<Transaction> transactions = [];
  void _startAddNewTransaction(BuildContext ctx) {
    // to display a widget at the bottom and display when we tap a button
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransacton(_addNewTranscation),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTramsaction.removeWhere((tx) {
       return  tx.id == id;
      });
    });
  }

  void _addNewTranscation(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);
    setState(() {
      _userTramsaction.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTramsaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        //100px
        title: Text(
          "Helo mu baby",
          // style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: (() {
                _startAddNewTransaction(context);
              }),
              icon: Icon(Icons.add))
        ],
      ),
      // wrap the body with the SingleChildScrollView to scroll when the keyword override the title and amount
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Chart(_recentTransactions),
              TransactionList(_userTramsaction,_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
