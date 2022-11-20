import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../customwidgets/image_holder_view.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';
import 'product_repurchase_page.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/productdetails';

  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel productModel;
  late ProductProvider productProvider;

  @override
  void didChangeDependencies() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productModel = ModalRoute
        .of(context)!
        .settings
        .arguments as ProductModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.productName),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            imageUrl: productModel.thumbnailImageUrl,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageHolderView(
                  onImagePressed: () {
                    _showImageOnDialog(0);
                  },
                  url: productModel.additionalImages[0],
                  child: IconButton(
                    onPressed: () {
                      _addImage(0);
                    },
                    icon: Icon(Icons.add, color: Theme
                        .of(context)
                        .primaryColor,),
                  ),
                ),
                ImageHolderView(
                  onImagePressed: () {
                    _showImageOnDialog(1);
                  },
                  url: productModel.additionalImages[1],
                  child: IconButton(
                    onPressed: () {
                      _addImage(1);
                    },
                    icon: Icon(Icons.add, color: Theme
                        .of(context)
                        .primaryColor,),
                  ),
                ),
                ImageHolderView(
                  onImagePressed: () {
                    _showImageOnDialog(2);
                  },
                  url: productModel.additionalImages[2],
                  child: IconButton(
                    onPressed: () {
                      _addImage(2);
                    },
                    icon: Icon(Icons.add, color: Theme
                        .of(context)
                        .primaryColor,),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () =>
                    Navigator.pushNamed(
                      context,
                      ProductRepurchasePage.routeName,
                      arguments: productModel,
                    ),
                child: const Text('Re-Purchase'),
              ),
              OutlinedButton(
                onPressed: _showPurchaseList,
                child: const Text('Purchase History'),
              ),
            ],
          ),
          ListTile(
            title: Text(productModel.productName),
            subtitle: Text(productModel.category.categoryName),
          ),
          ListTile(
            title: Text('Sale Price: $currencySymbol${productModel.salePrice}'),
            subtitle: Text('Stock: ${productModel.stock}'),
          ),
          SwitchListTile(
            value: productModel.available,
            onChanged: (value) {
              setState(() {
                productModel.available = !productModel.available;
              });
              productProvider.updateProductField(
                  productModel.productId!,
                  productFieldAvailable, productModel.available);
            },
            title: const Text('Available'),
          ),
          SwitchListTile(
            value: productModel.featured,
            onChanged: (value) {
              setState(() {
                productModel.featured = !productModel.featured;
              });
              productProvider.updateProductField(
                  productModel.productId!,
                  productFieldFeatured, productModel.featured);
            },
            title: const Text('Featured'),
          ),
        ],
      ),
    );
  }

  void _showPurchaseList() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          final purchaseList = productProvider.getPurchaseByProductId(
              productModel.productId!);
          return Container(
            margin: const EdgeInsets.all(20),
            child: ListView.builder(
              //shrinkWrap: true,
              itemCount: purchaseList.length,
              itemBuilder: (context, index) {
                final purchaseModel = purchaseList[index];
                return ListTile(
                  title: Text(getFormattedDate(
                      purchaseModel.dateModel.timestamp.toDate())),
                  subtitle: Text(
                      '$currencySymbol${purchaseModel.purchasePrice}'),
                  trailing: Text('Qty: ${purchaseModel.purchaseQuantity}'),
                );
              },
            ),
          );
        });
  }

  void _addImage(int index) async {
    final selectedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery, imageQuality: 70,);
    if (selectedFile != null) {
      EasyLoading.show(status: 'Please wait');
      try {
        final downloadUrl = await productProvider.uploadImage(
            selectedFile.path);
        final previousList = productModel.additionalImages;
        previousList[index] = downloadUrl;
        await productProvider.updateProductField(
          productModel.productId!, productFieldImages,
          previousList,);
        setState(() {
          productModel.additionalImages[index] = downloadUrl;
        });
        EasyLoading.dismiss();
        if(mounted) showMsg(context, 'Uploaded Successfully');
      } catch (error) {
        EasyLoading.dismiss();
        if(mounted) showMsg(context, 'Upload failed');
        rethrow;
      }
    }
  }

  void _showImageOnDialog(int index) {
    final url = productModel.additionalImages[index];
    showDialog(context: context, builder: (context) => AlertDialog(
      content: CachedNetworkImage(
        fit: BoxFit.contain,
        height: MediaQuery.of(context).size.height / 2,
        imageUrl: url,
        placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        IconButton(
          onPressed: () async {
            Navigator.pop(context);
            EasyLoading.show(status: 'Deleting...');
            try {
              await productProvider.deleteImage(url);
              setState(() {
                productModel.additionalImages[index] = '';
              });
              await productProvider.updateProductField(
                productModel.productId!,
                productFieldImages,
                productModel.additionalImages,);
              EasyLoading.dismiss();
            } catch(error) {
              EasyLoading.dismiss();
            }
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    ));
  }
}