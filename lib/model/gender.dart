enum Gender {
  all, man, woman
}

extension GenderExt on Gender {
  String get key {
    if (this == Gender.man)
      return 'man';
    else if (this == Gender.woman)
      return 'woman';
    else
      return 'all';
  }

  String get name {
    if (this == Gender.man)
      return 'Man';
    else if (this == Gender.woman)
      return 'Woman';
    else
      return 'All';
  }
}

extension StringExt on String {
  Gender toGender() {
    if (this == 'man')
      return Gender.man;
    else if (this == 'woman')
      return Gender.woman;
    else
      return Gender.all;
  }
}