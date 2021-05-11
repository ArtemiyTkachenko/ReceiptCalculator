import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:receipt_spliterator/data/receipt_descriptor.dart';
import 'package:receipt_spliterator/data/receipt_header.dart';

import '../interceptor.dart';

class ReceiptApi {

  ReceiptApi();

  Future<ReceiptHeader> getQrCodeInfo(String qrCode) async {
    try {
      ReceiptDescriptor descriptor =
      ReceiptDescriptor(qrCode, "new", null, isDummy: false);

      Dio dio = Dio();
      dio.interceptors.add(LoggingInterceptor());
      String token = "?access_token=ruxzl3gnb87urhh591ht1x1cnuyp2pnv";
      String url = "https://cat.ratengoods.com/api/v0.10/user/me/receipt/$token";
      print("url is $url");

      String body = jsonEncode(descriptor);

      print(body);

      Response response = await Dio().post(url, data: body);
      final header = parseHeaderResponse(response);
      return header;
    } catch (e) {
      print(e);
    }
  }

  ReceiptHeader parseHeaderResponse(Response<dynamic> response) {
    final parsed = jsonDecode(response.toString());
    ReceiptHeader header = ReceiptHeader.fromJson(parsed);
    return header;
  }
}