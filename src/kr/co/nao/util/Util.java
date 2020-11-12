package kr.co.nao.util;

public class Util {
	public static String changeNum(int num) {
		String data = null;
		
		if(num >= 10) {
			data = num + "";
		
		} else {
			data = "0" + num;					
		}
		
		return data;
	}
}
