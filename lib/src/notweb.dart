import 'shim.dart';
import 'dart:io';
import 'package:file/local.dart';

PlatformLite defaultOptions() {
  return PlatformLite(
    cores: Platform.numberOfProcessors,
    memory: 0,
  );
}
