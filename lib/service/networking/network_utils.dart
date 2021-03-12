import 'dart:convert';
import 'dart:io';

import 'package:frontliner/constants.dart';
import 'package:frontliner/service/networking/endpoints.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

/// Variables
var accessAllowed = false;
const noInternetMsg = 'You are not connected to Internet';
const errorMsg = 'Please try again later.';

bool isSuccessful(int code) {
  return code >= 200 && code <= 206;
}

Future<Response> getRequest(String endPoint, {bool bearerToken = false, bool noBaseUrl = false}) async {
  if (await isNetworkAvailable()) {
    var headers;
    Response response;
    var accessToken = API_KEY;
    print(accessToken);

    if (bearerToken) {
      headers = {HttpHeaders.acceptHeader: 'application/json; charset=utf-8', "Authorization": "Token $accessToken"};
    }

    print('URL: $BASE_URL$endPoint');
    print('Header: $headers');

    if (bearerToken) {
      response = await get('$BASE_URL$endPoint', headers: headers);
    } else if (noBaseUrl) {
      response = await get('$endPoint');
    } else {
      response = await get('$BASE_URL$endPoint');
    }

    print('Response: ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw noInternetMsg;
  }
}

Future handleResponse(Response response) async {
  if (!await isNetworkAvailable()) {
    throw noInternetMsg;
  }
  if (isSuccessful(response.statusCode)) {
    if (response.body.isNotEmpty) {
      //print('isNotEmpty : ${response.body}');
      return jsonDecode(response.body);
    } else
      return response.body;
  } else {
    if (response.body.isJson()) {
      print("handleResponse: ${jsonDecode(response.body)}");
      toast("Something went wrong. Try Again");
      return response.statusCode;
    } else {
      print("handleResponse: ${jsonDecode(response.body)}");
      return response.statusCode;
    }
  }
}

Future<bool> isJsonValid(json) async {
  try {
    var f = jsonDecode(json) as Map<String, dynamic>;
    return true;
  } catch (e) {
    print(e.toString());
  }
  return false;
}
