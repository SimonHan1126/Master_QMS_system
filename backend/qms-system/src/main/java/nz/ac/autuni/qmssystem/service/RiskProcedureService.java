package nz.ac.autuni.qmssystem.service;

import nz.ac.autuni.qmssystem.repository.RiskProcedureRepository;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author Simon-the-coder
 * @date 3/09/20 6:02 pm
 */
public class RiskProcedureService implements IRiskProcedureService{

    @Autowired
    private RiskProcedureRepository riskProcedureRepository;
}
