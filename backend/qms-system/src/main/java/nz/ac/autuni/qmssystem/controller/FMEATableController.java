package nz.ac.autuni.qmssystem.controller;

import nz.ac.autuni.qmssystem.constant.ErrorMessageConstant;
import nz.ac.autuni.qmssystem.errorModel.NonExistentObjectQuery;
import nz.ac.autuni.qmssystem.model.FMEATable;
import nz.ac.autuni.qmssystem.dao.FMEATableDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 3/09/20 4:30 pm
 */
@RestController
@RequestMapping("/api/v1/fmea")
public class FMEATableController {

    @Autowired
    private FMEATableDao fmeaTableService;

    @GetMapping("/findFMEATableById")
    public ResponseEntity<Serializable> findFMEATableById(Long fmeaTableId) {
        FMEATable fmeaTable = fmeaTableService.findFMEATableById(fmeaTableId);
        if(fmeaTable == null) {
            return ResponseEntity.status(HttpStatus.OK).body(new NonExistentObjectQuery(ErrorMessageConstant.NON_EXISTENT_OBJECT));
        } else {
            return ResponseEntity.status(HttpStatus.OK).body(fmeaTable);
        }

    }

    @PostMapping("/saveFMEATable")
    public ResponseEntity<Void> saveFMEATable(@RequestBody FMEATable table) {
        /*
            1. Verify that the user is logged in
            2. Verify that there are variables in the FMEATable that are null
         */
        fmeaTableService.saveFMEATable(table);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/updateFMEATable")
    public ResponseEntity<Void> updateFMEATable(@RequestBody FMEATable table) {
        fmeaTableService.updateFMEATable(table);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/removeFMEATable")
    public ResponseEntity<Void> removeFMEATable(Long fmeaTableId) {
        fmeaTableService.removeFMEATable(fmeaTableId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
 }
