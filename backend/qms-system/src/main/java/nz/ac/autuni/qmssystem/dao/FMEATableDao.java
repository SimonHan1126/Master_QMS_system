package nz.ac.autuni.qmssystem.dao;

import nz.ac.autuni.qmssystem.model.FMEATable;

/**
 * @author Simon-the-coder
 * @date 3/09/20 6:00 pm
 */
public interface FMEATableDao {

    void saveFMEATable(FMEATable fmeaTable);

    void removeFMEATable(Long id);

    void updateFMEATable(FMEATable fmeaTable);

    FMEATable findFMEATableById(Long id);

    void approveFMEATable(Long id);
}
