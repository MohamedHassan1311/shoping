import 'package:shoping/responsive/dvise_info.dart';

double HeadTitel(DeviceInfo deviceInfo) {
//  DeviceInfo deviceInfo;
  var size = 20.0;
  if (deviceInfo.screenHeight < 570) {
    size = 15;
  }
  if (deviceInfo.screenHeight >= 950) {
    return size = 40.0;
  }
  if (deviceInfo.screenHeight < 820 && deviceInfo.screenHeight > 570) {
    return size = 20;
  }
  return size;
}

double SubTitel(DeviceInfo deviceInfo) {
//  DeviceInfo deviceInfo;
  var size = 15.0;
  if (deviceInfo.screenHeight < 570) {
    size = 15;
  }

  if (deviceInfo.screenHeight < 820 && deviceInfo.screenHeight > 570) {
    return size = 16.0;
  }
  if (deviceInfo.screenWidth >= 600) {
    return size = 20;
  }
  return size;
}
