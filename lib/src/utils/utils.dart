import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../constants/app_colors.dart';
import '../constants/app_values.dart';
import 'enums/card/card_type.dart';
import 'global_utils.dart';

class Utils {
  static Future<void> getXBottomSheet({
    required Widget child,
    double elevation = 10.0,
    bool persistent = false,
    bool enableDrag = false,
    bool isDismissible = true,
    bool ignoreSafeArea = false,
    Function(dynamic)? onClosing,
    bool isScrollControlled = false,
    Color barrierColor = Colors.black54,
    Color backgroundColor = AppColors.white,
    double borderRadius = AppValues.radius30,
  }) async {
    final result = await Get.bottomSheet(
      child,
      elevation: elevation,
      enableDrag: enableDrag,
      persistent: isDismissible,
      barrierColor: barrierColor,
      isDismissible: isDismissible,
      ignoreSafeArea: ignoreSafeArea,
      backgroundColor: backgroundColor,
      isScrollControlled: isScrollControlled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius),
        ), // Rounded top corners
      ),
    );

    // If a result is returned and a callback is provided, pass the result to the callback.
    if (result != null && onClosing != null) {
      onClosing(result);
    }
  }

  static Future<void> showGetModal({
    required Widget child,
    double elevation = 10.0,
    bool enableDrag = true,
    bool isDismissible = true,
    bool expand = false,
    bool showDragHandle = true,
    Color barrierColor = Colors.black54,
    Color backgroundColor = AppColors.white,
    double borderRadius = AppValues.defaultRadius,
    ShapeBorder? shape,
    bool useRootNavigator = false,
    bool isScrollControlled = false,
  }) async {
    final result = await showModalBottomSheet(
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return child;
      },
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      elevation: elevation,
      barrierColor: barrierColor,
      showDragHandle: showDragHandle,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadius)),
          ),
      useRootNavigator: useRootNavigator,
    );

    // If a result is returned and a callback is provided, you can handle it outside the function
    return result;
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class PostCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(' ', ''); // Remove existing spaces

    if (text.length > 3) {
      text = '${text.substring(0, 3)} ${text.substring(3)}';
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CardUtils {
  CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(
      RegExp(
          r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'),
    )) {
      cardType = CardType.masterCard;
    } else if (input.startsWith(
      RegExp(r'[4]'),
    )) {
      cardType = CardType.verve;
    } else if (input.startsWith(
      RegExp(r'((506(0|1))|(507(8|9))|(6500))'),
    )) {
      cardType = CardType.verve;
    } else if (input.length <= 8) {
      cardType = CardType.others;
    } else {
      cardType = CardType.invalid;
    }
    return cardType;
  }

  List<String> getExpiryDate(String value) {
    var split = value.split(RegExp(r' (\/) '));
    return [split[0], split[1]];
  }

  String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write(' / ');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
