package backend.controller;

import backend.helper.ConsistencyHelper;
import backend.model.RiskProcedure;

/**
 * @author Simon-the-coder
 * @date 17/08/20 2:36 pm
 */
public class RIskProcedureController {
    public RiskProcedure getRiskProcedure(String requestJson) {
        return null;
    }
    public RiskProcedure createRiskProcedure(String requestJson) {
        ConsistencyHelper.UpdateFMEATable(null, "");
        return null;
    }
    public RiskProcedure updateRiskProcedure(String requestJson) {
        ConsistencyHelper.UpdateFMEATable(null, "");
        return null;
    }
    public RiskProcedure removeRiskProcedure(String requestJson) {
        ConsistencyHelper.UpdateFMEATable(null, "");
        return null;
    }
}
