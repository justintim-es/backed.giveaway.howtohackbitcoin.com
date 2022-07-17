import 'package:conduit/conduit.dart';
import 'package:db/db.dart';

class Config extends Configuration {
  Config(String fileName): super.fromFile(File(fileName));

  String? gladiatorurl;
  
  
  String? private;

  String? public;

  String? filename;
}