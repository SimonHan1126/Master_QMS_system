package nz.ac.autuni.qmssystem.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * @author Simon-the-coder
 * @date 3/09/20 5:33 pm
 */
@Document(collection = "RiskProcedure")
public class RiskProcedure {

    @Id
    private String riskProcedureId;
    private int severity;
    private String severityDescription;
    private int probability;
    private String probabilityDescription;

    public RiskProcedure() {

    }

    public RiskProcedure(String riskProcedureId, int severity, String severityDescription, int probability, String probabilityDescription) {
        this.riskProcedureId = riskProcedureId;
        this.severity = severity;
        this.severityDescription = severityDescription;
        this.probability = probability;
        this.probabilityDescription = probabilityDescription;
    }

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
