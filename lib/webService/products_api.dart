import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/products_model.dart';

class ProductsApi{
  final Dio dio = Dio();
 final baseUrl="https://dummyjson.com";
  // late ProductModel productFromApi;
 Future<ProductModel> getAllProducts()async{
   try {
     Response<dynamic> response=await dio.get("$baseUrl/products",
          queryParameters: {
           "select":"title,description,category,price,thumbnail",
            "limit":10
          });
     return  ProductModel.fromJson(response.data);

   }
    catch (e) {
     if (kDebugMode) {
       print("error:$e");
     }rethrow;
   }
  }


 Future userLogIn({required username,required password})async{
   FormData formData=FormData.fromMap(
       {
         "username":username,
         "password":password,
       }
   );
  try {
   final response= await dio.post("$baseUrl/auth/login",
        data:formData);
   print(response.statusCode);

   print(response.data);
   return response.data;
  } catch (e) {
    if (kDebugMode) {
      print("Error:$e");
    }
    rethrow;
  }
  }


}

