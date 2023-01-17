class ApiKey {
  static const String baseUrl = 'https://rakwa.com/api/';

  // Auth Url
  static const String register = '${baseUrl}register';
  static const String registerUser = '${baseUrl}register-user';
  static const String login = '${baseUrl}login';
  static const String logout = '${baseUrl}logout';
  static const String forgetPassword = '${baseUrl}password/email';
  static const String checkCode = '${baseUrl}password/code/check';
  static const String resetPassword = '${baseUrl}password/reset';
  static const String emailVerification = '${baseUrl}resend/email';

  // Home Url
  static const String allCategories = '${baseUrl}all-categories';
  static const String allClassifiedCtegories =
      '${baseUrl}all-classified-categories';
  static const String paidItems = '${baseUrl}paid-items';
  static const String nearestItems = '${baseUrl}nearby-items';
  static const String paidClassified = '${baseUrl}paid-classified';
  static const String popularItems = '${baseUrl}popular-items';
  static const String popularClassified = '${baseUrl}popular-classified';
  static const String nearestClassified = '${baseUrl}nearby-classified';
  static const String latestItems = '${baseUrl}latest-items';
  static const String latestClassified = '${baseUrl}latest-classified';
  static const String backgroundImage = '${baseUrl}background-image';
  static const String verifiedEmail = '${baseUrl}profile-user/';

  // Artical Url
  static const String artical = '${baseUrl}blog';

  // Classified By ID Url
  static const String classifiedById = '${baseUrl}user/';

  // List Url
  static const String country = '${baseUrl}user/country';
  static const String city = '${baseUrl}user/city';
  static const String state = '${baseUrl}user/state';
  static const String category = '${baseUrl}user/category';
  static const String addList = '${baseUrl}user/';

  // details
  static const String itemDetails = '${baseUrl}item/';
  static const String classifiedDetails = '${baseUrl}classified/';
  static const String nearbyItems = '${baseUrl}nearby-items/';

  // User
  static const String user = '${baseUrl}user/';

  // Item and classified with category
  static const String itemWithCategory = '${user}category-item/';
  static const String classifiedWithCategory = '${user}classified-categorys/';

  // Classified Category
  static const String classifiedCategory =
      '${baseUrl}user/classified-category';

  // Search
  static const String search = '${baseUrl}search?';

  // Custom Fields
  static const String customFields = '${baseUrl}custom-fields';
  static const String customClassifiedFields = '${baseUrl}custom-field';

  // Cotact About Url
  static const String about = '${baseUrl}about';
  static const String contact = '${baseUrl}contact';
  static const String createContact = '${baseUrl}create-contact';
  static const String termsOfService = '${baseUrl}terms-of-service';
  static const String privacyPolicy = '${baseUrl}privacy-policy';

  // FCM token
  static const String fcmToken = '${baseUrl}store';

  // Create Review
  static const String createReview = '${baseUrl}create-reviews/';
}
