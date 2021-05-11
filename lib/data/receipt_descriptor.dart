class ReceiptDescriptor {

  String qrCode;
  String status;
  String data;
  bool isDummy;

  ReceiptDescriptor(this.qrCode, this.status, this.data, {this.isDummy});

  ReceiptDescriptor.fromJson(Map<String, dynamic> json) :
      qrCode = json['qrcode'],
      status = json['status_fns'],
      data = json['data'],
      isDummy = json['is_dummy'];

  Map<String, dynamic> toJson() => {
      'qrcode': qrCode,
      'status_fns': status,
      'data': data,
      'is_dummy': this.isDummy
  };
}