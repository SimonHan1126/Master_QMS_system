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
 * @date 3/09/20 5:34 pm
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@Document(collection = "FMEATable")
public class FMEATable implements Serializable {
    @Id @GeneratedValue(strategy = IDENTITY)
    private String hazardId;
    private String hazardClass;
    private String sourceId;
    private String foreseeableSequenceOfEvents; //both normal and fault conditions
    private String hazardousSituation;
    private String harm; //result of hazardous situation
    private String severityOfHarm; //1-7
    private String probability; // Probability of hazardous situation occurring, Probability of hazardous situation leading to harm (1-7)
    private String riskPriority; //Risk Priority Number (SxP)
    private String recommendingAction; //Risk Control Method
    private String typeOfAction;
    private String actionDone;
    private String severityOfHarm2;
    private String probability2;
    private String residualRisk; //(S2xP2)
    private String selectedRPId;
    private boolean acceptability;
}
