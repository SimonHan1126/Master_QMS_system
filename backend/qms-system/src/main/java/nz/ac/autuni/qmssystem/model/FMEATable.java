package nz.ac.autuni.qmssystem.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * @author Simon-the-coder
 * @date 3/09/20 5:34 pm
 */
@Document(collection = "FMEATable")
public class FMEATable {
    @Id
    private String fmeaTableId;
    private int hazardId;
    private String hazardClass;
    private int severityOfHarms;
    private int probabilityOfHazardous;

    public FMEATable() {

    }

    public FMEATable(String fmeaTableId, int hazardId, String hazardClass, int severityOfHarms, int probabilityOfHazardous) {
        this.fmeaTableId = fmeaTableId;
        this.hazardId = hazardId;
        this.hazardClass = hazardClass;
        this.severityOfHarms = severityOfHarms;
        this.probabilityOfHazardous = probabilityOfHazardous;
    }

    public String getFmeaTableId() {
        return fmeaTableId;
    }

    public void setFmeaTableId(String fmeaTableId) {
        this.fmeaTableId = fmeaTableId;
    }

    public int getHazardId() {
        return hazardId;
    }

    public void setHazardId(int hazardId) {
        this.hazardId = hazardId;
    }

    public String getHazardClass() {
        return hazardClass;
    }

    public void setHazardClass(String hazardClass) {
        this.hazardClass = hazardClass;
    }

    public int getSeverityOfHarms() {
        return severityOfHarms;
    }

    public void setSeverityOfHarms(int severityOfHarms) {
        this.severityOfHarms = severityOfHarms;
    }

    public int getProbabilityOfHazardous() {
        return probabilityOfHazardous;
    }

    public void setProbabilityOfHazardous(int probabilityOfHazardous) {
        this.probabilityOfHazardous = probabilityOfHazardous;
    }
}
