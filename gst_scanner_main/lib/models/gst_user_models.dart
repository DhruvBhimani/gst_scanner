class GstUserModels{
  String ? gstin;
  String ? name;

  GstUserModels({
   this.gstin,this.name
});

  factory GstUserModels.fromJson(
      Map<dynamic, dynamic> json) {
    return GstUserModels(
      name: json['Name'],
      gstin: json['GSTIN']
    );
  }
}