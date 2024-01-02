import 'dart:async' show FutureOr;
import 'dart:io' show InternetAddress, SocketException;

import 'package:connectivity_plus/connectivity_plus.dart' show Connectivity, ConnectivityResult;
import 'package:flutter_riverpod/flutter_riverpod.dart';



final isConnectionButtonLoading = StateProvider.autoDispose((_) => false);
