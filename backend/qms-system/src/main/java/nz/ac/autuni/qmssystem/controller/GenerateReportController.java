package nz.ac.autuni.qmssystem.controller;

import nz.ac.autuni.qmssystem.dao.FMEATableDao;
import nz.ac.autuni.qmssystem.dao.RiskProcedureDao;
import nz.ac.autuni.qmssystem.model.Report;
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
@RequestMapping("/api/v1/generate_report")
public class GenerateReportController {

    @Autowired
    private FMEATableDao fmeaTableService;
    @Autowired
    private RiskProcedureDao riskProcedureService;

    @PostMapping("/generateReport")
    public ResponseEntity<Report> generateReport(String fmeaTableId, String riskProcedureId) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(new Report(riskProcedureService.findRiskProcedureById(riskProcedureId),fmeaTableService.findFMEATableById(fmeaTableId)));
    }
}
