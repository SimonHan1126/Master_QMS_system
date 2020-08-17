package frontend.view;

import frontend.helper.HttpHelper;
import frontend.model.RiskProcedure;
import frontend.model.User;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 17/08/20 12:45 pm
 */
public class RiskProcedurePage {

    private RiskProcedureRequest pack(RiskProcedure procedure, User user) {
        RiskProcedureRequest request = new RiskProcedureRequest();
        request.setProcedure(procedure);
        request.setUser(user);
        return request;
    }

    public void initRiskProcedureId(String riskProcedureId) {
        HttpHelper.Get("getRiskProcedure", riskProcedureId);
    }

    public void createRiskProcedure(RiskProcedure procedure, User user) {
        HttpHelper.Post("createRiskProcedure", pack(procedure, user));
    }

    public void updateRiskProcedure(RiskProcedure procedure, User user) {
        HttpHelper.Post("updateRiskProcedure", pack(procedure, user));
    }

    public void removeRiskProcedure(RiskProcedure procedure, User user) {
        HttpHelper.Post("removeRiskProcedure", pack(procedure, user));
    }
}

class RiskProcedureRequest implements Serializable {
    private RiskProcedure procedure;
    private User user;

    public RiskProcedure getProcedure() {
        return procedure;
    }

    public void setProcedure(RiskProcedure procedure) {
        this.procedure = procedure;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
