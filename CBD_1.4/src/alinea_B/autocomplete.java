package alinea_B;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ZParams;

import java.io.*;
import java.util.*;

import static alinea_A.autocomplete.outputFile;


public class autocomplete {

    static String file_path = "src/alinea_B/nomes-pt-2021.csv";

    public static void main(String[] args) {
        
        Jedis jedis = new Jedis();

        try(BufferedReader readFile = new BufferedReader(new FileReader(file_path)); PrintWriter pw = new PrintWriter(new FileWriter("CBD-14b-out.txt"))){

            outputFile("Starting the output", pw, true);

            String line;
            jedis.del("autoCompletedB","noScore");
            

            // adiciona cada linha no redis do ficheiro "nomes-pt-2021.csv", e separa cada linha para obter a string e o score em separado
            while ((line = readFile.readLine()) != null) {
                
                String[] lineParts = line.split(";");

                String name = lineParts[0].trim().toLowerCase();
                int score = Integer.parseInt(lineParts[1].trim());

                jedis.zadd("autoCompleteB", score, name);
                jedis.zadd("noScore", 0, name);

            }

            BufferedReader read = new BufferedReader(new InputStreamReader(System.in));
            String input;

            while (true) {
                outputFile("Search for ('Enter' for quit): ", pw, false);
                jedis.del("unorderedFiltered", "orderedFiltered");
                input = read.readLine();
                pw.println(input);

                if (input.isEmpty()) {
                    break;
                }
                
                List<String> noOrderedList = jedis.zrangeByLex("noScore", "["+input,"("+input+"~");
                for (String result : noOrderedList) {
                    jedis.zadd("unorderedFiltered", 0, result);
                }

                ZParams zp = new ZParams();
                zp.weights(0,1);
                jedis.zinterstore("orderedFiltered", zp,"unorderedFiltered", "autoCompleteB");

                List<String> orderedFiltered = jedis.zrevrange("orderedFiltered", 0, -1);
                for (String finalResult : orderedFiltered){
                    outputFile(finalResult, pw, true);
                    System.out.println(finalResult);
                }

            }

            pw.close();

        } catch (IOException e) {

            e.printStackTrace();

        } finally {

            jedis.close();
        }
    }
}
