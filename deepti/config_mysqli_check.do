<?php
//$data['cid']=null;

function db_connect(){
	global $data;
	if(@$data['connection_type']=='PSQL')
		return db_connect_psql();
	else return db_connect_mysqli();
}// End function



function db_disconnect(){
	global $data;
	if(@$data['connection_type']=='PSQL')
		return db_disconnect_psql();
	else return db_disconnect_mysqli();
}

function db_query($statement,$print=false){
	global $data;
	if(@$data['connection_type']=='PSQL')
		return db_query_psql($statement,$print);
	else return db_query_mysqli($statement,$print);
}

function newid(){
	global $data;
	if(@$data['connection_type']=='PSQL')
		return newid_psql();
	else return newid_mysqli();
}

function db_count($result){
	global $data;
	if(@$data['connection_type']=='PSQL')
		return db_count_psql($result);
	else return db_count_mysqli($result);
}

function db_rows($statement,$print=false) {
	global $data;
	if(@$data['connection_type']=='PSQL')
		return db_rows_psql($statement,$print);
	else return db_rows_mysqli($statement,$print);
}


?>