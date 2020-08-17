package backend.model;

import frontend.model.FMEATable;
import frontend.model.RiskProcedure;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 17/08/20 2:28 pm
 */
public class Report implements Serializable {
    private frontend.model.RiskProcedure procedure;
    private frontend.model.FMEATable table;

    public frontend.model.RiskProcedure getProcedure() {
        return procedure;
    }

    public void setProcedure(RiskProcedure procedure) {
        this.procedure = procedure;
    }

    public frontend.model.FMEATable getTable() {
        return table;
    }

    public void setTable(FMEATable table) {
        this.table = table;
    }
}
