import 'package:equatable/equatable.dart';

class RetrieveAddressModel extends Equatable {
  const RetrieveAddressModel({
    this.line1,
    this.line2,
    this.street,
    this.city,
    this.province,
    this.postalCode,
    this.adminAreaName,
  });

  factory RetrieveAddressModel.fromJson(Map<String, dynamic> json) {
    return RetrieveAddressModel(
      line1: json['Line1']??'',
      line2: json['Line2']??'',
      street: json['Street']??'',
      city: json['City']??'',
      province: json['Province']??'',
      adminAreaName: json['AdminAreaName']??'',
      postalCode: json['PostalCode']??'',
    );
  }

  static List<RetrieveAddressModel> parseRetrieveAddressModelList(
    Map<String, dynamic> responseBody,
  ) {
    final items = responseBody['Items'] as List<dynamic>;

    final addressList = items.map<RetrieveAddressModel>((item) {
      return RetrieveAddressModel.fromJson(item as Map<String, dynamic>);
    }).toList();

    return addressList;
  }

  final String? line1;
  final String? line2;
  final String? street;
  final String? city;
  final String? province;
  final String? postalCode;
  final String? adminAreaName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['Line1'] = line1;
    data['Line2'] = line2;
    data['Street'] = street;
    data['City'] = city;
    data['Province'] = province;
    data['PostalCode'] = postalCode;
    data['AdminAreaName'] = adminAreaName;


    return data;
  }

  String get houseNumber => "${line1 ?? ''} ${line2 ?? ''}".trim();
  String get state => province!.isNotEmpty ?province!:adminAreaName!;

  @override
  List<Object?> get props {
    return [
      line1,
      line2,
      street,
      city,
      province,
      postalCode,
    ];
  }
}
