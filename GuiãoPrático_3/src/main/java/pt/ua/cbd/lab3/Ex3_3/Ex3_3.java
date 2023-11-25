package pt.ua.cbd.lab3.Ex3_3;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

import java.time.Instant;

public class Ex3_3 {
    public static void main(String[] args) {

        // Acessing keyspace from Ex3_2
        String keyspace = "Ex3_2";
        try (CqlSession session = CqlSession.builder().withKeyspace(keyspace).build()) {

            //ALINEA A)
            //Insert
            ResultSet insert = session.execute("INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (11, 'Lopez', 'Assassins Creed','ac@gmail.com', ['ação', 'historical'], '2014-08-11')");

            //Search
            ResultSet search = session.execute("SELECT * FROM videos WHERE author = 'Bruno'");

            //Update
            ResultSet update = session.execute("UPDATE videos SET name='Bruno Lopes', email='brunolopes@gmail.com' WHERE author='Bruno' AND selo_temporal_videos='2020-11-13'");

            //Show values of table videos
            ResultSet rs = session.execute("SELECT * FROM videos");

            for (Row row : rs){

                System.out.println("Vídeo Id: " + row.getInt("video_id"));
                System.out.println("Author: " + row.getString("author"));
                System.out.println("Name: " + row.getString("name"));
                System.out.println("Email: " + row.getString("email"));
                System.out.println("Tags: " + row.getSet("tags", String.class));
                Instant timestamp = row.get("selo_temporal_videos", Instant.class);
                System.out.println("Selo Temporal: " + timestamp);
                System.out.println("-----------------------------------------------");
            }

            //ALINEA B)
            //Query 4
            ResultSet ex4 = session.execute("SELECT * FROM events WHERE video_id=1 AND user_id = 1 LIMIT 5");
            System.out.println("Os últimos 5 eventos de determinado vídeo realizados por um utilizador\n");
            for (Row row : ex4){


                System.out.println("Vídeo Id: " + row.getInt("video_id"));
                System.out.println("User Id: " + row.getInt("user_id"));
                System.out.println("Event Type: " + row.getString("event_type"));
                System.out.println("Video Seconds: " + row.getInt("video_seconds"));
                Instant timestamp = row.get("selo_temporal_event", Instant.class);
                System.out.println("Selo Temporal: " + timestamp);
                System.out.println("-----------------------------------------------");
            }

            //Query 5
            ResultSet ex5 = session.execute("SELECT * FROM videosByAuthor WHERE author='Bruno' AND selo_temporal_videosByAuthor < '2020-11-13'");
            System.out.println("Vídeos partilhados por determinado utilizador num determinado período de tempo (Agosto de 2017, por exemplo)\n");
            for (Row row : ex5){


                System.out.println("Vídeo Id: " + row.getInt("video_id"));
                System.out.println("Name: " + row.getString("name"));
                System.out.println("Email: " + row.getString("email"));
                System.out.println("Author: " + row.getString("author"));
                Instant timestamp = row.get("selo_temporal_videos", Instant.class);
                System.out.println("Selo Temporal: " + timestamp);
                System.out.println("-----------------------------------------------");
            }

            //Query 7
            ResultSet ex7 = session.execute("SELECT * FROM video_followers WHERE video_id=2");
            System.out.println("Todos os seguidores (followers) de determinado vídeo\n");
            for (Row row : ex7){


                System.out.println("Vídeo Id: " + row.getInt("video_id"));
                System.out.println("User Id: " + row.getInt("user_id"));
                System.out.println("-----------------------------------------------");


            }

            //Query 11
            ResultSet ex11 = session.execute("SELECT tags, COUNT(video_id) FROM videos GROUP BY video_id;");
            System.out.println("Lista com as Tags existentes e o numero de videos catalogados com cada uma delas;");
            for (Row row : ex11){

                System.out.println("Tags: " + row.getSet("tags", String.class));
                System.out.println("Count ratings: " + row.getLong("system.count(video_id)"));
                System.out.println("-----------------------------------------------");

            }
        }
    }
}