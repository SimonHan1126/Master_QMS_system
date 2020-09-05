package nz.ac.autuni.qmssystem.dao;

import nz.ac.autuni.qmssystem.model.RiskProcedure;

/**
 * @author Simon-the-coder
 * @date 3/09/20 6:02 pm
 */
public interface RiskProcedureDao {
    void saveRiskProcedure(RiskProcedure riskProcedure);

    void removeRiskProcedure(Long id);

    void updateRiskProcedure(RiskProcedure riskProcedure);

    RiskProcedure findRiskProcedureById(Long id);

    void approveRiskProcedure(Long id);
}
