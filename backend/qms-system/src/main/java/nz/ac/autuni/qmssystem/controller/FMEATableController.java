package nz.ac.autuni.qmssystem.controller;

import com.mongodb.client.result.DeleteResult;
import nz.ac.autuni.qmssystem.constant.ErrorMessageConstant;
import nz.ac.autuni.qmssystem.errorModel.NonExistentObjectQuery;
import nz.ac.autuni.qmssystem.model.FMEATable;
import nz.ac.autuni.qmssystem.dao.FMEATableDao;
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
 * @date 3/09/20 4:30 pm
 */
@RestController
@RequestMapping("/api/v1/fmea")
public class FMEATableController {

    private static final Logger logger = LogManager.getLogger(FMEATableController.class);

    @Autowired
    private FMEATableDao fmeaTableService;

    @GetMapping("/findFMEATableById")
    public ResponseEntity<Serializable> findFMEATableById(String fmeaTableId) {
        FMEATable fmeaTable = fmeaTableService.findFMEATableById(fmeaTableId);
        if(fmeaTable == null) {
            return ResponseEntity.status(HttpStatus.OK).body(new NonExistentObjectQuery(ErrorMessageConstant.NON_EXISTENT_OBJECT));
        } else {
            return ResponseEntity.status(HttpStatus.OK).body(fmeaTable);
        }
    }

    @GetMapping("/getAllFMEATable")
    public ResponseEntity<List<FMEATable>> getAllFMEATable() {
        List<FMEATable> list = fmeaTableService.getAllFMEATable();
        logger.info("this is getAllFMEATable " + list.toString());
        return ResponseEntity.status(HttpStatus.OK).body(list);
    }

    @PostMapping(value = "/saveFMEATable", consumes = MediaType.APPLICATION_JSON_VALUE )
    public ResponseEntity<Serializable> saveFMEATable(@RequestBody FMEATable table) {
        /*
            1. Verify that the user is logged in
            2. Verify that there are variables in the FMEATable that are null
         */
        fmeaTableService.saveFMEATable(table);
        return ResponseEntity.status(HttpStatus.OK).body(table);
    }

    @PostMapping("/updateFMEATable")
    public ResponseEntity<Void> updateFMEATable(@RequestBody FMEATable table) {
        fmeaTableService.updateFMEATable(table);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/removeFMEATable")
    public ResponseEntity<List<FMEATable>> removeFMEATable(String fmeaTableId) {
        DeleteResult result = fmeaTableService.removeFMEATable(fmeaTableId);
        logger.info("this is removeFMEATable result " + result.toString());
        List<FMEATable> list = fmeaTableService.getAllFMEATable();
        logger.info("this is removeFMEATable " + list.toString());
        return ResponseEntity.status(HttpStatus.OK).body(list);
    }
 }
