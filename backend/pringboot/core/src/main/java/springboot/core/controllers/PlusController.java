package springboot.core.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PlusController {

    @GetMapping("/add")
    public String addNumbers(@RequestParam int a, @RequestParam int b) {
        return String.valueOf(a + b);
    }
}
