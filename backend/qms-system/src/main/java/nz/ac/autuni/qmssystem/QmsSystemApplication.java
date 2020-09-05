package nz.ac.autuni.qmssystem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
public class QmsSystemApplication {

	public static void main(String[] args) {
		SpringApplication.run(QmsSystemApplication.class, args);
	}

}
