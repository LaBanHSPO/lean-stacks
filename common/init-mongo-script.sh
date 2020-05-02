## init-mongo-script.sh
mongo -- "$MONGO_INITDB_DATABASE" <<EOF
	let error = true;
	use admin;
	var rootUser = '$MONGO_INITDB_ROOT_USERNAME';
    var rootPasswd = '$(cat $MONGO_INITDB_ROOT_PASSWORD_FILE)';

    // create root user
	db.createUser({ user: rootUser, pwd: rootPasswd, roles: [ 
	    { role: "userAdminAnyDatabase", db: "admin" },
	    { role: "dbAdminAnyDatabase", db: "admin" },
	    { role: "readWriteAnyDatabase", db:"admin" },
	    { role: "clusterAdmin",  db: "admin" }
	],
	 mechanisms:[   "SCRAM-SHA-1"] }
	})

    var db = '$MONGO_INITDB_DATABASE';
    var user = '$MONGO_INITDB_USERNAME';
    var passwd = '$(cat $MONGO_INITDB_PASSWORD_FILE)';
    db.createUser( { user, pwd: passwd,roles: [ {  role: "dbOwner", db } ], mechanisms:[  "SCRAM-SHA-1" ] } );

    // finish on terminal review
    if (error) {
  		print('Initial done. Container will restart...')
		quit(1)
	}
EOF