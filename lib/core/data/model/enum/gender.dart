enum Gender {
  male,
  female,
  nonBinary,
  others,
  none,
}

extension GenderX on Gender {
  String get label {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.nonBinary:
        return 'NonBinary';
      case Gender.others:
        return 'Others';
      case Gender.none:
        return '';
    }
  }

  int get value {
    switch (this) {
      case Gender.male:
        return 0;
      case Gender.female:
        return 1;
      case Gender.nonBinary:
        return 2;
      case Gender.others:
        return 3;
      case Gender.none:
        return 4; // This is invalid
    }
  }
}

Gender genderFromString(String value) {
  switch (value) {
    case 'male':
      return Gender.male;
    case 'female':
      return Gender.female;
    case 'nonBinary':
      return Gender.nonBinary;
    case 'others':
      return Gender.others;
    default:
      throw ArgumentError('Invalid gender value: $value');
  }
}
