import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/attribute.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/models/product_attribute.dart';
import 'package:qarinli/models/product_cart.dart';
import 'package:http/http.dart' as http;
import 'package:qarinli/models/variation.dart';

class CartController {
  Future<List<ProductCart>> getCurrentCart({@required userToken}) async {
    List<ProductCart> cartProducts = [];

    try {
      http.Response response;
      var cartData;
      response = await http.get(
        'https://www.qarinli.com/wp-json/cocart/v1/get-cart',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      var responseBody = await json.decode(response.body);
      // print(responseBody);
      if (responseBody is List<dynamic> ||
          responseBody['message'] == null ||
          responseBody['success']) {
        cartData = responseBody;
        print(cartData);
        print(cartData.runtimeType);
        for (var product in cartData.values) {
          print(product);
          try {
            cartProducts.add(ProductCart(
              cartKey: product['key'],
              dataHash: product['data_hash'],
              productId: product['product_id'],
              variationId: product['variation_id'],
              productName: product['product_name'],
              productPrice: product['product_price'],
              productTitle: product['product_title'],
              subtotal: product['line_subtotal'].toInt(),
              subtotalTax: product['line_subtotal_tax'].toInt(),
              total: product['line_total'].toInt(),
              tax: product['line_tax'].toInt(),
              quantity: product['quantity'],
            ));
          } catch (e) {
            print(e);
          }
        }
      } else {
        print('elsse');
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
    print('cart len :' + cartProducts.length.toString());
    return cartProducts;
  }

  Future<bool> addToCart({@required productId, @required quantity}) {}

  Future<int> getvariationId(
      {@required productId, @required Product product}) async {
    // print(productId);
    int variationId;
    List<Variation> variations = await getVariations(productId: productId);
    for (Variation variation in variations) {
      List<bool> matchedAttributes = [];
      for (ProductAttribute varAttribute in variation.attributes) {
        for (ProductAttribute productAttribute in product.attributes) {
          if (varAttribute.name == productAttribute.name) {
            String slug = await getOptionSlug(
                attributeId: productAttribute.id,
                optionName: productAttribute.selectedValue);
            if (varAttribute.options[0] == slug) {
              matchedAttributes.add(true);
            } else {
              matchedAttributes.add(false);
            }
          }
        }
      }
      if (!matchedAttributes.contains(false)) {
        return variation.id;
      }
    }
    return variationId;
  }

  Future<List<Variation>> getVariations({
    @required productId,
  }) async {
    List<Variation> variations = [];
    var variationsData;
    try {
      http.Response response = await http.get(
          'https://www.qarinli.com/wp-json/wc/v3/products/$productId/variations',
          headers: <String, String>{'authorization': basicAuth});
      var responseBody = await json.decode(response.body);

      if (responseBody is List<dynamic> || responseBody['message'] == null) {
        variationsData = responseBody;
      } else {
        return [];
      }
      for (var variation in variationsData) {
        List<ProductAttribute> attributes = [];
        try {
          for (var attr in variation['attributes']) {
            attributes.add(ProductAttribute(
                id: attr['id'],
                name: attr['name'],
                position: null,
                isVisible: true,
                isVariation: true,
                options: [attr['option']]));
          }
        } catch (e) {
          print('attr error: ' + e.toString());
        }

        variations.add(Variation(
            id: variation['id'],
            link: variation['permalink'],
            sku: variation['sku'],
            price: variation['price'],
            regularPrice: variation['regular_price'],
            salePrice: variation['sale_price'],
            onSale: variation['on_sale'],
            stockQuantity: variation['stock_quantity'],
            stockStatus: variation['stock_status'],
            shippingClass: variation['shipping_class'],
            shippingClassId: variation['shipping_class_id'],
            attributes: attributes));
      }
    } catch (e) {
      print('var error: ' + e.toString());
    }
    print(variations.length);
    return variations;
  }

  Future<String> getOptionSlug({attributeId, optionName}) async {
    String slug = '';

    try {
      http.Response response = await http.get(
          'https://www.qarinli.com/wp-json/wc/v3/products/attributes/$attributeId/terms?search=$optionName',
          headers: <String, String>{'authorization': basicAuth});
      var responseBody = await json.decode(response.body);

      if (responseBody is List<dynamic> || responseBody['message'] == null) {
        for (var res in responseBody) {
          if (optionName == res['name']) {
            slug = res['slug'];
          }
        }
      } else {
        return '';
      }
    } catch (_) {
      return '';
    }
    return slug;
  }
}
