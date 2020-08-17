package frontend.view;

import frontend.constant.UserPermissionConstant;
import frontend.helper.HttpHelper;
import frontend.model.FMEATable;
import frontend.model.RiskProcedure;
import frontend.model.User;

/**
 * @author Simon-the-coder
 * @date 17/08/20 2:09 pm
 */
public class ApprovePage {

    private boolean checkUserPermission(User user) {

        if (user.getPermission() != UserPermissionConstant.QA) {
            return false;
        }

        return true;
    }

    public void approveRiskProcedure(RiskProcedure procedure, User user) {
        if (!checkUserPermission(user)) {
            return;
        }
        HttpHelper.Post("approveRiskProcedure", procedure);
    }

    public void approveFEMATable(FMEATable table, User user) {
        if (!checkUserPermission(user)) {
            return;
        }
        HttpHelper.Post("approveFEMATable", table);
    }
}
