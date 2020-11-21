package nz.ac.autuni.qmssystem.controller;

import com.mongodb.client.result.DeleteResult;
import com.mongodb.internal.bulk.DeleteRequest;
import nz.ac.autuni.qmssystem.dao.FMEATableGroupDao;
import nz.ac.autuni.qmssystem.model.FMEATableGroup;
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
 * @date 21/11/20 11:24 am
 */
@RestController
@RequestMapping("/api/v1/fmeaTableGroup")
public class FMEATableGroupController {
    private static final Logger logger = LogManager.getLogger(FMEATableGroupController.class);

    @Autowired
    private FMEATableGroupDao fmeaTableGroupService;

    @GetMapping("/getAllFMEATableGroup")
    public ResponseEntity<List<FMEATableGroup>> getAllFMEATableGroup() {
        List<FMEATableGroup> list = fmeaTableGroupService.getAllFMEATableGroup();
        logger.info("FMEATableGroupController getAllFMEATableGroup " + list.toString());
        return ResponseEntity.status(HttpStatus.OK).body(list);
    }

    @PostMapping(value = "/saveFMEATableGroup", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<FMEATableGroup>> saveFMEATableGroup(@RequestBody FMEATableGroup fmeaTableGroup) {
        fmeaTableGroupService.saveFMEATableGroup(fmeaTableGroup);
        List<FMEATableGroup> list = fmeaTableGroupService.getAllFMEATableGroup();
        logger.info("FMEATableGroupController saveFMEATableGroup list " + list.toString());
        return ResponseEntity.status(HttpStatus.OK).body(list);
    }

    @GetMapping("/removeFMEATableGroup")
    public ResponseEntity<List<FMEATableGroup>> removeFMEATableGroup(String fmeaTableGroupId) {
        DeleteResult result = fmeaTableGroupService.removeFMEATableGroupById(fmeaTableGroupId);
        logger.info("FMEATableGroupController removeFMEATable result " + result.toString());
        List<FMEATableGroup> list = fmeaTableGroupService.getAllFMEATableGroup();
        logger.info("FMEATableGroupController removeFMEATable list " + list.toString());
        return ResponseEntity.status(HttpStatus.OK).body(list);
    }
}





























