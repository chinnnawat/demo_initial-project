package springboot.core;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

@SpringBootTest
@ContextConfiguration(classes = CoreApplication.class)
class CoreApplicationTests {

	@Test
	void contextLoads() {
		System.out.println("Context loads successfully.");
	}

}
