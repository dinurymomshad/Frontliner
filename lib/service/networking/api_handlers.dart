import 'package:frontliner/service/networking/endpoints.dart';

import 'network_utils.dart';

Future getNews() async {
  return handleResponse(await getRequest(END_POINT));
}
