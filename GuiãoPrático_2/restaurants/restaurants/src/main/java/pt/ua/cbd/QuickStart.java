package pt.ua.cbd;

import static com.mongodb.client.model.Filters.*;
import static com.mongodb.client.model.Projections.*;
import static com.mongodb.client.model.Sorts.ascending;

import com.mongodb.client.*;
import com.mongodb.client.model.*;
import com.mongodb.client.result.InsertOneResult;
import com.mongodb.client.result.UpdateResult;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.ArrayList;
import java.util.List;

public class QuickStart {
    public static void main( String[] args ) {
        // Replace the placeholder with your MongoDB deployment's connection string uri
        String uri = "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000";

        try (MongoClient mongoClient = MongoClients.create(uri)) {

            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("restaurants");

            System.out.println("Database connected");

            // find commands
            Document doc = collection.find().first();
            Bson projectionFields = fields(
                    include("nome", "localidade"),
                    excludeId());
            Document docFind = collection.find(eq("nome", "Bruno"))
                    .projection(projectionFields)
                    .first();

            //insert command
            doc.append("localidade", "Aveiro");

            Document doc1 = new Document("localidade", "Ilhavo").append("nome", "Bruno");
            InsertOneResult res = collection.insertOne(doc1);

            System.out.println("Great Success! Document added to db." + res.getInsertedId().asObjectId().getValue());

            //update the name field from Bruno to Lopes
            Bson filter = Filters.eq("nome", "Bruno");
            Bson update = Updates.rename("Bruno", "Lopes");
            UpdateResult result = collection.updateMany(filter, update);
            System.out.println("Matched document count: " + result.getMatchedCount());
            System.out.println("Modified document count: " + result.getModifiedCount());

            //Ex2.3b
            //index de texto no field nome
            String idNome = collection.createIndex(Indexes.text("nome"));
            System.out.println(String.format("Index created: %s", idNome));

            //index no campo localidade e gastronomia
            String localidadeIndex = collection.createIndex(Indexes.ascending("localidade"));
            String gastronomiadeIndex = collection.createIndex(Indexes.ascending("gastronomia"));

            System.out.println(localidadeIndex);

            List<Document> lists = new ArrayList<>();
            collection.find().sort(ascending("localidade")).into(lists);
            collection.find().sort(ascending("gastronomia")).into(lists);


            for (Document list: lists) {
                System.out.println(list.toJson());
            }

            //search for all indexes that exists on all collection (text and indexes created)
            try (MongoCursor<Document> resultsCursor = collection.listIndexes().iterator()) {
                while (resultsCursor.hasNext()) {
                    System.out.println(resultsCursor.next());
                }
            }


            //Ex 2.3c
            //Listar todos os restaurantes
            Bson filterOperation1 = Filters.empty();
            collection.find(filterOperation1).forEach(document -> System.out.println(document.toJson()));

            //Listar todos os restaurantes localizados em Bronx
            Bson filterOperation2 = Filters.eq("localidade", "Bronx");
            collection.find(filterOperation2).forEach(document -> System.out.println(document.toJson()));

            //Apresente os campos restaurant_id, nome, localidade e código postal (zipcode), mas exclua o campo _id de todos os documentos da coleção.
            Bson filterOperation3 = Filters.empty();
            Bson projection = Projections.fields(Projections.include("nome", "localidade", "restaurant_id", "address.zipcode"), Projections.excludeId());
            collection.find(filterOperation3).projection(projection).forEach(System.out::println);/*

            //Apresente os primeiros 15 restaurantes localizados no Bronx, ordenados por ordem crescente de nome.*/
            collection.find(filterOperation2).sort(ascending("nome")).limit(15).forEach(System.out::println);

            //Liste o nome, a localidade e a gastronomia dos restaurantes que pertencem ao Bronxe cuja gastronomia é do tipo "American" ou "Chinese".
            Bson filterOperation4 = Filters.and(
                    Filters.eq("localidade", "Bronx"),
                    Filters.or(
                            Filters.eq("gastronomia", "American"),
                            Filters.eq("gastronomia","Chinese")));
            Bson projectionOperation = Projections.include( "nome", "localidade", "gastronomia");
            collection.find(filterOperation4).projection(projectionOperation).forEach(System.out::println);


            if (doc != null) {
                System.out.println(doc.toJson());
            } else {
                System.out.println("No matching documents found.");
            }
        }
    }
}