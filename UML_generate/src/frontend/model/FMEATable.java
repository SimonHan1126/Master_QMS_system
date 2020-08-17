package frontend.model;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 17/08/20 12:20 pm
 */
public class FMEATable implements Serializable {
    private String fmeaTableId;
    private int hazardId;
    private String hazardClass;
    private int severityOfHarms;
    private int probabilityOfHazardous;

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
