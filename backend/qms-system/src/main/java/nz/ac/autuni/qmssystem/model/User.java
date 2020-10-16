package nz.ac.autuni.qmssystem.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.GeneratedValue;
import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * @author Simon-the-coder
 * @date 16/10/20 1:26 pm
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@Document(collection = "user")
public class User implements Serializable {
    @Id @GeneratedValue(strategy = IDENTITY)
    String userId;
    String userName;
    String password;
    int userPermission;
}
