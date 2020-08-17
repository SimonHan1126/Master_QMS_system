package frontend.view;

import frontend.helper.HttpHelper;
import frontend.model.FMEATable;
import frontend.model.RiskProcedure;
import frontend.model.User;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 17/08/20 2:23 pm
 */
public class GenerateReportPage {

    public void generateReport(User user) {
        HttpHelper.Post("generateReport", user);
    }
}

