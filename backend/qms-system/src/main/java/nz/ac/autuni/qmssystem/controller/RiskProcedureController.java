package nz.ac.autuni.qmssystem.controller;

import com.mongodb.client.result.DeleteResult;
import nz.ac.autuni.qmssystem.constant.ErrorMessageConstant;
import nz.ac.autuni.qmssystem.dao.FMEATableDao;
import nz.ac.autuni.qmssystem.dao.RiskProcedureDao;
import nz.ac.autuni.qmssystem.errorModel.NonExistentObjectQuery;
import nz.ac.autuni.qmssystem.model.FMEATable;
import nz.ac.autuni.qmssystem.model.RiskProcedure;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;
import java.util.List;

/**
 * @author Simon-the-coder
 * @date 3/09/20 1:38 pm
 */
@RestController
@RequestMapping("/api/v1/risk_procedure")
public class RiskProcedureController {

    private static final Logger logger = LogManager.getLogger(RiskProcedureController.class);

    @Autowired
    private RiskProcedureDao riskProcedureService;
    @Autowired
    private FMEATableDao fmeaTableService;

    @GetMapping("/findRiskProcedureById")
    public ResponseEntity<Serializable> findRiskProcedureById(String riskProcedureId) {
        RiskProcedure riskProcedure = riskProcedureService.findRiskProcedureById(riskProcedureId);
        if(riskProcedure == null) {
            return ResponseEntity.status(HttpStatus.OK).body(new NonExistentObjectQuery(ErrorMessageConstant.NON_EXISTENT_OBJECT));
        } else {
            return ResponseEntity.status(HttpStatus.OK).body(riskProcedure);
        }
    }

    @GetMapping("/getAllRiskProcedure")
    public ResponseEntity<List<RiskProcedure>> getAllRiskProcedure() {
        List<RiskProcedure> list = riskProcedureService.getAllRiskProcedure();
        logger.info("this is getAllRiskProcedure " + list.toString());
        return ResponseEntity.status(HttpStatus.OK).body(list);
    }

    @PostMapping(value = "/saveRiskProcedure", consumes = MediaType.APPLICATION_JSON_VALUE )
    public ResponseEntity<Serializable> saveRiskProcedure(@RequestBody RiskProcedure riskProcedure) {
        /*
            1. Verify that the user is logged in
            2. Verify that there are variables in the RiskProcedure that are null
         */
        riskProcedureService.saveRiskProcedure(riskProcedure);
//        FMEATable table = new FMEATable();
//        table.setHazardId(riskProcedure.getRiskProcedureId());
//        table.setHarm(riskProcedure.getHarm());
//        logger.info("this is saveRiskProcedure table " + table.toString());
        logger.info("this is saveRiskProcedure riskProcedure " + riskProcedure.toString());
//        fmeaTableService.saveFMEATable(table);
        return ResponseEntity.status(HttpStatus.OK).body(riskProcedure);
    }

    @PostMapping("/updateRiskProcedure")
    public ResponseEntity<Void> updateRiskProcedure(@RequestBody RiskProcedure riskProcedure) {
        logger.info("this is updateRiskProcedure riskProcedure " + riskProcedure.toString());
        riskProcedureService.updateRiskProcedure(riskProcedure);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/removeRiskProcedure")
    public ResponseEntity<List<RiskProcedure>> removeRiskProcedure(String riskProcedureId) {
        DeleteResult result =  riskProcedureService.removeRiskProcedure(riskProcedureId);
        logger.info("this is removeRiskProcedure result " + result.toString());
        List<RiskProcedure> list = riskProcedureService.getAllRiskProcedure();
        logger.info("this is removeRiskProcedure " + list.toString());
        return ResponseEntity.status(HttpStatus.OK).body(list);
    }
}
