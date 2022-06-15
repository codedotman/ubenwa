import 'dart:math';

import 'package:ubenwa_cart/data/models/add_infant_request.dart';
import 'package:ubenwa_cart/data/services/infant_services.dart';
import 'package:ubenwa_cart/utils/strings.dart';

class InfantUploadController {
  var list = ['male', 'female'];

  uploadInfantDetails() async {
    final _random = Random();
    var element = list[_random.nextInt(list.length)];

    try {
      await InfantServices().addInfants(AddInfantRequest(
          data: Data(
              type: "newborns",
              attributes: InfantAttributes(
                  name: "Baby ${generateRandomString(4)}",
                  gender: element,
                  gestation: DateTime.now().toIso8601String()))));
    } catch (ex) {}
  }
}
