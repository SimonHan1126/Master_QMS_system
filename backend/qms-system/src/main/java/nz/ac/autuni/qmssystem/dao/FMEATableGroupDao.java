package nz.ac.autuni.qmssystem.dao;

import com.mongodb.client.result.DeleteResult;
import nz.ac.autuni.qmssystem.model.FMEATableGroup;

import java.util.List;

/**
 * @author Simon-the-coder
 * @date 21/11/20 11:26 am
 */
public interface FMEATableGroupDao {

    List<FMEATableGroup> getAllFMEATableGroup();

    void saveFMEATableGroup(FMEATableGroup fmeaTableGroup);

    DeleteResult removeFMEATableGroupById(String id);
}
