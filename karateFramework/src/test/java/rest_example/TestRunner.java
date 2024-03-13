package rest;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
    
    @Karate.Test
    Karate restTests() {
        return Karate.run("reqres").relativeTo(getClass());

    }
}
