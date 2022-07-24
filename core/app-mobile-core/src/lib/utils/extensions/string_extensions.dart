import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String? {
  String capitalize() {
    //used for person name
    if (isBlank()) {
      return '';
    }
    return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
  }

  String capitalizeName() {
    if (isBlank()) {
      return '';
    }
    var result = this!.trim();
    final splitName = result.split(' ');
    result = '';
    for (var i = 0; i < splitName.length; i++) {
      if (splitName[i].isEmpty) continue;
      if (result.isNotEmpty) {
        result = result + ' ';
      }
      result = result + splitName[i].capitalize();
    }
    return result;
  }

  bool isBlank() => this == null || this!.isEmpty;

  bool isNotBlank() => this != null && this!.isNotEmpty;

  bool equalsIgnoreCase(String other) => this?.toLowerCase() == other.toLowerCase();

  /// Converts strings containing amount to double.
  /// Examples:
  /// - “GBP 100.10” = 100.10
  /// - “GBP 1000,000,000.10” =  100000000.10
  /// - “1000,000,000.10” = 100000000.10
  /// - “99.99 USD” = 99.99
  double? toDoubleAmount() {
    if (this == null) return null;

    var amountText = this!.replaceAll(RegExp('[^\\d|^\\.]'), '');
    return NumberFormat.currency(customPattern: '#,##0.00').parse(amountText).toDouble();
  }

  /// Converts string amounts with currency symbol to unformatted String amount.
  /// Examples:
  /// - “EUR 100.10” = “100.10”
  /// - “GBP 1000,000,000.10” = “100000000.10”
  /// - “1000,000,000.10” = “100000000.10”
  String? toStringAmount() => NumberFormat.currency(symbol: '', customPattern: '#0.00').format(toDoubleAmount());

  /// Converts string amount with thousand separators
  String? toStringAmountWithThousandSeparator() =>
      NumberFormat.currency(symbol: '', customPattern: '#,###.00').format(toDoubleAmount());

  bool isNameInvalid() => this != null && !_nameRegExp.hasMatch(this!);

  bool isSpaceNameInvalid() => this != null && !(_spaceNameRegExp.stringMatch(this!) == this);

  bool isBankNameInvalid() => this != null && !_bankNameRegExp.hasMatch(this!);

  bool isPostalCodeInvalid() => this != null && !_postalCodeRegExp.hasMatch(this!);

  bool isCityInvalid() => this != null && !_cityRegExp.hasMatch(this!);

  bool get isNotAllZeros => this != null && !_allZerosRegExp.hasMatch(this!);

  bool isPhoneNumberInvalid([bool shouldAllowPlusSign = true]) {
    if (shouldAllowPlusSign) {
      return this != null && !_phoneNumberWithPlusSignRegExp.hasMatch(this!);
    } else {
      return this != null && !_phoneNumberRegExp.hasMatch(this!);
    }
  }

  bool isValidEmail() => this != null && _emailRegExp.hasMatch(this!);

  bool isAlphaNumericWithSpace() => this != null && _alphaNumericWithSpaceRegExp.hasMatch(this!);

  bool isAlphabetWithSpace() => this != null && _alphabetWithSpaceRegExp.hasMatch(this!);

  bool hasEmoji() => this != null && _emojiRegExp.hasMatch(this!);

  bool containsUnsupportedEmailCharacters() {
    if (isValidEmail()) return false;
    for (var char in unsupportedEmailCharacters) {
      if (this!.contains(char)) {
        return true;
      }
    }
    return false;
  }

  DateTime? getParsedDate() {
    if (this == null) return null;
    try {
      var dateSplit = this!.split('-');
      if (dateSplit[2].length != 4) return null;
      return DateTime(int.parse(dateSplit[2]), int.parse(dateSplit[1]), int.parse(dateSplit[0]));
    } catch (e) {
      return null;
    }
  }

  bool isValidDate() {
    if (this == null) return false;

    var date = 0;
    var month = 0;
    var year = 0;

    try {
      var dateSplit = this!.split('-');
      date = int.parse(dateSplit[0]);
      month = int.parse(dateSplit[1]);
      year = int.parse(dateSplit[2]);
    } catch (e) {
      date = 0;
      month = 0;
      year = 0;
    }
    var maxValidYear = 9999;
    var minValidYear = 1800;
    if (year > maxValidYear || year < minValidYear) return false;
    if (month < 1 || month > 12) return false;
    if (date < 1 || date > 31) return false;
    bool isLeap() {
      // Return true if year is
      // a multiple of 4 and not
      // multiple of 100.
      // OR year is multiple of 400.
      return (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0));
    }

    // Handle February month
    // with leap year
    if (month == 2) {
      if (isLeap()) {
        return (date <= 29);
      } else {
        return (date <= 28);
      }
    }

    // Months of April, June,
    // Sept and Nov must have
    // number of days less than
    // or equal to 30.
    if (month == 4 || month == 6 || month == 9 || month == 11) return (date <= 30);

    return true;
  }

  /// Extracts whole part of the amount string
  ///
  /// sample input : `145015.24`
  /// returns output `145015`
  String? extractWholeAmount() {
    if (this == null) return null;

    final matches = RegExp(r'.*(?=\.|,)').allMatches(this!);
    if (matches.isEmpty) return '';
    final wholeAmount = matches.elementAt(0).group(0).toString();
    final decimalSeparatorExcluded = wholeAmount.replaceAll(RegExp(r'\,|\.'), '');
    return NumberFormat().format(int.tryParse(decimalSeparatorExcluded) ?? 0);
  }

  /// Extracts cent part of the amount string
  ///
  /// sample input : `145015.24`
  /// returns output `.24 `
  String? extractCentAmount() {
    if (this == null) return null;

    final matches = RegExp(r'[^.|,]+$').allMatches(this!);
    if (matches.isEmpty) return '';
    return '.${matches.elementAt(0).group(0)} ';
  }

  DateTime formatFromDDMMYYYY([String defaultDateFormat = 'dd-MM-yyyy']) {
    assert(!isBlank());
    final format = DateFormat(defaultDateFormat);
    final gettingDate = format.parse(toString());
    return gettingDate;
  }

  ///Parse ISO8601 format ("yyyy-MM-dd'T'hh:mm:ss.sssZ")
  DateTime dateFromISO8601Format() {
    assert(!isBlank());
    final format = DateFormat("yyyy-MM-dd'T'hh:mm:ss.sssZ");
    final gettingDate = format.parse(toString());
    return gettingDate;
  }

  Color toColor() => Color(int.parse(this!));

  Color toColorWithOpacity(double opacity) {
    final color = Color(int.parse(this!));
    return color.withOpacity(opacity);
  }

  DateTime? toDateTime() {
    if (this == null) return null;
    assert(this!.isNotEmpty);
    return DateTime.parse(toString());
  }

  String? getEmailUri(String? subject) {
    if (this == null) return null;
    assert(this!.isNotEmpty);
    var emailUri = Uri(
      scheme: 'mailto',
      path: this,
      queryParameters: {'subject': subject},
    );
    return emailUri.toString();
  }

  String? surroundQuotes() {
    if (isNotBlank()) {
      return '"$this"';
    }
    return null;
  }
}

final RegExp _nameRegExp = RegExp(r'[a-zA-Z]{1,22}');
final RegExp _bankNameRegExp = RegExp(r'[a-zA-Z]{2,22}');
final RegExp _postalCodeRegExp = RegExp(r'\d{2}-\d{3}');
final RegExp _cityRegExp = RegExp(r'[a-zA-Z]{2,30}');
final RegExp _phoneNumberRegExp = RegExp(r'^[0-9]{9}$');
final RegExp _phoneNumberWithPlusSignRegExp = RegExp(r'^[+]{1}[0-9]{6,20}$');
final RegExp _spaceNameRegExp = RegExp(r'[a-zA-Z0-9 ]{0,24}');
final RegExp _allZerosRegExp = RegExp(r'^0+$');
final RegExp _alphaNumericWithSpaceRegExp = RegExp(r'^[a-zA-Z0-9 ]+$');
final RegExp _alphabetWithSpaceRegExp = RegExp(r'^[a-zA-Z ]+$');
final RegExp _emojiRegExp =
    RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
final RegExp _emailRegExp = RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
);

final unsupportedEmailCharacters = ['(', ')', '<', '>', '@@', ',', ';', ':', '"', '[', ']', '%', '&', ';', '..'];
