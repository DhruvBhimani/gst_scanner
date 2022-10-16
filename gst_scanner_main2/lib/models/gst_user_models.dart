class GstUserModels {
  String? gstin;
  String? name;
  String? phonenumber;
  String? email;
  GstUserModels({this.gstin, this.name, this.email, this.phonenumber});

  factory GstUserModels.fromJson(Map<dynamic, dynamic> json) {
    return GstUserModels(
        name: json['CompanyName'],
        gstin: json['GSTIN'],
        email: json['EmailId'],
        phonenumber: json['PhoneNumber']);
  }
}
