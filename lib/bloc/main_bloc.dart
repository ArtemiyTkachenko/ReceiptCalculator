import 'package:receipt_spliterator/api/receipt_api.dart';
import 'package:receipt_spliterator/data/receipt_header.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {

  BehaviorSubject<MainState> _headerSubject;

  ReceiptApi _api;

  MainBloc() {
    _api = ReceiptApi();
    _headerSubject = BehaviorSubject<MainState>.seeded(MainState.base());
  }

  Stream<MainState> get receiptHeaderObservable => _headerSubject.stream;

  void dispose() {
    _headerSubject.close();
  }

  void resetState() {
    _headerSubject.sink.add(MainState.base());
  }

  void getQrCode(String qrCode) async {
    final result = await _api.getQrCodeInfo(qrCode);
    if (result == null) {
      _headerSubject.sink.add(MainState.error("Something went wrong"));
    } else {
      _headerSubject.sink.add(MainState.success(result));
    }
  }
}

class MainState {
  MainState._();

  factory MainState.success(ReceiptHeader header) = SuccessState;
  factory MainState.error(String errorText) = ErrorState;
  factory MainState.base() = BaseState;
}

class ErrorState extends MainState {
  ErrorState(this.msg): super._();

  final String msg;
}

class SuccessState extends MainState {
  SuccessState(this.value): super._();

  final ReceiptHeader value;
}

class BaseState extends MainState {
  BaseState(): super._();
}