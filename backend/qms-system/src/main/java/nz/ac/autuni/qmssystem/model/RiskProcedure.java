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
 * @date 3/09/20 5:33 pm
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@Document(collection = "RiskProcedure")
public class RiskProcedure implements Serializable {

    @Id @GeneratedValue(strategy = IDENTITY)
    private Long riskProcedureId;
    private int severity;
    private String severityDescription;
    private int probability;
    private String probabilityDescription;
    private boolean isApprove;
}
