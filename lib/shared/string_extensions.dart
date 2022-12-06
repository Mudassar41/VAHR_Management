extension StringExtension on String {
  String get capitalizeFirstLetter {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String get capitalizeFirstLetterOFSentence {
    var formatted = split(' ');

    String finalText = '';
    for (var element in formatted) {
      finalText = "$finalText ${element.capitalizeFirstLetter}";
    }
    return finalText;
  }
}
