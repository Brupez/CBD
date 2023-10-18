package pt.ua.cbd;

import com.mongodb.BasicDBObject;
import com.mongodb.client.*;
import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Filters;
import com.mongodb.client.result.InsertOneResult;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.io.*;
import java.util.*;

import static com.mongodb.client.model.Filters.*;
import static com.mongodb.client.model.Projections.exclude;

public class alinea_b {

    static long limit = (long) 10.0;
    static Integer Minutes = 60;

    public static void main(String[] args) {

        // Replace the placeholder with your MongoDB deployment's connection string
        String uri = "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000";

        try (MongoClient mongoClient = MongoClients.create(uri);
             FileWriter fileWriter = new FileWriter("CBD_L204b-out_68264.txt");
             PrintWriter pw = new PrintWriter(new FileWriter("CBD_L204b-out_68264.txt"))) {

            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("orders");

            //clean db after each use
            BasicDBObject document = new BasicDBObject();
            collection.deleteMany(document);

            //output on text file
            outputFile("Starting the output", pw, true);

            String username, product, message, inputQuantity;

            BufferedReader read = new BufferedReader(new InputStreamReader(System.in));

            do {
                outputFile("Username: ", pw, false);
                username = read.readLine();
                pw.println(username);

                outputFile("Product: ", pw, false);
                product = read.readLine();
                pw.println(product);

                outputFile("Quantity of that product: ", pw, false);
                inputQuantity = read.readLine();
                pw.println(inputQuantity);
                int quantity = Integer.parseInt(inputQuantity);

                message = orderRequest(collection, username, product, quantity);

                if (quantity > limit){
                    outputFile("Número de pedidos excedido! Only order a total of 10 products.", pw, true);
                    break;
                }

                collection.aggregate(
                        Arrays.asList(
                                Aggregates.match(Filters.eq("username", username)),
                                Aggregates.group("product", Accumulators.sum("_quantity", "$" + quantity))
                        )
                ).forEach(document1 -> System.out.println(document1.toJson()));

                outputFile(message, pw, true);

                Bson filterUser = Filters.eq("username", username);
                Bson projection = exclude("_id");;

                outputFile(username + " orders: ", pw, true);
                collection.find(filterUser).projection(projection).forEach(doc ->
                        outputFile(doc.values().toString(), pw, true)
                );

            } while (!message.equals("Pedido exedeu limite de pedidos para esta timeslot"));

        } catch (IOException e) {
            e.printStackTrace();
        }
}

    public static String orderRequest(MongoCollection<Document> collection, String username, String product, int quantity) {
        Calendar now = Calendar.getInstance();
        Date actualDate = now.getTime();
        now.add(Calendar.MINUTE, -Minutes);
        Date minDate = now.getTime();


        //Ir à BD buscar count pedidos deste username com data igual ou superior a minDate
        long RequestsCountInTimeslot = collection.countDocuments(and(eq("username",username), gte("timestamp", minDate)));

        if( RequestsCountInTimeslot < limit && quantity < limit) {

            List productsList = new ArrayList<>();
            //productsList.add(product);
            //productsList.add(quantity);


            Document doc1 = new Document("username", username).append("products", productsList).append("timestamp", new Date());
            Document query = new Document("product", product);

            long count = collection.countDocuments(query);

            if (count > 0){
                int totalQuantity = quantity;
                totalQuantity += quantity;
                productsList.add(totalQuantity);
                System.out.println("Quantidade somada");
            }
            else {
                productsList.add(product);
                productsList.add(quantity);
            }
            InsertOneResult result = collection.insertOne(doc1);

            System.out.println("Inserted a document with the following id: "
                    + result.getInsertedId().asObjectId().getValue());
            return "Pedido efectuado com sucesso.";
        }
        else {
            return "Pedido excedeu limite de pedidos para esta timeslot!";
        }

    }

    public static void outputFile(String s, PrintWriter pw, boolean println){

        if (println) {
            System.out.println(s);
            pw.println(s);
        }
        else {
            System.out.print(s);
            pw.print(s);
        }
    }
}

