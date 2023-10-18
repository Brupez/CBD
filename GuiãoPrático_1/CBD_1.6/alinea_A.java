import redis.clients.jedis.Jedis;

import java.awt.print.PrinterAbortException;
import java.io.*;
import java.util.List;
import java.util.Set;
import java.util.Scanner;

public class alinea_A {

    public static String USERS = "users";

    public static void main(String[] args) {

        try (Jedis jedis = new Jedis(); PrintWriter pw = new PrintWriter(new FileWriter("CBD-16a-out.txt"))) {
            jedis.flushAll();

            Scanner sc = new Scanner(System.in);
            String MyUser, UserToFollow, Msg;
            while (true) {

                outputFile("Insert My User: ", pw, true);
                MyUser = sc.nextLine();

                if (MyUser.isEmpty()) {
                    outputFile("Must insert your UserName!", pw, true);
                    break;
                }

                addUser(jedis, MyUser);

                outputFile("Insert Follow User: ", pw, true);
                UserToFollow = sc.nextLine();

                if (UserToFollow.isEmpty()) {
                    outputFile("Must insert Destination UserName!", pw, true);
                    break;
                }
                addUser(jedis, UserToFollow);
                storeFollows(jedis, MyUser, UserToFollow);

                printMessagesUser(jedis, pw, UserToFollow);

                outputFile(MyUser + " write a Post: ", pw, true);
                Msg = sc.nextLine();

                if (Msg.isEmpty()) {
                    outputFile("Must insert a message!", pw, true);
                    break;
                }

                storeMessage(jedis, MyUser, Msg);

            }

            jedis.smembers(USERS).forEach(user -> {
                printMessagesUser(jedis, pw, user);
                printUserFollows(jedis, pw, user);
            });

            pw.close();
        } catch (Exception e) {
            e.getMessage();
        }
    }

    public static void addUser(Jedis thisJedis, String userName) {

        Set<String> users = thisJedis.smembers(USERS);

        if (!users.contains(userName)) {
            thisJedis.sadd(USERS, userName);
        }
    }

    public static void storeFollows(Jedis jedis, String userA, String userB) {
        String key = userA + "_follows";
        if (!getFollows(jedis,userA).contains(userB)) {
            jedis.sadd(key, userB);
        }
    }

    public static Set<String> getFollows(Jedis jedis, String userName) {
        String key = userName + "_follows";
        return jedis.smembers(key);
    }

    public static void storeMessage(Jedis jedis, String userName, String msg) {
        String key = userName + "_posts";
        jedis.sadd(key, msg);
    }

    public static Set<String> getPosts(Jedis jedis, String userName) {
        String key = userName + "_posts";
        return jedis.smembers(key);
    }

    public static void printMessagesUser(Jedis thisJedis, PrintWriter pw, String userName) {
        System.out.println(userName + "| Posts | " + getPosts(thisJedis, userName));
    }

    public static void printUserFollows(Jedis thisJedis, PrintWriter pw , String userName) {
        System.out.println(userName + " | Follows | " + getFollows(thisJedis, userName));
    }

    public static int getNumberMessages(Jedis thisJedis, String userName) {
        return thisJedis.smembers(userName).size();
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
