package nz.ac.autuni.qmssystem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
public class QmsSystemApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(QmsSystemApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(QmsSystemApplication.class);
	}
}

//@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
//public class QmsSystemApplication {
//
//	public static void main(String[] args) {
//		SpringApplication.run(QmsSystemApplication.class, args);
//	}
//
//}