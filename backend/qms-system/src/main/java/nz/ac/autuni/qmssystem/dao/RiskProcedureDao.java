package nz.ac.autuni.qmssystem.dao;

import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.UpdateResult;
import nz.ac.autuni.qmssystem.model.RiskProcedure;

import java.util.List;

/**
 * @author Simon-the-coder
 * @date 3/09/20 6:02 pm
 */
public interface RiskProcedureDao {

    void saveRiskProcedure(RiskProcedure riskProcedure);

    DeleteResult removeRiskProcedure(String id);

    void updateRiskProcedure(RiskProcedure riskProcedure);

    RiskProcedure findRiskProcedureById(String id);

    List<RiskProcedure> getAllRiskProcedure();

    UpdateResult approveRiskProcedure(String id);
}
