package nz.ac.autuni.qmssystem.model;

/**
 * @author Simon-the-coder
 * @date 3/09/20 5:34 pm
 */
public class Report {
    private RiskProcedure procedure;
    private FMEATable table;

    public Report() {

    }

    public RiskProcedure getProcedure() {
        return procedure;
    }

    public void setProcedure(RiskProcedure procedure) {
        this.procedure = procedure;
    }

    public FMEATable getTable() {
        return table;
    }

    public void setTable(FMEATable table) {
        this.table = table;
    }
}
