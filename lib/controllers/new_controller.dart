
import 'package:db/db.dart';
import 'package:dio/dio.dart' as d;

import '../models/config.dart';
import '../models/keypair.dart';
class NewController extends ResourceController {
  Config config;
  ManagedContext context;
  NewController(this.config, this.context);
  @Operation.post('previous')
  Future<Response> newKeyPair(@Bind.path('previous') String previous) async {
    final keypairQuery = Query<Keypair>(context)..where((x) => x.public).equalTo(previous)..join(set: (kp) => kp.previous);
    final keypair = await keypairQuery.fetchOne();
    if (keypair == null) {
      final seedKeypairQuery = Query<Keypair>(context)..values.public = previous;
      final seedKeypair = await seedKeypairQuery.insert();
      final trascan = await d.Dio().post('${config.gladiatorurl}/transaction-fixum', data: {
          "from": config.private,
          "to": seedKeypair.public,
          "gla": 1
      });
      final neschew = await d.Dio().get('${config.gladiatorurl}/rationem');
      final neschewKeyPairQuery = Query<Keypair>(context)..values.public = neschew.data['publicaClavis'] as String;
      final neschewKeyPair = await neschewKeyPairQuery.insert();
      final preschevvQuery = Query<Previous>(context)..values.keypair = neschewKeyPair;
      final preschev = await preschevvQuery.insert();
      return Response.ok({
        "private": neschew.data['privatusClavis'],
        "public": neschew.data['publicaClavis']
      });
    } else {
      final neschew = await d.Dio().get('${config.gladiatorurl}/rationem');
      final nkpq = Query<Keypair>(context)..values.public = neschew.data['publicaClavis'] as String;
      
      final nkp = await nkpq.insert();
      for (int i = 0; i < keypair.previous!.length; i++) {
          final okpq = Query<Keypair>(context)..where((i) => i.public).equalTo(keypair.previous![i].keypair!.public);
          final okp = await okpq.fetchOne();
          final pq =  Query<Previous>(context)
            ..values.keypair = okp; 
          final p = await pq.insert();
      }
      return Response.ok({
        "private": neschew.data['privatusClavis'],
        "public": neschew.data['publicaClavis']
      });
    }
  } 
}