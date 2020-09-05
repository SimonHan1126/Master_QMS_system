package nz.ac.autuni.qmssystem.controller;

import nz.ac.autuni.qmssystem.constant.ErrorMessageConstant;
import nz.ac.autuni.qmssystem.dao.RiskProcedureDao;
import nz.ac.autuni.qmssystem.errorModel.NonExistentObjectQuery;
import nz.ac.autuni.qmssystem.model.RiskProcedure;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 3/09/20 1:38 pm
 */
@RestController
@RequestMapping("/api/v1/risk_procedure")
public class RiskProcedureController {

    @Autowired
    private RiskProcedureDao riskProcedureService;

    @GetMapping("/findRiskProcedureById")
    public ResponseEntity<Serializable> findRiskProcedureById(Long riskProcedureId) {
        RiskProcedure riskProcedure = riskProcedureService.findRiskProcedureById(riskProcedureId);
        if(riskProcedure == null) {
            return ResponseEntity.status(HttpStatus.OK).body(new NonExistentObjectQuery(ErrorMessageConstant.NON_EXISTENT_OBJECT));
        } else {
            return ResponseEntity.status(HttpStatus.OK).body(riskProcedure);
        }

    }

    @PostMapping("/saveRiskProcedure")
    public ResponseEntity<Void> saveRiskProcedure(@RequestBody RiskProcedure riskProcedure) {
        /*
            1. Verify that the user is logged in
            2. Verify that there are variables in the RiskProcedure that are null
         */
        riskProcedureService.saveRiskProcedure(riskProcedure);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/updateRiskProcedure")
    public ResponseEntity<Void> updateRiskProcedure(@RequestBody RiskProcedure riskProcedure) {
        riskProcedureService.updateRiskProcedure(riskProcedure);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/removeRiskProcedure")
    public ResponseEntity<Void> removeRiskProcedure(Long riskProcedureId) {
        riskProcedureService.removeRiskProcedure(riskProcedureId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
