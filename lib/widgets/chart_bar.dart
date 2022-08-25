import 'package:flutter/material.dart';

class CharBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  CharBar(this.label, this.spendingAmount, this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    print(spendingAmount);
    return Column(
      children: [
        Container(
          height: 20,
            child: FittedBox(
                child: Text(' \$${spendingAmount.toStringAsFixed(0)} '))),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctOfTotal,
              child: Container(
                  decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              )),
            ) // heightfactor: 1 => 60px (equal to height of the surround  widget (container) , 0 => equal to 0
          ]),
        ),
        SizedBox(
          height: 4,
        ),
        Text('${label}'),
      ],
    );
  }
}
