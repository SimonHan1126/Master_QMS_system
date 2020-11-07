package nz.ac.autuni.qmssystem.controller;

import com.mongodb.client.result.UpdateResult;
import nz.ac.autuni.qmssystem.dao.FMEATableDao;
import nz.ac.autuni.qmssystem.dao.RiskProcedureDao;
import nz.ac.autuni.qmssystem.model.FMEATable;
import nz.ac.autuni.qmssystem.model.RiskProcedure;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 10/09/20 10:34 pm
 */

@RestController
@RequestMapping("/api/v1/approve")
public class ApproveController {

    private static final Logger logger = LogManager.getLogger(ApproveController.class);

    @Autowired
    private FMEATableDao fmeaTableService;
    @Autowired
    private RiskProcedureDao riskProcedureService;

    @PostMapping("/approveFMEATable")
    public ResponseEntity<Serializable> approveFMEATable(String fmeaTableId) {
        logger.info("ApproveController.approveFMEATable fmeaTableId " + fmeaTableId);
        UpdateResult result = fmeaTableService.approveFMEATable(fmeaTableId);
        logger.info("ApproveController.approveFMEATable result " + result.toString());
        FMEATable table = fmeaTableService.findFMEATableById(fmeaTableId);
        return ResponseEntity.status(HttpStatus.OK).body(table);
    }

    @PostMapping("/approveRiskProcedure")
    public ResponseEntity<Serializable> approveRiskProcedure(String riskProcedureId) {
        logger.info("ApproveController.approveRiskProcedure riskProcedureId " + riskProcedureId);
        UpdateResult result = riskProcedureService.approveRiskProcedure(riskProcedureId);
        logger.info("ApproveController.approveRiskProcedure result " + result.toString());
        RiskProcedure riskProcedure = riskProcedureService.findRiskProcedureById(riskProcedureId);
        return ResponseEntity.status(HttpStatus.OK).body(riskProcedure);
    }
}
