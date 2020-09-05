package nz.ac.autuni.qmssystem.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.GeneratedValue;
import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * @author Simon-the-coder
 * @date 3/09/20 5:34 pm
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@Document(collection = "FMEATable")
public class FMEATable implements Serializable {
    @Id @GeneratedValue(strategy = IDENTITY)
    private Long fmeaTableId;
    private int hazardId;
    private String hazardClass;
    private int severityOfHarms;
    private int probabilityOfHazardous;
    private boolean isApprove;
}
