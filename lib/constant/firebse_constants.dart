import 'package:intl/intl.dart';

class FirebaseConstants {
  static const usersCollectionName = 'users';
  static const ordersCollectionName = 'test-orders';
  static const docsCollectionName = 'user-documents';

  //document types collection
  static const documentTypesCollectionName = 'document-types';
  static const merchantOrdersCollectionName = 'merchant-orders';
  static const userRatingsCollection = 'user-ratings';
  static const providerRatingsCollection = 'provider-ratings';

  static const appDataDocName = 'app_data';
  static const configCollectionName = 'config';

  static const serviceTypesCollection = 'service-types';
  static const notificationsCollection = 'notifications';

  static String paymentCollectionName = 'payments';
}

final defaultTimeFormat = DateFormat('h:mm a');
final defaultDayTimeFormat = DateFormat('dd-mm-yyy h:mm a');

//date only format
final defaultDateOnlyFormat = DateFormat('dd-MM-yyyy');
