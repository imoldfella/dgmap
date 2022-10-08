import 'package:file/file.dart';
import 'shim.dart';
import 'dart:async';

// encode a tuple into an address and a Uint8List
// class Address {
//   String street, city, state, zip, country;
// }
Future<void> emptyPromise() async{}

geocode(String infile, String temp) {}

class CsvDescription {
  final int country,zip,address, state;
  final List<int> keep;

  CsvDescription(this.country, this.zip, this.address, this.state, this.keep);
}

// write and read things from coworkers, wait for them to finish
class Coworker {
  int stage = 0;
  late List<RandomAccessFile> f=[];
  late List<Future<void>> promise = [];
  Coworker(this.f, this.promise);
  int get length => f.length >> 1;

  Future<void> barrier() async {
    // flush all the completed files
    var o = (stage & 1)*length;
    for (int i=0; i<length; i++) {
      promise[i] = f[i+o].flush();
    }
    Future.wait(promise);
    // wait.

    // truncate all the files we are writing to for this phase
    stage++;
     o = (stage & 1)*length;
    for (int i=0; i<length; i++) {
      f[i+o].truncate(0);
    }
  }


  static Future<Coworker> open(FileSystem fs, String root, int me,int workers)  async { 
    final promise = List<Future<void>>.filled(workers,emptyPromise());
    List<RandomAccessFile> f = [];
    for (int i=0; i<workers*2; i++) {
      final a = await fs.file("$root-$i").open(mode: FileMode.write);
      f.add(a);
  }
  return Coworker(f,promise);
}


splitFileFork(Coworker j, JobDesc o, int me) async {
  final f = await fs().file(o.input).open();
  int len = await f.length();
  int chunk = len ~/ o.workers;
  int start = chunk * me;
  int end = me+1==o.workers?len: (chunk+1)*me;

  // read our chunk of lines the input file(s)
  // write them to the appropriate worker for the next state
  

  // open a files to pass data to to each of the other workers: WxWxS files
  await j.barrier();
  for ( ) {
    // geocode each shard. reshard the data according the zoom tile


  }
  await j.barrier();
  for ( ) {
    // build each zoom tile respecting the maximum file size for pieces
  }
}

// splitCsv(String infile, List<int> fields, {Options? options}) async {
//   final o = options ?? defaultOptions();
//   final s = await fs().file(infile).open();
//   var l = await s.length()
//   l = l / o.threads;

//   // give a piece of the file to each core.
//   final j = <Job>[];
//   await par(j);
// }
