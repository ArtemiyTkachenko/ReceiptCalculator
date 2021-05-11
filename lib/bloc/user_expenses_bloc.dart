import 'package:receipt_spliterator/data/merged_recipe_details.dart';
import 'package:receipt_spliterator/data/user_expenses.dart';
import 'package:rxdart/rxdart.dart';

class UserExpensesBloc {

  List<UserExpenses> _list = [];

  BehaviorSubject<List<UserExpenses>> _detailsSubject;

  UserExpensesBloc() {
    _detailsSubject = BehaviorSubject<List<UserExpenses>>.seeded(_list);
  }

  Stream<List<UserExpenses>> get detailObservable => _detailsSubject.stream;

  void dispose() {
    _detailsSubject.close();
  }

  void add(UserExpenses userExpenses) {
    _list.add(userExpenses);
    _detailsSubject.sink.add(_list);
  }
}