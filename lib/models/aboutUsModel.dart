class AboutUs {
  bool? status;
  String? message;
  AboutUsData? data;

  AboutUs({this.status, this.message, this.data});

  AboutUs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AboutUsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AboutUsData {
  String? about;
  String? terms;

  AboutUsData({this.about, this.terms});

  AboutUsData.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.about;
    data['terms'] = this.terms;
    return data;
  }
}