class AddressModel {
  String addressLine1;
  String? addressLine2;
  String city;
  String zipcode;

  AddressModel({
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.zipcode,
  });
}