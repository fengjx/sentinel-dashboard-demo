package com.fengjx.demo.sentinel;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author FengJianxin
 */
@RestController
public class HelloController {


    @RequestMapping("/*")
    public String index() {
        return "sentinel";
    }


    @RequestMapping("/ping")
    public String echo() {
        return "pong";
    }


}
