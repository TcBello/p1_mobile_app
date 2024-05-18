# p1_mobile_app

A Flutter project for Prosperna Flutter Exam.

## Setup

Run flutter in debug mode

```dart
flutter run --debug
```

Run flutter in profile mode

```dart
flutter run --profile
```

Run flutter in release mode

```dart
flutter run --release
```

Build an apk file with flutter

```dart
flutter build apk
```

## App Architecture

The application is built with MVVM Architecture Pattern.
It consists of:

- Model
- View/Pages
- ViewModel

**Model** consists of sub directories of the following:

- data/data source
- entities
- repositories

**View/Pages** consists of reusable widgets/components and Pages.

**ViewModel** consists of providers that help for good state management.

## Key Features

- **User Authentication**

An email must be in a vaild format, and a password must at least be minimum of 6 characters.

- Product Listing

Products are listed in a grid view and shows a detailed information when a product is viewed.

- Cart

Products can be added to cart. It can also update the quantity of the product and remove from the cart. It has a total amount that will be shown and can also checkout if the user decides to buy them.

- Order placement

The user can place an order, but for that to happen, the user must fill out the shipping address to proceed with the order placement. After the order placement, the user will see the order summary that contains all the user bought and a range of delivery days.

## Details on adherence to best practices

- **DRY**

DRY is implemented many ways such as, utils, json parsing, and custom color in themes

- **TDD**

TDD is implemented on the tests folder for the unit testing to ensure the functions are working well.

- **Separation of Concerns**

Separation of concerns is applied on the application itself. All folders has an individual purposes and uses. It also applies in the code so that the project is maintainable and scalable.
