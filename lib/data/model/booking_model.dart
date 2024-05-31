class Welcome {
  int? id;
  String? date;
  String? userId;
  String? pharmacyName;
  String? serviceName;
  String? starttime;
  String? endtime;
  String? createdAt;
  String? updatedAt;
  String? storelogo;
  int? orderid;

  Welcome(
    this.orderid,
      {this.id,
      this.date,
      this.userId,
      this.pharmacyName,
      this.serviceName,
      this.starttime,
      this.endtime,
      this.createdAt,
      this.storelogo,
      this.updatedAt});

  Welcome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    userId = json['user_id'];
    pharmacyName = json['Pharmacy_name'];
    serviceName = json['service_name'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storelogo=json['store_logo'];
    orderid=json['order-id'];
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['user_id'] = this.userId;
    data['Pharmacy_name'] = this.pharmacyName;
    data['service_name'] = this.serviceName;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}