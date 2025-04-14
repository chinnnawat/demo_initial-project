package springboot.core;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.web.servlet.MockMvc;

import springboot.core.controllers.PlusController;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ContextConfiguration(classes = PlusController.class)
public class PlusApplicationTest {

    @Test
    public void testPlus() {
        PlusController plusController = new PlusController();
        String result = plusController.addNumbers(2, 3);
        assertEquals("5", result);
    }
}