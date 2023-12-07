package pt.ua.cbd.lab4.ex4;

import org.neo4j.driver.AuthTokens;
import org.neo4j.driver.Driver;
import org.neo4j.driver.GraphDatabase;
import org.apache.commons.csv.*;

import java.io.FileReader;
import java.io.IOException;

import static org.neo4j.driver.Values.parameters;

public class Main implements AutoCloseable{
    private final Driver driver;

    public Main(String uri, String user, String password){
        driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password));
    }

    @Override
    public void close() throws RuntimeException {
        driver.close();
    }

    private void loadCSV(String file) {

        try (var session = driver.session()){
            var csvParser = CSVFormat.DEFAULT.parse(new FileReader(file));
            var records = csvParser.getRecords();

            for (var record: records){
                var query = "CREATE (a:User {id: $id1})-[r:FRIEND]->(b:User {id: $id2})";
                session.run(query, parameters("id1", record.get(0), "id2", record.get(1)));
            }

        } catch (IOException e){
            System.err.println("Error: " + e.getMessage());
        }
    }

    public static void main(String... args) {
        try (var loader = new Main("bolt://localhost:7687", "neo4j", "password")) {
            loader.loadCSV("file.csv");
        } catch (Exception e){
            System.err.println("Error loading data: " + e.getMessage());
        }
    }
}