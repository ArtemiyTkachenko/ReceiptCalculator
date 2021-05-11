import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipt_spliterator/bloc/detail_bloc.dart';
import 'package:receipt_spliterator/data/merged_recipe_details.dart';
import 'package:receipt_spliterator/data/receipt_details.dart';
import 'package:receipt_spliterator/data/receipt_header.dart';

import 'package:receipt_spliterator/data/user.dart';
import 'package:receipt_spliterator/data/user_owed_amount.dart';
import 'package:receipt_spliterator/ui/total.dart';
import 'package:receipt_spliterator/utils/number_utils.dart';

class DetailPage extends StatefulWidget {
  final DetailBloc bloc;

  DetailPage(this.bloc);

  @override
  _DetailPageState createState() => _DetailPageState(this.bloc);
}

class _DetailPageState extends State<DetailPage> {
  final DetailBloc bloc;

  List<DraggableItem> users = [];

  final GlobalKey _draggableKey = GlobalKey();

  _DetailPageState(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(16.0),
              child: InkWell(
                  onTap: () => {_calculateSum(context)},
                  child: Icon(Icons.calculate_rounded))),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                height: 100,
                child: users.isNotEmpty == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: users,
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    : Center(child: Text("Add users and drag them to items", style: TextStyle(fontSize: 20),))),
            Container(
              height: MediaQuery.of(context).size.height - 170,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: bloc.detailObservable,
                builder: (context,
                    AsyncSnapshot<List<MergedRecipeDetails>> snapshot) {
                  snapshot.data.length.toString();
                  if (snapshot.data == null) {
                    return Text("Oops");
                  }
                  return _buildList(snapshot.data, bloc);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        // onPressed: () => {addUser()},
        onPressed: () => {_showMyDialog()},
      ),
    );
  }

  Future<void> _showMyDialog() async {
    final TextEditingController _controller = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Добавить имя'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(controller: _controller),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Отмена',
                style: TextStyle(color: Colors.red.shade500),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Добавить'),
              onPressed: () {
                addUser(_controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildList(List<MergedRecipeDetails> list, DetailBloc bloc) {
    return SafeArea(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          if (list[index] == null) {
            return Text("Something went wrong");
          } else {
            final mergedItem = list[index];
            return DroppableReceiptItem(mergedItem, index.isEven, bloc);
          }
        },
      ),
    );
  }

  void addUser(String name) {
    setState(() {
      users = [
        ...users,
        DraggableItem(User(users.length, name, name[0]), _draggableKey)
      ];
    });
  }

  void _calculateSum(BuildContext context) {
    final allFilled = bloc.checkIfFilled();
    print("calculateSum clicked, and are allFilled " + allFilled.toString());
    if (!allFilled) return;
    final extractedUsers = users.map((e) => e.user).toList();
    List<UserOwedAmount> userOwedAmount = bloc.calculateAmounts(extractedUsers);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TotalPage(userOwedAmount),
        ));
  }
}

class DraggableItem extends StatelessWidget {
  final User user;
  final GlobalKey draggableKey;

  DraggableItem(this.user, this.draggableKey);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<User>(
      data: user,
      dragAnchor: DragAnchor.pointer,
      feedback: DraggingListItem(draggableKey, user),
      child: AvatarItem(user, 90),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  final GlobalKey dragKey;
  final User user;

  DraggingListItem(this.dragKey, this.user);

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          height: 100,
          width: 100,
          child: Opacity(
            opacity: 0.85,
            child: AvatarCircle(user, 90),
          ),
        ),
      ),
    );
  }
}

class AvatarItem extends StatelessWidget {
  final User user;
  final int size;

  AvatarItem(this.user, this.size);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0), child: AvatarCircle(user, size));
  }
}

class AvatarCircle extends StatelessWidget {
  final User user;
  final int size;

  AvatarCircle(this.user, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.toDouble(),
      height: size.toDouble(),
      decoration: new BoxDecoration(
        color: user.color,
        shape: BoxShape.circle,
      ),
      child: Center(child: Text(user.shortName)),
    );
  }
}

class DroppableReceiptItem extends StatefulWidget {
  final MergedRecipeDetails merged;
  final bool even;
  final DetailBloc bloc;

  DroppableReceiptItem(this.merged, this.even, this.bloc);

  @override
  State<StatefulWidget> createState() =>
      _DroppableReceiptItemState(merged, even, bloc);
}

class _DroppableReceiptItemState extends State<DroppableReceiptItem> {
  final MergedRecipeDetails merged;
  final bool even;
  final DetailBloc bloc;

  _DroppableReceiptItemState(this.merged, this.even, this.bloc);

  @override
  Widget build(BuildContext context) {
    return DragTarget<User>(
      builder: (context, candidateItems, rejectedItems) {
        // merged.users = _users;
        return RecieptItem(merged, even, 60);
      },
      onAccept: (item) {
        // setState(() {
        //   print("set state called");
        //   _users = [..._users, item];
        // });
        merged.users = [...merged.users, item];
        bloc.update(merged);
      },
    );
  }
}

class RecieptItem extends StatelessWidget {
  final MergedRecipeDetails merged;
  final bool even;
  final int size;

  RecieptItem(this.merged, this.even, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey.shade200)),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (merged.details.product != null &&
                      merged.details.product.properties != null &&
                      merged.details.product.properties.title != null)
                  ? merged.details.product.properties.title.trim()
                  : merged.items.name,
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Сумма: " + formatNumber(merged.items.sum),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Количество: " + merged.items.quantity.toInt().toString().trim(),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Цена за единицу: " + formatNumber(merged.items.price),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Container(
            height: 60,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: merged.users.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return AvatarItem(merged.users[index], size);
                }),
          )
        ],
      ),
    );
  }
}
