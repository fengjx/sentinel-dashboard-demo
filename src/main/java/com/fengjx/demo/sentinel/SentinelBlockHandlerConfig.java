package com.fengjx.demo.sentinel;

import com.alibaba.csp.sentinel.slots.block.BlockException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.annotation.Order;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
@Order(0)
@Slf4j
public class SentinelBlockHandlerConfig {


    @ExceptionHandler(BlockException.class)
    @ResponseBody
    public String sentinelBlockHandler(BlockException e) {
        log.warn("Blocked by Sentinel: {}", e.getRule());
        // Return the customized result.
        return "Blocked by Sentinel: " + e.getRule();
    }

}
