import 'package:ubenwa_cart/data/network/routes.dart';
import 'package:ubenwa_cart/data/services/http_service.dart';

class AuthService {
  Future<dynamic> loginUser(data) async {
    final responseData = await HttpService.postVerb(Routes.login,
        body: data, addAuthToken: false);
    return HttpService.parseResponse(responseData);
  }

  Future<dynamic> registerUser(data) async {
    final responseData = await HttpService.postVerb(Routes.register,
        body: data, addAuthToken: false);
    return HttpService.parseResponse(responseData);
  }
}
