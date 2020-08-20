enum Gender {
  all, man, woman
}

extension GenderExt on Gender {
  String get key {
    if (this == Gender.man)
      return 'men';
    else if (this == Gender.woman)
      return 'women';
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
    if (this == 'men')
      return Gender.man;
    else if (this == 'women')
      return Gender.woman;
    else
      return Gender.all;
  }
}