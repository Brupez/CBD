import redis.clients.jedis.Jedis;

import javax.management.StringValueExp;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.Scanner;
import java.util.List;

public class alinea_B {

    public static String PRODUCT = "product";
    public static int LIMIT = 5;
    public static int TIMESLOT = 60;


    public static void main(String[] args) {

        System.out.println("Only 5 orders possible in a 60 minutes window!");

        try (Jedis jedis = new Jedis(); PrintWriter pw = new PrintWriter(new FileWriter("CBD-15b-out.txt"))) {

            outputFile("Place your order!", pw, true);

            //Cleaning database
            jedis.flushAll();

            //Input from the user (System.in is a input stream that reads from the keyboard)
            Scanner sc = new Scanner(System.in);
            String input;
            int order;

            while (true) {

                //Insert user name
                outputFile("Your Name: ", pw, false);
                input = sc.nextLine();
                pw.println(input);
                outputFile("How many orders : ", pw, false);
                order = Integer.parseInt(sc.nextLine());
                pw.println(order);


                //In case name is empty break
                if (input.isEmpty() || order < 0) {
                    outputFile("Number of orders must be a positive number! Exiting", pw, true);
                    break;
                } else if (order > LIMIT){
                    outputFile("Order limit exceeded"\, pw, true);

                }

                Map<String, String> orders;
                if (jedis.exists(input)){
                    orders = jedis.hgetAll(input);
                }
                else {
                    outputFile(order + " orders added!" , pw, true);
                    jedis.hset(input, LocalDateTime.now().toString(), String.valueOf(order));
                    continue;
                }

                //see the number of orders in a givin time
                int ordersAccepted=0;
                for (Map.Entry<String, String> orderEntry : orders.entrySet()) {

                    LocalDateTime time = LocalDateTime.parse(orderEntry.getKey());
                    if (time.isAfter(LocalDateTime.now().minusMinutes(TIMESLOT))) {
                        ordersAccepted += Integer.parseInt(orderEntry.getValue());
                    }
                }

                System.out.println((ordersAccepted+order) + " orders in the " + TIMESLOT + " minutes found!");

                if(order + ordersAccepted <= LIMIT){
                    jedis.hset(input, LocalDateTime.now().toString(), String.valueOf(order));
                    System.out.println("New order added!");
                } else {
                    outputFile("Exceeded the limitation of orders",pw,true);
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