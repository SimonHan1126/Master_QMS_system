package nz.ac.autuni.qmssystem.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.io.Serializable;
import java.util.List;

/**
 * @author Simon-the-coder
 * @date 21/11/20 11:16 am
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@Document(collection = "FMEATableGroup")
public class FMEATableGroup implements Serializable {
    @Id
    String fmeaTableGroupId;
    String riskProcedureId;
    List<FMEATable> fmeaTableList;
}
