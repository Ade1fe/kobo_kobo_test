import 'package:kobo_kobo/core/core.dart';
import 'package:equatable/equatable.dart';

class FindAddressModel extends Equatable {
  const FindAddressModel({
    required this.id,
    required this.type,
    required this.text,
  });
  factory FindAddressModel.fromJson(Map<String, dynamic> json) {
    return FindAddressModel(
      id: json['Id'] ?? '',
      type: json['Type'] == null
          ? FindAddressType.address
          : FindAddressType.values.firstWhere(
              (element) => element.value == json['Type'],
              orElse: () => FindAddressType.address,
            ),
      text: json['Text'] ?? '',
    );
  }

  static List<FindAddressModel> parseFindAddressModelList(
    Map<String, dynamic> responseBody,
  ) {
    final items = responseBody['Items'] as List<dynamic>;

    final addressList = items.map<FindAddressModel>((item) {
      return FindAddressModel.fromJson(item as Map<String, dynamic>);
    }).toList();

    return addressList;
  }

  final String id;
  final FindAddressType type;
  final String text;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['Id'] = id;
    data['Type'] = type;
    data['Text'] = text;

    return data;
  }

  @override
  List<Object> get props {
    return [id, type, text];
  }
}
