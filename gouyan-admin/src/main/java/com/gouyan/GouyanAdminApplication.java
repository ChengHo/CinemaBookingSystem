package com.gouyan;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = {"com.anji.captcha", "com.gouyan"})
@SpringBootApplication
public class GouyanAdminApplication {

	public static void main(String[] args) {
		SpringApplication.run(GouyanAdminApplication.class, args);
	}

}
