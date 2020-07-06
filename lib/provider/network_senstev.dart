import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/enums/enum.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;

  NetworkSensitive({
    this.child,
    this.opacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi) {
      return child;
    }

    if (connectionStatus == ConnectivityStatus.Data) {
      return child;
    }
    if (connectionStatus == ConnectivityStatus.Offline) {
      return SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            child,
            Positioned(
              left: 0.0,
              right: 0.0,
              height: 20.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: Color(0xFFEE4400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "No internet Connection",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      width: 12.0,
                      height: 12.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Opacity(
      opacity: 0.1,
      child: child,
    );
  }
}
