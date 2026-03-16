extension StringExt on String {
  String operator -(String rhs) => replaceAll(rhs, '');

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[\W_]).{8,}$',
    );
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    // final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    final phoneRegExp = RegExp("^(?:0[89])?[0-9]{10}\$");
    if (!phoneRegExp.hasMatch(this)) {
      return false;
    }
    bool validHeader = false;
    List<String> validPhoneHeaderList = [
      "032",
      "033",
      "034",
      "035",
      "036",
      "037",
      "038",
      "039",
      "096",
      "097",
      "098",
      "086",
      "083",
      "084",
      "085",
      "081",
      "082",
      "087",
      "088",
      "089",
      "091",
      "094",
      "070",
      "071",
      "072",
      "073",
      "074",
      "075",
      "076",
      "077",
      "078",
      "079",
      "090",
      "093",
      "089",
      "052",
      "056",
      "058",
      "092",
      "059",
      "099"
    ];
    validHeader =
        validPhoneHeaderList.any((element) => element == substring(0, 3));
    return validHeader;
  }

  bool get isValidPassport {
    final phoneRegExp = RegExp("[A-Z0-9]{8,15}");
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidPasswordHasNumber {
    if (length < 3) {
      return false;
    }
    for (int i = 0; i < length - 2; i++) {
      int? first = int.tryParse(this[i]);
      int? second = int.tryParse(this[i + 1]);
      int? third = int.tryParse(this[i + 2]);
      if (first == null || second == null || third == null) {
        continue;
      }
      // check trung nhau
      if (first == second && second == third) {
        return false;
      }
      // check lien tiep
      int sub = second - first;
      if (sub > 1 || sub < -1) {
        continue;
      }
      if ((third - second) == sub) {
        return false;
      }
    }
    return true;
  }
}
