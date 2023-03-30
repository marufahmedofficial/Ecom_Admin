const String currencySymbol = '৳';
//eta amar...don't use, use ur own key
const serverKey = 'AAAAXBoM2T0:APA91bFlxfncRwYhZ2F-vmKMwJaf7hg0d7QGgVnj5iuJ-H0moGH74wHDvYBi26qqa-qus-2jjIeCxhcfff2pDGQuNCYSQo7QUlSnEW5-Zi7rjHCJmFqM02kHEENX9Ev5qxczsL697GtR';
const cities = [
  'Dhaka',
  'Chittagong',
  'Rajshahi',
  'Khulna',
  'Barishal',
  'Sylhet',
  'Comilla',
  'Noakhali',
  'Faridpur',
  'Rangpur',
  'Gazipur'
];

abstract class OrderStatus {
  static const String pending = 'Pending';
  static const String processing = 'Processing';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';
  static const String returned = 'Returned';
}

abstract class PaymentMethod {
  static const String cod = 'Cash on Delivery';
  static const String online = 'Online Payment';
}

abstract class NotificationType {
  static const String comment = 'New Comment';
  static const String order = 'New Order';
  static const String user = 'New User';
}
