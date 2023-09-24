import redis.clients.jedis.Jedis;
import redis.clients.jedis.Pipeline;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

public class autocomplete {

    static String  file_path = "alinea_A/names.txt";

    public static void main(String[] args) {
        
        Jedis jedis = new Jedis();

        try(BufferedReader readFile = new BufferedReader(new FileReader(file_path))){

            Pipeline pipeline = jedis.pipelined();
            String line;

            // adiciona cada linha a sorted set no redis do ficheiro "names.txt"
            while ((line = readFile.readLine()) != null) {
                pipeline.zadd("autoComplete", 0, line.toLowerCase());
            }

            pipeline.sync();
            
            // Loop de pesquisa e autocomplete
            BufferedReader read = new BufferedReader(new InputStreamReader(System.in));
            String input;

            while (true) {
                System.out.print("Search for ('Enter' for quit): ");
                input = read.readLine();
                if (input.isEmpty()) {
                    break;
                }

                Set<String> autocompleteResults = autoCompleteOrder(jedis, input);
                for (String result : autocompleteResults) {
                    System.out.println(result);
                }
            }
        } catch (IOException e) {

            e.printStackTrace();

        } finally {

            jedis.close();

        }
    }

    private static Set<String> autoCompleteOrder(Jedis jedis, String prefix) {

        String min = "[" + prefix.toLowerCase();
        String max = "[" + prefix.toLowerCase() + "\uFFFF";

        // Recupera os termos no intervalo [prefix, prefix + '\xff'] da ordem alfabética
        List<String> result = jedis.zrangeByLex("autoComplete", min, max);

        //ordem alfabética apartir de um Treeset
        TreeSet<String> sortedResults = new TreeSet<>(result);

        return sortedResults;
    }
}
