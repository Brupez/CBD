package pt.edu.ua.ies.s92972.lab3;

import com.datastax.oss.driver.api.core.CqlIdentifier;
import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.CqlSessionBuilder;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.SimpleStatement;
import com.datastax.oss.driver.api.querybuilder.QueryBuilder;
import com.datastax.oss.driver.api.querybuilder.QueryBuilder.*;
import com.datastax.oss.driver.api.querybuilder.insert.InsertInto;
import com.datastax.oss.driver.api.querybuilder.insert.JsonInsert;
import com.datastax.oss.driver.api.querybuilder.relation.Relation;
import com.datastax.oss.driver.api.querybuilder.select.Select;
import com.datastax.oss.driver.api.querybuilder.select.Selector;

import java.net.InetSocketAddress;
import java.util.HashSet;
import java.util.Set;

import static com.datastax.oss.driver.api.querybuilder.QueryBuilder.literal;

/**
 * This class handles and manages the session with Cassandra DB
 */
public class CassandraConnector {

    private CqlSession session;

    public CassandraConnector(String node, Integer port, String dataCenter, String keyspace) {
        // Open session
        CqlSessionBuilder builder = CqlSession.builder();
        builder.addContactPoint(new InetSocketAddress(node, port));
        builder.withLocalDatacenter(dataCenter);
        session = builder.build();
        // Use keyspace
        session.execute("USE " + CqlIdentifier.fromCql(keyspace));
    }

    // Handle session
    public CqlSession getSession() {
        return this.session;
    }

    public void close() {
        session.close();
    }

    // Queries
    public ResultSet executeStatement(SimpleStatement statement) {
        return session.execute(statement);
    }

    public ResultSet selectAll(String table) {
        Select select = QueryBuilder.selectFrom(table).all();
        ResultSet resultSet = this.executeStatement(select.build());
        return resultSet;
    }

    public ResultSet select(String table, String col, String val) {
        Select select = QueryBuilder.selectFrom(table).all().whereColumn(col).isEqualTo(literal(val));
        ResultSet resultSet = this.executeStatement(select.build());
        return resultSet;
    }

    public ResultSet select(String table, Set<Relation> whereClauses, Set<Selector> selectorClauses, int limit, boolean filtering) {
        Select select = QueryBuilder.selectFrom(table).all();
        if (whereClauses!=null)
            select = select.where(whereClauses);
        if (selectorClauses!=null)
            select = select.selectors(selectorClauses);
        if (limit!=0)
            select = select.limit(limit);
        if (filtering)
            select = select.allowFiltering();
        return this.executeStatement(select.build());
    }

    public ResultSet insert(String table, String json) {
        JsonInsert insert = QueryBuilder.insertInto(table).json(json);
        ResultSet resultSet = this.executeStatement(insert.build());
        return resultSet;
    }
}
