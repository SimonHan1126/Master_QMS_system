package nz.ac.autuni.qmssystem.dao;

import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.UpdateResult;
import nz.ac.autuni.qmssystem.model.FMEATable;

import java.util.List;

/**
 * @author Simon-the-coder
 * @date 3/09/20 6:00 pm
 */
public interface FMEATableDao {

    void saveFMEATable(FMEATable fmeaTable);

    DeleteResult removeFMEATable(String id);

    void updateFMEATable(FMEATable fmeaTable);

    FMEATable findFMEATableById(String id);

    List<FMEATable> getAllFMEATable();

    UpdateResult approveFMEATable(String id);
}
