import 'package:cloud_functions/cloud_functions.dart';

class CloudFunctionService {
  Future<String> addSeller(String email) async {
    final HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('addSeller');
    Map<String, dynamic> data = new Map();
    data['email'] = email;

    HttpsCallableResult result = await callable.call(data);
    return result.data.toString();
  }

  Future<String> addBuyer(String email) async {
    final HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('addBuyer');

    Map<String, dynamic> data = new Map();
    data['email'] = email;

    HttpsCallableResult result = await callable.call(data);
    return result.data.toString();
  }
}
