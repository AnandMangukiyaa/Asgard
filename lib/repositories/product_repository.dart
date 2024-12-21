import 'package:asgard_assignment/core/constants/api_urls.dart';
import 'package:asgard_assignment/core/helpers/helpers.dart';
import 'package:asgard_assignment/models/models.dart';
import 'package:asgard_assignment/services/services.dart';

class ProductRepository {
HttpService _service = HttpService();


  Future<List<Product>> getProducts() async{
    try{
      var data = [
        {
          "userId": "1",
          "id": "1",
          "title": "Sample title 1",
          "body": "Sample body content for item 1",
          "coordinates": [
            21.579864,
            73.100000
          ],
          "imageUrl": "https://via.placeholder.com/150/FF0000"
        },
        {
          "userId": "1",
          "id": "2",
          "title": "Sample title 2",
          "body": "Sample body content for item 2",
          "coordinates": [
            21.385000,
            72.900000
          ],
          "imageUrl": "https://via.placeholder.com/150/00FF00"
        },
        {
          "userId": "1",
          "id": "3",
          "title": "Sample title 3",
          "body": "Sample body content for item 3",
          "coordinates": [
            21.492300,
            73.210000
          ],
          "imageUrl": "https://via.placeholder.com/150/0000FF"
        },
        {
          "userId": "1",
          "id": "4",
          "title": "Sample title 4",
          "body": "Sample body content for item 4",
          "coordinates": [
            21.333000,
            73.050000
          ],
          "imageUrl": "https://via.placeholder.com/150/FFFF00"
        },
        {
          "userId": "1",
          "id": "5",
          "title": "Sample title 5",
          "body": "Sample body content for item 5",
          "coordinates": [
            21.575000,
            73.001000
          ],
          "imageUrl": "https://via.placeholder.com/150/FF00FF"
        },
        {
          "userId": "1",
          "id": "6",
          "title": "Sample title 6",
          "body": "Sample body content for item 6",
          "coordinates": [
            21.483500,
            72.850000
          ],
          "imageUrl": "https://via.placeholder.com/150/00FFFF"
        },
        {
          "userId": "1",
          "id": "7",
          "title": "Sample title 7",
          "body": "Sample body content for item 7",
          "coordinates": [
            21.670000,
            73.050000
          ],
          "imageUrl": "https://via.placeholder.com/150/800080"
        },
        {
          "userId": "1",
          "id": "8",
          "title": "Sample title 8",
          "body": "Sample body content for item 8",
          "coordinates": [
            21.490000,
            73.300000
          ],
          "imageUrl": "https://via.placeholder.com/150/FFA500"
        },
        {
          "userId": "1",
          "id": "9",
          "title": "Sample title 9",
          "body": "Sample body content for item 9",
          "coordinates": [
            21.410000,
            72.950000
          ],
          "imageUrl": "https://via.placeholder.com/150/FFD700"
        },
        {
          "userId": "1",
          "id": "10",
          "title": "Sample title 10",
          "body": "Sample body content for item 10",
          "coordinates": [
            21.540000,
            73.100000
          ],
          "imageUrl": "https://via.placeholder.com/150/008000"
        }
      ];
      return productFromJson(data);
      /*Result response = await _service.request(requestType: RequestType.get, url: ApiUrls.getProducts);
      if(response is Success){
        return productFromJson(response.value);
      }else{
        return [];
      }*/
    }catch (e){
      return [];
    }
  }

Future<List<Product>> getProductsForTesting() async{
  try{

    Result response = await _service.request(requestType: RequestType.get, url: ApiUrls.baseUrl);
      if(response is Success){
        return productFromJson(response.value);
      }else{
        return [];
      }
  }catch (e){
    return [];
  }
}


Future<List<Product>> getProductsForFailureTesting() async{
  try{

    Result response = await _service.request(requestType: RequestType.get, url: ApiUrls.baseUrl);
    if(response is Success){
      return [];
    }else{
      return [];
    }
  }catch (e){
    return [];
  }
}

}
