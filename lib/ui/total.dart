import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipt_spliterator/data/user_owed_amount.dart';
import 'package:receipt_spliterator/utils/number_utils.dart';

class TotalPage extends StatelessWidget {
  final List<UserOwedAmount> userOwedAmount;

  TotalPage(this.userOwedAmount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total"),
      ),
      body:
      Center(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: userOwedAmount.length,
            itemBuilder: (BuildContext context, int index) {
              if (userOwedAmount.length == 0) {
                return Text("Something went wrong");
              }
              return OwedItem(userOwedAmount[index]);
            },
          )),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text("Total is ${userOwedAmount.fold(0, (previousValue, element) => previousValue + element.amount)}"),
      // ),
    );
  }
}

class OwedItem extends StatelessWidget {
  final UserOwedAmount amount;

  OwedItem(this.amount);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: amount.user.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${amount.user.name}", style: TextStyle(fontSize: 30.0, color: Colors.white),),
                Text("Сумма: ${formatNumber(amount.amount.toInt())}", style: TextStyle(fontSize: 20.0, color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
