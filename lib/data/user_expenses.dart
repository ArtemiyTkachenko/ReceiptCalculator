import 'dart:ui';

import 'package:receipt_spliterator/utils/color_generator.dart';

class UserExpenses {

  String userName;
  String productName;
  int sum;
  double quantity;
  int productId;
  Color color = generateColor();

  UserExpenses(this.userName, this.productName, this.sum, this.quantity, this.productId);
}