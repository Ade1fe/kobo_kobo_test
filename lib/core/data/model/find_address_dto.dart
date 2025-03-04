import 'package:equatable/equatable.dart';

class FindAddressDto extends Equatable {
  const FindAddressDto({
    required this.query,
    required this.country,
    this.container,
  });

  factory FindAddressDto.empty() {
    return const FindAddressDto(query: '', country: '');
  }

  final String query;
  final String country;
  final String? container;

  FindAddressDto copyWith({
    String? query,
    String? country,
    String? container,
  }) {
    return FindAddressDto(
      query: query ?? this.query,
      country: country ?? this.country,
      container: container ?? this.container,
    );
  }

  @override
  List<Object> get props => [query, country];
}
