# Currency Converter Flutter App

## Overview
This app is a simple and efficient currency converter built with Flutter, allowing users to convert between various currencies in real-time. The app fetches latest exchange rates from an API and provides a user-friendly interface for seamless conversion.

## Features
- Fetch live exchange rates data.
- Get exchange rates among currencies.
- Swap between two currencies.
- Display converted amount on the screen.

## Folder Structure
```
lib/
├── models/                             # Holds main app data models.
│   ├── currency_model.dart
│   └── rates_model.dart
├── pages/                              # Contains UI screens.
│   ├── converter_page.dart
│   ├── error_page.dart
│   ├── home_page.dart
│   └── loading_page.dart
├── repositories/                       # Manage data retrieval from API and provides data to ViewModel layer.
│   ├── currency_repository.dart
│   └── rates_repository.dart
├── services/                           # Includes API integration for fetching live data.
│   └── api_client.dart
├── utils/                              # Contains helper utilities, such as for API response. 
│   ├── api_response.dart
│   └── app_constants.dart
├── viewmodels/                         # Manage the app's state and business logic for specific views.
│   └── currency_view_model.dart
├── widgets/                            # Holds reusable components.
│   └── custom_drop_down.dart
└── main.dart
```

## Build and Run
Follow these steps to get the app up and running:
1. Clone the repository: ```git clone https://github.com/trungdai01/currency_converter.git```
2. Navigate to the project directory: ```cd currency_converter```
3. Install dependencies: ```flutter pub get```
4. Run the app: ```flutter run```

## API Integration
The app integrates a free currency exchange rates API from this repository [exchange-api](https://github.com/fawazahmed0/exchange-api).

## Dependencies
- [http](https://pub.dev/packages/http): For making HTTP requests.
- [provider](https://pub.dev/packages/provider): State management package.
- [dropdown_button2](https://pub.dev/packages/dropdown_button2): Steady dropdown menu.