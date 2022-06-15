import 'package:ubenwa_cart/data/network/routes.dart';
import 'package:ubenwa_cart/data/services/http_service.dart';

class InfantServices {
  Future<dynamic> fetchInfants() async {
    final responseData =
        await HttpService.getVerb(Routes.infants, addAuthToken: true);
    return HttpService.parseResponse(responseData);
  }

  Future<dynamic> addInfants(data) async {
    final responseData = await HttpService.postVerb(Routes.infants,
        addAuthToken: true, body: data);
    return HttpService.parseResponse(responseData);
  }
}
