import 'dart:ffi';

class ReceiptDetails {
  String qrCode;
  String status;
  // String data;
  bool isDummy;
  String iin;
  Double sum;
  String time;
  String shopName;
  String cashback;

  ReceiptDetails(this.qrCode, this.status, this.isDummy, this.iin, this.sum, this.time, this.shopName, this.cashback);


  ReceiptDetails.fromJson(Map<String, dynamic> json)
      : qrCode = json['qrcode'],
        status = json['status_fns'],
        // data = json['data'],
        isDummy = json['is_dummy'],
        iin = json['iin'],
        sum = json['sum'],
        time = json['time'],
        shopName = json['shop_name'],
        cashback = json['cashback'];

  Map<String, dynamic> toJson() => {
        'qrcode': qrCode,
        'status_fns': status,
        // 'data': data,
        'is_dummy': this.isDummy,
        'iin': iin,
        'sum': sum,
        'time': time,
        'shop_name': shopName,
        'cashback': cashback
      };
}
