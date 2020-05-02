#!/bin/bash
echo "Init Mongo replicaset ..."
mongo -- "$MONGO_INITDB_DATABASE" <<EOF
	var rootUser = '$MONGO_INITDB_ROOT_USERNAME';
	var rootPasswd = '$(cat $MONGO_INITDB_ROOT_PASSWORD_FILE)';
	use admin;
	db.auth(rootUser, rootPasswd);
    rs.initiate({ _id: "replicaMongo",version: 1,  members: [ { _id: 0, host : "$HOSTNAME:27017" }, ] });
    db.getCollection('$MONGO_INITDB_DATABASE').insert({ "foo": "bar" });
EOF
echo "Init Mongo Replica Done"  >> /home/init_mongo_rs_script.txt


rs.initiate({
 _id: 'rs0',
 members: [
 {
  _id: 0, host: 'replicas_shards_mongo_mongo1:27017'
 }
 ]
})