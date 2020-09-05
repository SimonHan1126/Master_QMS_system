package nz.ac.autuni.qmssystem.controller;

import nz.ac.autuni.qmssystem.dao.FMEATableDao;
import nz.ac.autuni.qmssystem.dao.RiskProcedureDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Simon-the-coder
 * @date 3/09/20 4:30 pm
 */
@RestController
@RequestMapping("/api/v1/approve")
public class ApproveController {

    @Autowired
    private FMEATableDao fmeaTableService;
    @Autowired
    private RiskProcedureDao riskProcedureService;

    @PostMapping("/approveFMEATable")
    public ResponseEntity<Void> approveFMEATable(Long fmeaTableId) {
        fmeaTableService.approveFMEATable(fmeaTableId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/removeFMEATable")
    public ResponseEntity<Void> approveRiskProcedure(Long riskProcedureId) {
        riskProcedureService.approveRiskProcedure(riskProcedureId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
