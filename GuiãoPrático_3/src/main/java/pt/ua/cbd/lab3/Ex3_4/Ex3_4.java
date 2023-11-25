package pt.ua.cbd.lab3.Ex3_4;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.schemabuilder.CreateKeyspace;
import com.datastax.oss.driver.api.core.CqlSession;

public class Ex3_4 {

    //Create keyspace
    CreateKeyspace keyspace = new CreateKeyspace("Ex3_4").ifNotExists();

    try (CqlSession session = CqlSession.builder().withKeyspace(keyspace.toString()).build() {

        ResultSet table = session.execute("CREATE TABLE users +
                "(\n" +
                "    username  text PRIMARY KEY ,\n" +
                "    name  text,\n" +
                "    email  text,\n" +
                "    selo_temporal timestamp\n" +
                ");")

    }
}

