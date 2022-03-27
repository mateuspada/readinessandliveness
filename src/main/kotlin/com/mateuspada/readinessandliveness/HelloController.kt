package com.mateuspada.readinessandliveness

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(path = ["/hello"])
class HelloController {
    @GetMapping
    fun sayHello(@RequestParam name: String) = Hello("hello $name")
}

data class Hello(val message: String)