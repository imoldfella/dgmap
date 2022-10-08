import 'package:file/file.dart';

class PlatformLite {
  int cores;
  int memory;
  PlatformLite({required this.cores, required this.memory});
}

class JobDesc {
  String input;
  int workers;
  int shards; // each worker will process S shards. this reduces memory pressure.
  var columns = <int>[];

  JobDesc({required this.workers, required this.input, required this.columns, required this.shards})
}

PlatformLite defaultOptions() {
  throw "not implemented";
}

FileSystem fs() {
  throw "not implemented";
}

Future<void> par<T>(List<T> job) async {
  throw "not implemented";
}

class Jobber {
  barrier() async {}
}
