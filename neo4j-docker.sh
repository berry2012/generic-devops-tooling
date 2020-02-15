
# The Neo4j Docker image, and instructions on how to start using it, can be found here: https://hub.docker.com/_/neo4j/.

# file directories - https://neo4j.com/docs/operations-manual/current/configuration/file-locations/
# /conf
# /data
# /import
# /logs
# /metrics
# /plugins
# /ssl

# The latest Neo4j Enterprise Edition. the /data and /logs volumes mapped to directories on the host

docker run \
    --publish=7474:7474 --publish=7687:7687 \
    --publish=7473:7473 \
    --volume=$HOME/neo4j/data:/data \
    --volume=$HOME/neo4j/logs:/logs \
    --env NEO4J_AUTH=neo4j/<password> \
    ----env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
    neo4j:enterprise

# run neo4j community version as current user
docker run \
    --publish=7474:7474 --publish=7687:7687 \
    --volume=$HOME/neo4j/data:/data \
    --volume=$HOME/neo4j/logs:/logs \
    --user="$(id -u):$(id -g)" \
    neo4j:4.0
