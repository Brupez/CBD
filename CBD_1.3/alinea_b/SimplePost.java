package alinea_b;

import java.util.*;
import redis.clients.jedis.Jedis;
 
public class SimplePost {
 
	public static String USERS = "users"; // Key set for users' name
	
	
	public static List<String> testListas(Jedis jedis, String key, String[] users){
		
		System.out.println("A testar listas!");

		//evita que apanhe dados antigos da key
		jedis.del(key);

		for (String user:users){
			jedis.lpush(key, user);
		}
					
		return jedis.lrange(key, 0, -1);
	}

	public static Map<String, String> testHash(Jedis jedis, String key,String[] fields, String[] values){
		
		System.out.println("A testar Hashmaps!");

		//evita que apanhe dados antigos da key
		jedis.del(key);

		int i;
		for(i = 0; i < fields.length; i++){
			jedis.hset(key, fields[i], values[i]);
		}		

		return jedis.hgetAll(key);
	}
	
 
	
	public static void main(String[] args) {
		// set some users

		Jedis jedis = new Jedis();

		String[] users = { "Ana", "Pedro", "Maria", "Luis" };

		testListas(jedis, "minhalista", users).forEach(System.out::println);
		testHash(jedis, "minhaHash", users, users).entrySet().forEach(System.out::println);

		jedis.close();
	}
}



