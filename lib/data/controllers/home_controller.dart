import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ubenwa_cart/data/models/infants_response.dart';
import 'package:ubenwa_cart/data/resource.dart';
import 'package:ubenwa_cart/data/services/infant_services.dart';

class HomeController with ChangeNotifier {
  final InfantServices _infantServices = InfantServices();
  late BehaviorSubject<Resource> _homeResourceStateController;
  Stream<Resource> get homeResourceState => _homeResourceStateController;
  List<InfantDataList>? infantList;

  HomeController() {
    _homeResourceStateController =
        BehaviorSubject<Resource>.seeded(Resource.success(null));
    fetchInfants();
  }

  fetchInfants() async {
    _homeResourceStateController.sink.add(Resource.loading(null));
    try {
      var res = await _infantServices.fetchInfants();
      var data = InfantsResponse.fromJson(res);
      infantList = data.data!;
      _homeResourceStateController.sink.add(Resource.success(data.data));
    } catch (ex) {
      _homeResourceStateController.sink
          .add(Resource.error(errorMessage: ex.toString()));
    }
  }
}
