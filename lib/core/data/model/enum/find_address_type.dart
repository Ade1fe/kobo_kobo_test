enum FindAddressType {
  container('Container'),
  address('Address');

  const FindAddressType(this.value);

  final String value;
}

extension FindAddressTypeX on FindAddressType {
  /// Indicates that another query has to be made to get more details
  bool get isContainer => this == FindAddressType.container;
  bool get isAddress => this == FindAddressType.address;
}
