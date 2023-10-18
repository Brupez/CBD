package pt.ua.cbd;

import com.mongodb.BasicDBObject;
import com.mongodb.client.*;
import com.mongodb.client.model.Filters;
import com.mongodb.client.result.InsertOneResult;
import org.bson.Document;

import org.bson.conversions.Bson;

import java.io.*;
import java.util.Calendar;
import java.util.Date;

import static com.mongodb.client.model.Filters.*;
import static com.mongodb.client.model.Projections.exclude;

public class alinea_a {

    static long limit = (long) 2.0;
    static Integer Minutes = 60;

    public static void main(String[] args) {

        // Replace the placeholder with your MongoDB deployment's connection string
        String uri = "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000";

        try (MongoClient mongoClient = MongoClients.create(uri);
             FileWriter fileWriter = new FileWriter("CBD_L204a-out_68264.txt");
             PrintWriter pw = new PrintWriter(new FileWriter("CBD_L204a-out_68264.txt"))) {

            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("orders");

            //clean db after each use
            BasicDBObject document = new BasicDBObject();
            collection.deleteMany(document);

            //output on text file
            outputFile("Starting the output", pw, true);

            String username, product, message;

            BufferedReader read = new BufferedReader(new InputStreamReader(System.in));

            do {
                outputFile("Username: ", pw, false);
                username = read.readLine();
                pw.println(username);

                outputFile("Product: ", pw, false);
                product = read.readLine();
                pw.println(product);

                message = orderRequest(collection, username, product);

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

    public static String orderRequest(MongoCollection<Document> collection, String username, String product) {
        Calendar now = Calendar.getInstance();
        Date actualDate = now.getTime();
        now.add(Calendar.MINUTE, -Minutes);
        Date minDate = now.getTime();


        //Ir à BD buscar count pedidos deste username com data igual ou superior a minDate
        long RequestsCountInTimeslot = collection.countDocuments(and(eq("username",username), gte("timestamp", minDate)));

        if(RequestsCountInTimeslot < limit) {
            Document doc1 = new Document("username", username).append("product", product).append("timestamp", new Date());

            InsertOneResult result = collection.insertOne(doc1);
            System.out.println("Inserted a document with the following id: "
                    + result.getInsertedId().asObjectId().getValue());
            return "Pedido efectuado com sucesso.";
        }
        else {
            return "Pedido exedeu limite de pedidos para esta timeslot";
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

