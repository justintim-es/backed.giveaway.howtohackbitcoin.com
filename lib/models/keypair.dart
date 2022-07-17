import 'package:conduit/conduit.dart';

class Keypair extends ManagedObject<_KeyPair> implements _KeyPair {}
class _KeyPair {
  @Column(primaryKey: true)
  String? public;

  ManagedSet<Previous>? previous;
}
class Previous extends ManagedObject<_Previous> implements _Previous {}
class _Previous {
  @primaryKey
  int? id;

  @Relate(#previous)
  Keypair? keypair;
}
  