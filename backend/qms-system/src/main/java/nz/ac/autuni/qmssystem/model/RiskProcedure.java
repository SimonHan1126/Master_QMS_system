package nz.ac.autuni.qmssystem.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.GeneratedValue;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

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
    private String riskProcedureId;
    private String harm;
    private List<Item> severity;
    private List<ItemDescription> severityDescription;
    private List<Item> probability;
    private List<ItemDescription> probabilityDescription;
    private Map<String,String> mapRiskEstimation;
    private String approve;
}

@AllArgsConstructor
@NoArgsConstructor
@Data
class Item implements Serializable {
    private String id;
    private String name;
    private String level;
    private String tag;
}

@AllArgsConstructor
@NoArgsConstructor
@Data
class ItemDescription implements Serializable {
    private String itemId;
    private String name;
    private String description;
    private String tag;
}


