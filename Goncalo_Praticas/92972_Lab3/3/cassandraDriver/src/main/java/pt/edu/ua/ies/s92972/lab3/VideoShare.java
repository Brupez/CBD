package pt.edu.ua.ies.s92972.lab3;

import com.datastax.oss.driver.api.core.cql.ColumnDefinition;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;
import com.datastax.oss.driver.api.core.servererrors.InvalidQueryException;
import com.datastax.oss.driver.api.querybuilder.QueryBuilder;
import com.datastax.oss.driver.api.querybuilder.QueryBuilder.*;
import com.datastax.oss.driver.api.querybuilder.relation.Relation;
import com.datastax.oss.driver.api.querybuilder.select.Selector;

import static com.datastax.oss.driver.api.querybuilder.QueryBuilder.literal;

import java.util.*;

/**
 * Hello world!
 *
 * Run with
 * $ mvn clean package && mvn exec:java -Dexec.mainClass="pt.edu.ua.ies.s92972.lab3.VideoShare"
 */
public class VideoShare
{

    private CassandraConnector cc;
    private Scanner sc;

    // Constructor
    public VideoShare(CassandraConnector cc) {
        this.cc = cc;
        this.sc = new Scanner(System.in);
    }

    // Private methods
    // Queries
    private void selectAll() {
        // Ask user which table does he want to query
        String table = chooseTable();

        // Query all
        try {
            ResultSet results = this.cc.selectAll(table);
            // Output results
            this.printResults(results);
        }
        catch (InvalidQueryException e) {
            System.out.println("ERROR! It was not possible to query the table you selected!");
            System.out.println(e.toString());
        }
    }

    private void search() {
        System.out.println("\nATTENTION! You can only filter by cols that have String values!\n");
        // Ask user which table, column and value does he want to query
        String table = chooseTable();
        String col = input("What column do you want to search by? ");
        String val = inputString("What is the value you want to search by? ");

        // Make query
        try {
            ResultSet results = this.cc.select(table, col, val);
            this.printResults(results);
        }
        catch (InvalidQueryException e) {
            System.out.println("ERROR! That query is not valid!");
            System.out.println(e.toString());
        }
    }

    private void insert() {
        // Ask user which table he wants to insert to and the JSON object that defines the data to insert
        String table = chooseTable();
        System.out.println("\nAttention! You must write the json object as {key:value, key:value}. Spaces between key:value are not accepted!\n");
        String json = inputString("Write the JSON object that defines the row you want to add.\n");

        // Make query
        try {
            this.cc.insert(table, json);
            System.out.println("\nSUCCESS! The object provided was saved at " + table + "!");
        } catch(Exception e) {
            System.out.println("\nERROR! It was not possible to insert the object given: " + e.toString());
        }
    }

    private void queryc7() {
        // SELECT * FROM videos WHERE author='fideliusadorable';
        String user = this.input("\nWhat is the username of the author you want to query? ");

        Set<Relation> where = new HashSet<>();
        where.add(Relation.column("author").isEqualTo(literal(user)));

        ResultSet results = this.cc.select("videos", where, null, 0, false);
        this.printResults(results);
    }

    private void queryd1() {
        // SELECT * FROM comments WHERE videoid=4176 LIMIT 3;
        String video = this.input("\nWhat is the video you want to query? ");
        int id = Integer.parseInt(video);

        Set<Relation> where = new HashSet<>();
        where.add(Relation.column("videoid").isEqualTo(literal(id)));

        ResultSet results = this.cc.select("comments", where, null, 3, false);
        this.printResults(results);
    }

    private void queryd3() {
        // SELECT videoid, tags FROM videos WHERE tags CONTAINS 'Dentistry' ALLOW FILTERING ;
        String tag = this.input("\nWhat is the tag you want to query? ");

        Set<Relation> where = new HashSet<>();
        where.add(Relation.column("tags").contains(literal(tag)));

        Set<Selector> selector = new HashSet<>();
        selector.add(Selector.column("videoid"));
        selector.add(Selector.column("tags"));

        ResultSet results = this.cc.select("videos", where, selector, 0, true);
        this.printResults(results);
    }

    private void queryd4() {
        // SELECT * FROM events  WHERE videoid=5897 AND username='bakerauthentic' LIMIT 5;
        String video = this.input("\nWhat is the video you want to query? ");
        int id = Integer.parseInt(video);
        String user = this.input("What is the username of the author you want to query? ");

        Set<Relation> where = new HashSet<>();
        where.add(Relation.column("username").isEqualTo(literal(user)));
        where.add(Relation.column("videoid").isEqualTo(literal(id)));

        ResultSet results = this.cc.select("events", where, null, 5, false);
        this.printResults(results);
    }

    private void printResults(ResultSet results) {
        // Show number of columns
        System.out.println(String.format(
                "\nThis table has %d columns!", results.getColumnDefinitions().size()
        ));
        int size = 160 / results.getColumnDefinitions().size();
        System.out.println("(For each col, only " + size + " characters are shown. If the value is bigger it will be cut!)\n");

        // Print header with col names
        Map<String, String> cols = new LinkedHashMap<>();
        StringBuilder output = new StringBuilder();
        for(ColumnDefinition columnDefinition:results.getColumnDefinitions()) {
            output.append(String.format("%"+size+"s  ", columnDefinition.getName().toString()));
            cols.put(columnDefinition.getName().toString(), columnDefinition.getType().toString());
        }
        System.out.println(output.toString());

        // Show values foreach row
        // %X.Ys sets string with length of X and if it is longer than Y is cutted
        for(Row row:results) {
            for(Map.Entry<String, String> col:cols.entrySet()) {
                switch (col.getValue()) {
                    case "ASCII":
                        System.out.print(String.format(
                                "%" + size + "." + size + "s  ", row.getString(col.getKey())
                        ));
                        break;
                    case "TIMESTAMP":
                        System.out.print(String.format(
                                "%" + size + "." + size + "s  ", row.getInstant(col.getKey()).toString()
                        ));
                        break;
                    case "INT":
                        System.out.print(String.format(
                                "%" + size + "d  ", row.getInt(col.getKey())
                        ));
                        break;
                    case "Set(ASCII, not frozen)":
                        Set<String> set = row.getSet(col.getKey(), String.class);
                        StringBuilder outputset = new StringBuilder();
                        for (String s:set) {
                            outputset.append(s);
                            outputset.append("; ");
                        }
                        System.out.print(String.format(
                                "%" + size + "." + size + "s  ", outputset.toString()
                        ));
                        break;
                    default:
                        System.out.print(String.format(
                           "%" + size + "." + size + "s  ", col.getValue() + " not supported yet!"
                        ));
                }
            }
            System.out.println();
        }
    }

    // User interaction
    private String chooseTable() {
        return this.input("What is the name of the table you want to query? ");
    }

    private String input(String s) {
        return inputString(s).split(" ")[0];
    }

    private String inputString(String s) {
        System.out.print(s);
        String val = sc.nextLine();
        return val.trim();
    }

    private boolean run() {
        // Show menu
        System.out.println("----------- MENU -----------");
        System.out.println("-----------  a)  -----------");
        System.out.printf("%02d  %s%n", 01, "READ all rows from table");
        System.out.printf("%02d  %s%n", 02, "FILTER a table by a column value");
        System.out.printf("%02d  %s%n", 03, "INSERT data to a table");
        System.out.println("-----------  b)  -----------");
        System.out.printf("%02d  %s%n", 04, "SEARCH for all videos of a given author");
        System.out.printf("%02d  %s%n", 05, "SEARCH for the last 3 comments at a given video");
        System.out.printf("%02d  %s%n", 06, "SEARCH for all videos with a given tag");
        System.out.printf("%02d  %s%n", 07, "SEARCH for the last 5 events of an user at a given video");
        System.out.println("-----------      -----------");
        System.out.printf("%02d  %s%n", 99, "EXIT");

        // Get user input
        System.out.print("\nChoice: ");
        int op = this.sc.nextInt();
        this.sc.nextLine();

        System.out.println("\n---------------------------------\n");

        // Process it
        switch (op) {
            case 1:
                System.out.println("\nREAD all rows from table\n");
                this.selectAll();
                break;
            case 2:
                System.out.println("\nSEARCH for a row inside a table\n");
                this.search();
                break;
            case 3:
                System.out.println("\nINSERT data to a table\n");
                this.insert();
                break;
            case 4:
                System.out.println("SEARCH for all videos of a given author");
                this.queryc7();
                break;
            case 5:
                System.out.println("SEARCH for the last 3 comments at a given video");
                this.queryd1();
                break;
            case 6:
                System.out.println("SEARCH for all videos with a given tag");
                this.queryd3();
                break;
            case 7:
                System.out.println("SEARCH for the last 5 events of an user at a given video");
                this.queryd4();
                break;
            case 99:
                System.out.println("\nSee you soon! ;)");
                return false;
            default:
                System.out.println("\nINVALID OPTION! Try again.");
        }

        System.out.print("\nPress ENTER to continue...");
        this.sc.nextLine();
        return true;

    }

    public static void main( String[] args )
    {
        // Connect to DB and start VideoShare instance
        System.out.println("Connecting to Cassandra...");
        CassandraConnector cc = new CassandraConnector("127.0.0.1", 9042, "datacenter1", "videoshare");
        System.out.println(cc.getSession());

        VideoShare cassandra = new VideoShare(cc);
        System.out.println("\n\nWelcome to VIDEO SHARE Database Manager!");

        // Run app
        while(true) {
            if (!cassandra.run())
                break;
        }
    }
}
