package pt.ua.cbd.lab4.ex4;

import org.neo4j.driver.*;
import org.neo4j.driver.Record;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Map;

public class NetflixGraph {
    /*private final Driver driver;

    public Main(String uri, String user, String password){
        driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password));
    }

    @Override
    public void close() throws RuntimeException {
        driver.close();
    }*/

    private static void loadCSV(Session session, String file) {


        String load_csv = "LOAD CSV WITH HEADERS FROM '" + file + "' AS csvLine " +
        "MERGE (sh:Show {show_title: csvLine.show_title, season_title: csvLine.season_title}) "+
        "MERGE (ct:Country {country_name: csvLine.country_name, country_iso2: csvLine.country_iso2}) "+
        "MERGE (wk:Week {week: csvLine.week, cumulative_weeks_in_top_10: toInteger(csvLine.cumulative_weeks_in_top_10) }) "+
        "MERGE (wr:WeeklyRank {weekly_rank: toInteger(csvLine.weekly_rank)}) "+
        "MERGE (cat:Category {category: csvLine.category}) " +
        "MERGE (sh) -[:RANKED]-> (wr) " +
        "MERGE (sh) -[:CATEGORIZED]-> (cat) " +
        "MERGE (sh) -[:FEATURED]-> (wk) ";

        session.run(load_csv, Values.parameters("file", file));
        System.out.println(">> All data inserted!");
    }

    public static void main(String... args) throws IOException {

        String user = "neo4j";
        String password = "password";
        String address = "bolt://localhost:7687";
        String file_path = "file:///resources/all-weeks-countries.csv";
        FileWriter fr = new FileWriter("CBD_L44c_output.txt");

        Driver driver = GraphDatabase.driver( address, AuthTokens.basic( user, password ) );
        Session session = driver.session();
        System.out.println(">> Connected to Neo4j!");


        loadCSV(session, file_path);

        //Querie 1
        fr.write("1. Listar todos os shows que contenham a palavra 'The' no titulo. \n");

        String query1 = "MATCH (sh:Show) " +
                        "WHERE sh.show_title CONTAINS 'The' " +
                        "RETURN sh.show_title AS Movies";

        Result result = session.run(query1);

        for (Record rec: result.list()){
            String data = rec.get("Movies").toString() + "\n";
            fr.write(data);
        }

        //Querie 2
        fr.write("\n 2. Listar todos os filmes (category = 'Films') ordenados descendentemente pelo nome do show. \n");

        String query2 = "MATCH (sh:Show)-[:CATEGORIZED]->(cat:Category {category:'Films'}) " +
                        "RETURN sh.show_title AS Movies " +
                        "ORDER BY Movies DESC";

        Result result2 = session.run(query2);

        for (Record rec: result2.list()){
            String data = rec.get("Movies").toString() + "\n";
            fr.write(data);
        }

        //Querie 3
        fr.write("\n 3. Listar todos os shows que tenham mais do que 3 weekly ratings. \n");

        String query3 = "MATCH (sh:Show)-[:RANKED]->(wk) " +
                        "WHERE wk.weekly_rank > 3 " +
                        "RETURN sh.show_title AS Shows, wk.weekly_rank AS Weekly_Rank " +
                        "ORDER BY wk.weekly_rank DESC";

        Result result3 = session.run(query3);

        for (Record rec: result3.list()){
            String data = rec.get("Shows").toString() + " | " + rec.get("Weekly_Rank") + "\n";
            fr.write(data);
        }

        //Querie 4
        fr.write("\n 4. Listar todos os shows de 2023 foram lançados em cada dia. \n");

        String query4 = "MATCH (sh:Show)-[:FEATURED]->(wk:Week) " +
        "WHERE wk.week STARTS WITH '2023' " +
        "RETURN wk.week AS Days, collect(sh.show_title) AS Shows";

        Result result4 = session.run(query4);

        for (Record rec: result4.list()){
            String data = rec.get("Days").toString() +  " | " + rec.get("Shows") + '\n';
            fr.write(data);
        }

        //Querie 5
        fr.write("\n 5. Mostrar a contagem dos TV shows no total. \n");

        String query5 = "MATCH (sh:Show)-[:CATEGORIZED]->(ct:Category {category: 'TV'}) " +
                        "RETURN count(sh) AS Number_TVShows, collect(sh.show_title) AS Shows";

        Result result5 = session.run(query5);

        for (Record rec: result5.list()){
            String data = rec.get("Number_TVShows").toString() + " | " + rec.get("Shows") + '\n';
            fr.write(data);
        }

        //Querie 6
        fr.write("\n 6.Qual a média de weekly ranks dos shows? \n");

        String query6 = "MATCH (sh:Show)-[:RANKED]->(wk:WeeklyRank) " +
                        "RETURN avg(toFloat(wk.weekly_rank)) AS Media";

        Result result6 = session.run(query6);

        for (Record rec: result6.list()){
            String data = rec.get("Media").toString() + '\n';
            fr.write(data);
        }

        //Querie 7
        fr.write("\n 7.Listar os shows que não tiveram rank? \n");

        String query7 = "MATCH (sh:Show)-[:FEATURED]->(wk:Week) " +
                        "WHERE NOT (sh)-[:RANKED]->(:WeeklyRank)" +
                        "RETURN DISTINCT sh.show_title AS Shows";

        Result result7 = session.run(query7);

        for (Record rec: result7.list()){
            String data = rec.get("Shows").toString() + '\n';
            fr.write(data);
        }

        //Querie 8
        fr.write("\n 8.Qual o caminho mais curto entre os Shows Elite e The Killer? \n");

        String query8 = "MATCH p=shortestPath((sh:Show {show_title:'Elite'})-[*]-(sh2:Show {show_title: 'The Killer'})) " +
                        "RETURN collect(length(p)) AS path ";

        Result result8 = session.run(query8);

        for (Record rec: result8.list()){
            String data = rec.get("path").toString() + '\n';
            fr.write(data);
        }

        //Querie 9
        fr.write("\n 9.Quais os shows que têm o caminho de 3 com o show 'Summer Vacation'? \n");

        String query9 = "MATCH path = shortestPath((sh:Show {show_title: 'Summer Vacation'})-[*..3]-(sh2:Show)) " +
                        "WHERE sh <> sh2 " +
                        "RETURN sh2.show_title AS Shows";

        Result result9 = session.run(query9);

        for (Record rec: result9.list()){
            String data = rec.get("Shows").toString() + '\n';
            fr.write(data);
        }

        //Querie 10
        fr.write("\n 10.Quantas temporadas tem cada show? \n");

        String query10 = "MATCH (sh:Show) " +
                         "RETURN sh.show_title AS Shows, count(sh.season_title) AS Seasons";

        Result result10 = session.run(query10);

        for (Record rec: result10.list()){
            String data = rec.get("Shows").toString() + " | " + rec.get("Seasons").toString() + '\n';
            fr.write(data);
        }

        fr.close();
        driver.close();
        System.out.println(">> Exiting Neo4j!");
    }
}