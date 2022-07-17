import 'dart:async';
import 'package:conduit/conduit.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_KeyPair", [SchemaColumn("public", ManagedPropertyType.string, isPrimaryKey: true, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_Previous", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false)]));
		database.addColumn("_Previous", SchemaColumn.relationship("keypair", ManagedPropertyType.string, relatedTableName: "_KeyPair", relatedColumnName: "public", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    