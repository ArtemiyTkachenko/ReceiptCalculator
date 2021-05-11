import 'package:receipt_spliterator/data/receipt_header.dart';
import 'package:receipt_spliterator/data/user.dart';

class MergedRecipeDetails {
  final ProductItem details;
  final Items items;
  List<User> users = List<User>();

  MergedRecipeDetails(this.details, this.items);

  @override
  String toString() {
    return 'MergedRecipeDetails{details: $details, items: $items, users: $users}';
  }
}