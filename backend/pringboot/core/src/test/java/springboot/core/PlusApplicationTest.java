package springboot.core;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.web.servlet.MockMvc;

import springboot.core.controllers.PlusController;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = PlusController.class)
@ContextConfiguration(classes = PlusController.class)
public class PlusApplicationTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testAddNumbers() throws Exception {
        mockMvc.perform(get("/add")
                .param("a", "5")
                .param("b", "7"))
                .andExpect(status().isOk())
                .andExpect(content().string("12"));
    }
}
