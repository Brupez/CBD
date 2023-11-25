package pt.ua.cbd.lab3.Ex3_4;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.schemabuilder.CreateKeyspace;
import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

import java.time.Instant;

public class Ex3_4 {

    public static void main(String[] args) {

        // Acessing keyspace from Ex3_4
        String keyspace = "Ex3_4";
        try (CqlSession session = CqlSession.builder().withKeyspace(keyspace).build()) {

            // 5 Updates
            com.datastax.oss.driver.api.core.cql.ResultSet update1 = session.execute("UPDATE teachers SET danceClasses = danceClasses + {'Afro-latinas'} WHERE teacher_id = 1");
            com.datastax.oss.driver.api.core.cql.ResultSet update2 = session.execute("UPDATE teachers SET email='lb@gmail.com' WHERE teacher_id = 7");
            com.datastax.oss.driver.api.core.cql.ResultSet update3 = session.execute("UPDATE students SET phone_number = phone_number + {'Fax': 23356} WHERE student_id = 5 AND entry_time = '2023-11-25T17:15:00Z'" );
            com.datastax.oss.driver.api.core.cql.ResultSet update4 = session.execute("UPDATE dance_schools SET teacher_id = 10, days = {'Friday', 'Saturday'} WHERE dance_school_id = 11 AND creation_date = '2015-11-12'");
            com.datastax.oss.driver.api.core.cql.ResultSet update5 = session.execute("UPDATE dance_classes SET teacher_id = 10 WHERE dance_class_id = 9");

            com.datastax.oss.driver.api.core.cql.ResultSet rs1 = session.execute("SELECT * FROM teachers");

            System.out.println("UPDATES");
            for (Row row : rs1){

                System.out.println("Teacher Id: " + row.getInt("teacher_id"));
                System.out.println("Name: " + row.getString("name"));
                System.out.println("Email: " + row.getString("email"));
                System.out.println("Dance Classes: " + row.getSet("danceClasses", String.class));
                System.out.println("-----------------------------------------------");
            }

            // 5 Deletes
            com.datastax.oss.driver.api.core.cql.ResultSet delete1 = session.execute("DELETE danceClasses['Ballet'] FROM teachers WHERE teacher_id = 1");
            com.datastax.oss.driver.api.core.cql.ResultSet delete2 = session.execute("DELETE phone_number['home'] FROM students WHERE student_id = 10 AND entry_time = '2023-11-25T10:15:00Z'");
            com.datastax.oss.driver.api.core.cql.ResultSet delete3 = session.execute("DELETE FROM students WHERE student_id = 5");
            com.datastax.oss.driver.api.core.cql.ResultSet delete4 = session.execute("DELETE FROM dance_classes WHERE dance_class_id = 4");
            com.datastax.oss.driver.api.core.cql.ResultSet delete5 = session.execute("DELETE days['Sunday'] FROM dance_schools WHERE dance_school_id = 7 AND creation_date = '1980-11-12'");

            com.datastax.oss.driver.api.core.cql.ResultSet rs2 = session.execute("SELECT * FROM dance_classes");

            System.out.println("DELETES");
            for (Row row : rs2) {

                System.out.println("Dance Class Id: " + row.getInt("dance_class_id"));
                System.out.println("Teacher Id: " + row.getInt("teacher_id"));
                System.out.println("Week days: " + row.getSet("week_days", String.class));
                System.out.println("-----------------------------------------------");
            }
        }
    }
}