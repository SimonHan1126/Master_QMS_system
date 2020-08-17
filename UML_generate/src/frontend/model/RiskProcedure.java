package frontend.model;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 17/08/20 12:15 pm
 */
public class RiskProcedure implements Serializable {
    private String riskProcedureId;
    private int severity;
    private String severityDescription;
    private int probability;
    private String probabilityDescription;

    public String getRiskProcedureId() {
        return riskProcedureId;
    }

    public void setRiskProcedureId(String riskProcedureId) {
        this.riskProcedureId = riskProcedureId;
    }

    public int getSeverity() {
        return severity;
    }

    public void setSeverity(int severity) {
        this.severity = severity;
    }

    public String getSeverityDescription() {
        return severityDescription;
    }

    public void setSeverityDescription(String severityDescription) {
        this.severityDescription = severityDescription;
    }

    public int getProbability() {
        return probability;
    }

    public void setProbability(int probability) {
        this.probability = probability;
    }

    public String getProbabilityDescription() {
        return probabilityDescription;
    }

    public void setProbabilityDescription(String probabilityDescription) {
        this.probabilityDescription = probabilityDescription;
    }
}
