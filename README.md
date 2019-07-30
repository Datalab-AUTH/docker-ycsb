# docker-ycsb
YCSB running on maven:3.6.1-jdk-8-slim that uses openjdk:8-jdk-slim.

### Getting Started

###### Command line example:
```
docker run -t --name ycsb-loadgen \
-e ACTION='load' \
-e DBTYPE='redis' \
-e WORKLETTER='a' \
-e DBARGS='-p redis.host=10.0.0.1' \
rijalati/alpine-ycsb:latest
```

You need to pass these four environment variables:
  * `ACTION`
    * `load`, `run`
  * `DBTYPE`
    * `accumulo`
    * `aerospike`
    * `arangodb`
    * `arangodb3`
    * `asynchbase`
    * `azuredocumentdb`
    * `basic`
    * `cassandra-cql`
    * `cassandra2-cql`
    * `cloudspanner`
    * `couchbase`
    * `couchbase2`
    * `dynamodb`
    * `elasticsearch`
    * `geode`
    * `googlebigtable`
    * `googledatastore`
    * `hbase094`
    * `hbase098`
    * `hbase10`
    * `hbase12`
    * `hypertable`
    * `infinispan`
    * `infinispan-cs`
    * `jdbc`
    * `kudu`
    * `mapkeeper`
    * `memcached`
    * `mongodb`
    * `mongodb-async`
    * `nosqldb`
    * `orientdb`
    * `rados`
    * `redis`
    * `rest`
    * `riak`
    * `s3`
    * `solr`
    * `solr6`
    * `tarantool`
    * `voldemort`
  * `WORKLETTER`
    * `a`, `b`, `c`, `d`, `e`, `f`
  * `DBARGS`
    * `DBARGS` are dependent on the `DBTYPE` you selected
    * See https://github.com/brianfrankcooper/YCSB
    * MUST BE SURROUNDED WITH QUOTES.
    * `'-p KEY0=VALUE0 -p KEY1=VALUE1'`
    
### SSL support for mongodb
  * `DBTYPE`
    * `mongodb`
    * `mongodb-async`
 
  * SSL usage
    * Mount ca.pem in /etc/ssl
    * `-p mongodb.url='mongodb://<dbusername>:<dbpassword>@<dbhost>:<dbport>/admin?w=0&ssl=true'`
  * No SSL usage
    * `-p mongodb.url='mongodb://<dbusername>:<dbpassword>@<dbhost>:<dbport>/admin?w=0'`
  
This repo is heavily based on https://github.com/BlueMedoraPublic/alpine-ycsb.
