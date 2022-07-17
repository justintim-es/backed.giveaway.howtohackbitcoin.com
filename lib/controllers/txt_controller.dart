import 'package:db/db.dart';
import 'package:db/models/config.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart' as d;
class Txt {
  String public;
  List<String> previous;
  Txt(this.public, this.previous);

  Map<String, dynamic> toJson() => {
    'public': public,
    'previous': previous
  };
  Txt.fromJson(dynamic maschap):
    public = maschap['public'].toString(),
    previous = List<String>.from(maschap['previous'] as List<dynamic>);
}

class TxtController extends ResourceController {
  Config config;
  TxtController(this.config);

  @Operation.post('previous')
  Future<Response> preschev(@Bind.path('previous') String previous) async {
    File txt = await File(config.filename).create( recursive: true);
    final Stream<String> lines = txt.openRead().transform(utf8.decoder).transform(const LineSplitter());
    final neschew = await d.Dio().get('${config.gladiatorurl}/rationem');
    bool should = false;
    await for (String line in lines) {
      final Txt previousTxt = Txt.fromJson(json.decode(line));
      if (previousTxt.public == previous) {
        final sink = txt.openWrite(mode: FileMode.append);
        previousTxt.previous.add(previous);
        for (String preschev in previousTxt.previous) {
          final trascan = await d.Dio().post('${config.gladiatorurl}/transaction-fixum', data: {
            "from": config.private,
            "to": preschev,
            "gla": 51
          });
        }
        final Txt neschewTxt = Txt(neschew.data['publicaClavis'] as String, previousTxt.previous);
        sink.write('${json.encode(neschewTxt.toJson())}\n');
        await sink.close();
        should = true;
      }
    }
    if(!should) {
        final Txt firstTxt = Txt(neschew.data['publicaClavis'] as String, []);
        final sink = txt.openWrite(mode: FileMode.append);
        sink.write('${json.encode(firstTxt.toJson())}\n');
        await sink.close();
    }
    return Response.ok({
      "private": neschew.data['privatusClavis'],
      "public": neschew.data['publicaClavis']
    });
  }
}