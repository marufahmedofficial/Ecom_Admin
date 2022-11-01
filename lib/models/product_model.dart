const String collectionProduct = 'Products';
const String productFieldId = 'productId';
const String productFieldName = 'productName';
const String productFieldCategory = 'category';
const String productFieldShortDescription = 'shortDescription';
const String productFieldLongDescription = 'LongDescription';
const String productFieldSalePrice = 'salePrice';
const String productFieldStock = 'stock';
const String productFieldDiscount = 'discount';
const String productFieldThumbnail = 'thumbnail';
const String productFieldImages = 'images';
const String productFieldAvailable = 'available';
const String productFieldFeatured = 'featured';

class ProductModel {
  String? productId;
  String productName;
  String category;
  String? shortDescription;
  String? longDescription;
  num salePrice;
  num stock;
  num productDiscount;
  String thumbnailImageUrl;
  List<String>? additionalImages;
  bool available;
  bool featured;

  ProductModel(
      {this.productId,
      required this.productName,
      required this.category,
      this.shortDescription,
      this.longDescription,
      required this.salePrice,
      required this.stock,
      this.productDiscount = 0,
      required this.thumbnailImageUrl,
      this.additionalImages,
      this.available = true,
      this.featured = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      productFieldId: productId,
      productFieldName: productName,
      productFieldCategory: category,
      productFieldShortDescription: shortDescription,
      productFieldLongDescription: longDescription,
      productFieldDiscount: productDiscount,
      productFieldSalePrice: salePrice,
      productFieldStock: stock,
      productFieldThumbnail: thumbnailImageUrl,
      productFieldImages: additionalImages,
      productFieldAvailable: available,
      productFieldFeatured: featured,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        productId: map[productFieldId],
        productName: map[productFieldName],
        category: map[productFieldCategory],
        shortDescription: map[productFieldShortDescription],
        longDescription: map[productFieldLongDescription],
        salePrice: map[productFieldSalePrice],
        stock: map[productFieldStock],
        productDiscount: map[productFieldDiscount],
        thumbnailImageUrl: map[productFieldThumbnail],
        additionalImages: map[productFieldImages] != null
            ? map[productFieldImages] as List<String>
            : null,
        available: map[productFieldAvailable],
        featured: map[productFieldFeatured],
      );
}
