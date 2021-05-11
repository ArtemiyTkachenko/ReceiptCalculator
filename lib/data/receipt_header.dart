class ReceiptHeader {
  int id;
  String qrcode;
  String statusFns;
  Data data;
  bool isDummy;
  String inn;
  String sum;
  String time;
  Products products;
  String shopName;
  String shopNameShort;
  int userMatchValue;
  String cashback;

  ReceiptHeader(
      {this.id,
      this.qrcode,
      this.statusFns,
      this.data,
      this.isDummy,
      this.inn,
      this.sum,
      this.time,
      this.products,
      this.shopName,
      this.shopNameShort,
      this.userMatchValue,
      this.cashback});

  ReceiptHeader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qrcode = json['qrcode'];
    statusFns = json['status_fns'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    isDummy = json['is_dummy'];
    inn = json['inn'];
    sum = json['sum'];
    time = json['time'];
    final jsonProducts = json['products'];
    products =
        jsonProducts != null ? new Products.fromJson(jsonProducts) : null;
    shopName = json['shop_name'];
    shopNameShort = json['shop_name_short'];
    userMatchValue = json['user_match_value'];
    cashback = json['cashback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qrcode'] = this.qrcode;
    data['status_fns'] = this.statusFns;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['is_dummy'] = this.isDummy;
    data['inn'] = this.inn;
    data['sum'] = this.sum;
    data['time'] = this.time;
    if (this.products != null) {}
    data['shop_name'] = this.shopName;
    data['shop_name_short'] = this.shopNameShort;
    data['user_match_value'] = this.userMatchValue;
    data['cashback'] = this.cashback;
    return data;
  }

  @override
  String toString() {
    return 'ReceiptHeader{id: $id, qrcode: $qrcode, statusFns: $statusFns, data: $data, isDummy: $isDummy, inn: $inn, sum: $sum, time: $time, products: $products, shopName: $shopName, shopNameShort: $shopNameShort, userMatchValue: $userMatchValue, cashback: $cashback}';
  }
}

class Data {
  Document document;

  Data({this.document});

  Data.fromJson(Map<String, dynamic> json) {
    document = json['document'] != null
        ? new Document.fromJson(json['document'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.document != null) {
      data['document'] = this.document.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Data{document: $document}';
  }
}

class Document {
  Receipt receipt;

  Document({this.receipt});

  Document.fromJson(Map<String, dynamic> json) {
    receipt =
        json['receipt'] != null ? new Receipt.fromJson(json['receipt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.receipt != null) {
      data['receipt'] = this.receipt.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Document{receipt: $receipt}';
  }
}

class Receipt {
  String user;
  List<Items> items;
  String userInn;
  String dateTime;
  String kktRegId;
  String operator;
  int totalSum;
  String fiscalSign;
  int shiftNumber;
  int cashTotalSum;
  int ecashTotalSum;
  int requestNumber;
  String fiscalDriveNumber;
  String fiscalDocumentNumber;

  Receipt(
      {this.user,
      this.items,
      this.userInn,
      this.dateTime,
      this.kktRegId,
      this.operator,
      this.totalSum,
      this.fiscalSign,
      this.shiftNumber,
      this.cashTotalSum,
      this.ecashTotalSum,
      this.requestNumber,
      this.fiscalDriveNumber,
      this.fiscalDocumentNumber});

  Receipt.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    userInn = json['userInn'];
    dateTime = json['dateTime'];
    kktRegId = json['kktRegId'];
    operator = json['operator'];
    totalSum = json['totalSum'];
    fiscalSign = json['fiscalSign'].toString();
    shiftNumber = json['shiftNumber'];
    cashTotalSum = json['cashTotalSum'];
    ecashTotalSum = json['ecashTotalSum'];
    requestNumber = json['requestNumber'];
    fiscalDriveNumber = json['fiscalDriveNumber'].toString();
    fiscalDocumentNumber = json['fiscalDocumentNumber'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['userInn'] = this.userInn;
    data['dateTime'] = this.dateTime;
    data['kktRegId'] = this.kktRegId;
    data['operator'] = this.operator;
    data['totalSum'] = this.totalSum;
    data['fiscalSign'] = this.fiscalSign;
    data['shiftNumber'] = this.shiftNumber;
    data['cashTotalSum'] = this.cashTotalSum;
    data['ecashTotalSum'] = this.ecashTotalSum;
    data['requestNumber'] = this.requestNumber;
    data['fiscalDriveNumber'] = this.fiscalDriveNumber;
    data['fiscalDocumentNumber'] = this.fiscalDocumentNumber;
    return data;
  }

  @override
  String toString() {
    return 'Receipt{user: $user, items: $items, userInn: $userInn, dateTime: $dateTime, kktRegId: $kktRegId, operator: $operator, totalSum: $totalSum, fiscalSign: $fiscalSign, shiftNumber: $shiftNumber, cashTotalSum: $cashTotalSum, ecashTotalSum: $ecashTotalSum, requestNumber: $requestNumber, fiscalDriveNumber: $fiscalDriveNumber, fiscalDocumentNumber: $fiscalDocumentNumber}';
  }
}

class Items {
  int sum;
  String name;
  int price;
  Null markCode;
  double quantity;
  Null payMethod;

  Items(
      {this.sum,
      this.name,
      this.price,
      this.markCode,
      this.quantity,
      this.payMethod});

  Items.fromJson(Map<String, dynamic> json) {
    sum = json['sum'];
    name = json['name'];
    price = json['price'];
    markCode = json['markCode'];
    quantity = json['quantity'];
    payMethod = json['payMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sum'] = this.sum;
    data['name'] = this.name;
    data['price'] = this.price;
    data['markCode'] = this.markCode;
    data['quantity'] = this.quantity;
    data['payMethod'] = this.payMethod;
    return data;
  }

  @override
  String toString() {
    return 'Items{sum: $sum, name: $name, price: $price, markCode: $markCode, quantity: $quantity, payMethod: $payMethod}';
  }
}

class Products {
  List<ProductItem> products;

  Products({this.products});

  Products.fromJson(Map<String, dynamic> json) {
    products = new List<ProductItem>();
    json.forEach((key, value) {
      final productJson = value;
      products.add(ProductItem.fromJson(productJson));
    });
  }
}

class ProductItem {
  Product product;
  Match match;
  Cashback cashback;

  ProductItem({this.product, this.match, this.cashback});

  ProductItem.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    match = json['match'] != null ? new Match.fromJson(json['match']) : null;
    cashback = json['cashback'] != null
        ? new Cashback.fromJson(json['cashback'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.match != null) {
      data['match'] = this.match.toJson();
    }
    if (this.cashback != null) {
      data['cashback'] = this.cashback.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ProductItem{product: $product, match: $match, cashback: $cashback}';
  }
}

class Product {
  Properties properties;
  Counters counters;

  Product({this.properties, this.counters});

  Product.fromJson(Map<String, dynamic> json) {
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    counters = json['counters'] != null
        ? new Counters.fromJson(json['counters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    if (this.counters != null) {
      data['counters'] = this.counters.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Product{properties: $properties, counters: $counters}';
  }
}

class Properties {
  String title;
  int rating;
  String ratingF;
  String gtin;
  int id;
  int manufacturer;
  Null brand;
  List<String> images;

  Properties(
      {this.title,
      this.rating,
      this.ratingF,
      this.gtin,
      this.id,
      this.manufacturer,
      this.brand,
      this.images});

  Properties.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    rating = json['rating'];
    ratingF = json['rating_f'];
    gtin = json['gtin'];
    id = json['id'];
    manufacturer = json['manufacturer'];
    brand = json['brand'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['rating'] = this.rating;
    data['rating_f'] = this.ratingF;
    data['gtin'] = this.gtin;
    data['id'] = this.id;
    data['manufacturer'] = this.manufacturer;
    data['brand'] = this.brand;
    data['images'] = this.images;
    return data;
  }

  @override
  String toString() {
    return 'Properties{title: $title, rating: $rating, ratingF: $ratingF, gtin: $gtin, id: $id, manufacturer: $manufacturer, brand: $brand, images: $images}';
  }
}

class Counters {
  int rateCount;
  double rateAverage;
  int lists;
  int reviews;
  int priceCount;
  double priceAverage;
  int scans;
  int views;
  int requests;

  Counters(
      {this.rateCount,
      this.rateAverage,
      this.lists,
      this.reviews,
      this.priceCount,
      this.priceAverage,
      this.scans,
      this.views,
      this.requests});

  Counters.fromJson(Map<String, dynamic> json) {
    rateCount = json['rate_count'];
    // rateAverage = json['rate_average'];
    lists = json['lists'];
    reviews = json['reviews'];
    priceCount = json['price_count'];
    priceAverage = json['price_average'];
    scans = json['scans'];
    views = json['views'];
    requests = json['requests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate_count'] = this.rateCount;
    data['rate_average'] = this.rateAverage;
    data['lists'] = this.lists;
    data['reviews'] = this.reviews;
    data['price_count'] = this.priceCount;
    data['price_average'] = this.priceAverage;
    data['scans'] = this.scans;
    data['views'] = this.views;
    data['requests'] = this.requests;
    return data;
  }

  @override
  String toString() {
    return 'Counters{rateCount: $rateCount, rateAverage: $rateAverage, lists: $lists, reviews: $reviews, priceCount: $priceCount, priceAverage: $priceAverage, scans: $scans, views: $views, requests: $requests}';
  }
}

class Match {
  int id;
  String category;
  String matchStatus;
  int item;

  Match({this.id, this.category, this.matchStatus, this.item});

  Match.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    matchStatus = json['match_status'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['match_status'] = this.matchStatus;
    data['item'] = this.item;
    return data;
  }

  @override
  String toString() {
    return 'Match{id: $id, category: $category, matchStatus: $matchStatus, item: $item}';
  }
}

class Cashback {
  String status;
  Null offer;
  Null amount;

  Cashback({this.status, this.offer, this.amount});

  Cashback.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    offer = json['offer'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['offer'] = this.offer;
    data['amount'] = this.amount;
    return data;
  }

  @override
  String toString() {
    return 'Cashback{status: $status, offer: $offer, amount: $amount}';
  }
}
