import 'package:e_books/api/api.dart';
import 'package:e_books/api/api_request/api_request.dart';
import 'package:e_books/models/user.dart';

abstract interface class ICategoriesService {
  Future<Map<String, dynamic>?> getCategories();
}

class CategoriesService implements ICategoriesService {
  CategoriesService._();
  static final _instance = CategoriesService._();
  factory CategoriesService() => _instance;

  final Api _api = Api(JsonRequestStrategy());
  final String _mainPath = "/categories";

  @override
  Future<Map<String, dynamic>?> getCategories() async {
    final String? token = User().token?.value;
    final ApiRequest apiRequest = JsonRequest(
      method: GET,
      path: "$_mainPath/",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    final reponse = await _api.send(apiRequest: apiRequest);
      
    
    return reponse;
  }
}
