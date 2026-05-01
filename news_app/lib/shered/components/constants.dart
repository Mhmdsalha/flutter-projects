//"https://newsapi.org/v2/everything?q=apple&from=2021-08-21&to=2021-08-21&sortBy=popularity&apiKey=API_KEY"

import 'dart:io';

bool isArabic = true;
const String newsApiKey = String.fromEnvironment('NEWS_API_KEY');
const String missingNewsApiKeyMessage =
    'Missing NEWS_API_KEY. Run the app with --dart-define=NEWS_API_KEY=your_key';

String getos() {
  return Platform.operatingSystem;
}
