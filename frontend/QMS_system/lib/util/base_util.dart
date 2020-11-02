
import 'dart:math';

class BaseUtil {
  BaseUtil._();

  static String getCurrentTimestamp() {
    int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    var rng = new Random();
    currentTimeStamp += rng.nextInt(10000);
    return currentTimeStamp.toString();
  }

  static String getRiskEstimationKey(String probabilityId, String severityId) {
    return probabilityId + "-" + severityId;
  }
}