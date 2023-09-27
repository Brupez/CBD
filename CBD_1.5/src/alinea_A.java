import redis.clients.jedis.Jedis;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.Scanner;
import java.util.List;

public class alinea_A {

    public static String PRODUCT = "product";
    public static int LIMIT = 5;
    public static int TIMESLOT = 60;


    public static void main(String[] args) {

        System.out.println("Only 5 orders possible in a 60 minutes window!");

        try (Jedis jedis = new Jedis(); PrintWriter pw = new PrintWriter(new FileWriter("CBD-15a-out.txt"))) {

            outputFile("Let's check the orders:", pw, true);

            //Cleaning database
            jedis.flushAll();

            //Input from the user (System.in is a input stream that reads from the keyboard)
            Scanner sc = new Scanner(System.in);
            String input;

            while (true) {

                //Insert user name
                outputFile("Your Name: ", pw, false);
                input = sc.nextLine();
                pw.println(input);


                //In case name is empty break
                if (input.isEmpty()) {
                    break;
                }

                List<String> orders = jedis.lrange(input, 0, -1);

                //see the number of orders in a givin time
                int ordersAccepted = 0;

                for (String PRODUCT : orders) {

                    outputFile(PRODUCT, pw, true);
                    LocalDateTime time = LocalDateTime.parse(PRODUCT);
                    if (time.isAfter(LocalDateTime.now().minusMinutes(TIMESLOT))) {
                        ordersAccepted++;
                    }
                }

                System.out.println(ordersAccepted + " orders in the " + TIMESLOT + " minutes found!");

                if(ordersAccepted < LIMIT){
                    jedis.rpush(input, LocalDateTime.now().toString());
                    System.out.println("New order added!");
                } else {
                    System.err.println("Exceeded the limitation of orders");
                    jedis.close();
                }
            }

            pw.close();


        } catch (Exception e) {
            e.getMessage();
        }
    }

    //imprime no ficheiro o output
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