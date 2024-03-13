package utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public final class  commonUtils {

    public static void main(String[] args){
        
    }

    public static long currentUnixTime() {

        // returns the current time in milliseconds
        long currentTime = System.currentTimeMillis();
        return currentTime;
    }

    public static String currentTimeStamp() {

        // returns the current timestamp
        String currentTimeStamp = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX").format(new Date());
        return currentTimeStamp;
    }
    
}
