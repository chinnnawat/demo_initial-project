package springboot.core;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api")
public class ApiController {

	@GetMapping("/hello")
	public ResponseEntity<Map<String, String>> hello() {
		Map<String, String> response = new HashMap<>();
		response.put("message", "Hello Developer, My name Chin");
		return ResponseEntity.ok(response);
	}

	@GetMapping("/goodbye")
	public ResponseEntity<Map<String, String>> goodbye() {
		Map<String, String> response = new HashMap<>();
		response.put("message", "Goodbye, World Chin nawat!");
		return ResponseEntity.ok(response);
	}
}