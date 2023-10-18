package pt.ua.cbd;


import com.mongodb.Block;
import com.mongodb.client.*;
import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Projections;
import org.bson.Document;
import org.bson.conversions.Bson;

import javax.print.Doc;
import java.io.*;
import java.util.*;

import static com.mongodb.client.model.Projections.include;

public class App {
    public static void main(String[] args) {
        String uri = "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000";

        try (MongoClient mongoClient = MongoClients.create(uri); FileWriter fileWriter = new FileWriter("CBD_L203-out_68264.txt");
             PrintWriter pw = new PrintWriter(new FileWriter("CBD_L203-out_68264.txt"))) {

            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("restaurants");

            System.out.println("Database connected");

            outputFile("Número de localidades distintas: " + countlocalidades(), pw, true);
            outputFile("---------------------------------------", pw, true);

            Map<String, Integer> localCount = countRestByLocalidade();

            outputFile("Número de restaurantes por localidade:", pw, true);

            AggregateIterable<Document> countLocalidades = collection.aggregate(
                    Arrays.asList(
                            Aggregates.group("localidade", Accumulators.sum("count", "$restaurant_id")),
                            Aggregates.project(Projections.fields(
                                            Projections.excludeId(),
                                            Projections.computed("totalField", "$totalField")
                                    )
                            )
                    )
            );
            

            /*for (Map.Entry<String, Integer> localidade: localCount.entrySet()){
                outputFile("-> " + localidade.getKey() + " - " + localidade.getValue(), pw, true);
            }*/

            String name = "Park";

            List<String> restaurants = getRestWithNameCloserTo(name);

            outputFile("Nome de restaurantes contendo " + "'" + name + "'" + "no nome:", pw, true);
            for (String restaurant : restaurants) {
                outputFile("-> " + restaurant, pw, true);
            }


        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static int countlocalidades() {

        String uri = "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000";

        try (MongoClient mongoClient = MongoClients.create(uri)) {

            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("restaurants");

            DistinctIterable<String> docs = collection.distinct("localidade", String.class);
            MongoCursor<String> results = docs.iterator();

            int count = 0;

            while (results.hasNext()) {
                System.out.println(results.next());
                count++;
            }

            return count;
        }
    }

    public static Map<String, Integer> countRestByLocalidade() {

        String uri = "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000";

        try (MongoClient mongoClient = MongoClients.create(uri)) {

            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("restaurants");

            Map<String, Integer> listLocalidades = new HashMap<>();

            AggregateIterable<Document> countLocalidades = collection.aggregate(
                    Arrays.asList(
                            Aggregates.group("$localidade", Accumulators.sum("count", "$restaurant_id")),
                            Aggregates.project(Projections.fields(
                                            Projections.excludeId(),
                                            Projections.computed("totalField", "$totalField")
                                    )
                            )
                    ));


            /*for (Document doc: countLocalidades){
                listLocalidades.put(doc.getString("_id"), doc.getInteger("count"));
            }*/


            return listLocalidades;
        }
    }

    public static List<String> getRestWithNameCloserTo(String name) {

        String uri = "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000";

        try (MongoClient mongoClient = MongoClients.create(uri)) {

            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("restaurants");

            List<String> restaurants = new ArrayList<>();

            // sem chamar a função, obtinhamos o resultado pretendido desta forma
            //Bson filter = Filters.text(name);
            //Bson projection = include("nome");
            //collection.find(filter).projection(projection).forEach(document -> System.out.println(document.toJson()));

            // encontra o resto dos caracteres antes e depois do nome dado
            Bson filter = Filters.regex("nome", ".*" + name + ".*", "i");

            for (Document doc : collection.find(filter)) {
                restaurants.add(doc.getString("nome"));
            }

            return restaurants;
        }

    }


    public static void outputFile(String s, PrintWriter pw, boolean println) {

        if (println) {
            System.out.println(s);
            pw.println(s);
        } else {
            System.out.print(s);
            pw.print(s);
        }
    }
}

