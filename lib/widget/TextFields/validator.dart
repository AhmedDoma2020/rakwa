import 'package:get/get_utils/src/extensions/export.dart';
import 'package:rakwa/Core/utils/extensions.dart';

String? urlValidator(String? text) {
  printDM("<<<<<<<<<<<><>>>>>>>>>");
  if (text!.isNotEmpty) {
    if (!text.contains('http') && !text.contains("://") ) {
      printDM("<<<<<<<<<<<><>>>>>>>>> fasle");

      return 'يجب ادخال رابط صحيح كما هوا موضح ف المثال';
    } else {
      printDM("<<<<<<<<<<<><>>>>>>>>> true $text");
      return null;
    }
  } else {
    return null;
  }
}

String? emailValidator(String? text) {
  if (text!.isNotEmpty) {
    if (!text.contains('@')) {
      return 'يجب ادخال البريد الالكتروني صحيح'.tr;
    } else {
      return null;
    }
  } else {
    return 'يجب ادخال البريد الالكتروني'.tr;
  }
}


String? userNameValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب ادخال اسم المستخدم او البريد الالكتروني';
  }
}





String? addressMessageValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب ادخال عنوان الرسالة';
  }
}

String? messageValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب ادخال الرسالة';
  }
}

String? addressMenuValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب ادخال عنوان القائمه';
  }
}

String? descriptionValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب ادخال الوصف';
  }
}

String? firstNameValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب ادخال اسمك الاول';
  }
}

String? lastNameValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب ادخال اسمك الاخير';
  }
}

String? personalNameValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب ادخال اسمك الشخصي';
  }
}

String? phoneValidator(String? text) {
  if (text!.isNotEmpty) {
    // if(text.startsWith('0') && text.length ==11) {
    //   return null;
    // } else {
    //   return 'validation_right_phone'.tr;
    // }
    return null;
  } else {
    return 'يجب ادخال رقم الهاتف';
  }
}

String? passwordValidator(String? text) {
  if (text!.isNotEmpty) {
    if (text.length >= 8) {
      return null;
    } else {
      return 'يجب الا يقل كلمة المرور عن ٨ رموز'.tr;
    }
  } else {
    return 'يجب ادخال كلمة المرور'.tr;
  }
}




String? priceValidator(String? text) {
  if (text!.isNotEmpty) {
    null;
  } else {
    return 'يجب ادخال السعر'.tr;
  }
}

String? locationValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب ادخال الموقع';
  }
}

String? countryValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب اختيار الدوله';
  }
}

String? stateValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب اختيار ولاية';
  }
}

String? cityValidator(String? text) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب اختيار مدينة';
  }
}

String? confirmPasswordValidator(String? text, String? oldPassword) {
  if (text!.isNotEmpty) {
    if (text != oldPassword) {
      return 'يجب ان تتطابق كلمتان المرور';
    } else {
      return null;
    }
  } else {
    return 'يجب عليك ادخال كلمة المرور';
  }
}

String? emptyValidator(String? text, {String error = ''}) {
  if (text!.isNotEmpty) {
    return null;
  } else {
    return 'يجب عليك ادخال هذا الحقل';
  }
}
