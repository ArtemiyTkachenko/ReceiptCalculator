import 'package:receipt_spliterator/data/merged_recipe_details.dart';
import 'package:receipt_spliterator/data/user.dart';
import 'package:receipt_spliterator/data/user_owed_amount.dart';
import 'package:rxdart/rxdart.dart';


class DetailBloc {

  List<MergedRecipeDetails> _list = [];

  BehaviorSubject<List<MergedRecipeDetails>> _detailsSubject;

  DetailBloc(List<MergedRecipeDetails> details) {
    _list = details;
    _detailsSubject = BehaviorSubject<List<MergedRecipeDetails>>.seeded(_list);
  }

  Stream<List<MergedRecipeDetails>> get detailObservable => _detailsSubject.stream;

  void dispose() {
    _detailsSubject.close();
  }

  void update(MergedRecipeDetails details) {
    final index = _list.indexOf(details);
    _list[index] = details;
    assert(_list[index] == details, "Item should be the same!");
    _detailsSubject.sink.add(_list);
  }

  bool checkIfFilled() {
    bool areAllFilled = true;
    _list.forEach((element) {
      if (element.users.isEmpty) {
        print("from check is filled ");
        areAllFilled = false;
      }
    });
    return areAllFilled;
  }

  List<UserOwedAmount> calculateAmounts(List<User> users) {
    List<UserOwedAmount> owedAmount = List<UserOwedAmount>();
    users.forEach((user) {
      final userOwnedAmount = UserOwedAmount(user);
      _list.forEach((details) {
        if (details.users.contains(userOwnedAmount.user)) {
          userOwnedAmount.amount += (details.items.sum / details.users.length);
        }
      });
      if (userOwnedAmount.amount > 0) {
        owedAmount.add(userOwnedAmount);
      }
    });
    return owedAmount;
  }
}