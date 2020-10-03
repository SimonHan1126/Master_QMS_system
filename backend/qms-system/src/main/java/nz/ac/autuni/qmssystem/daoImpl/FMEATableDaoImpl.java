package nz.ac.autuni.qmssystem.daoImpl;

import com.mongodb.client.result.DeleteResult;
import nz.ac.autuni.qmssystem.dao.FMEATableDao;
import nz.ac.autuni.qmssystem.model.FMEATable;
import nz.ac.autuni.qmssystem.util.BaseUtil;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author Simon-the-coder
 * @date 3/09/20 6:01 pm
 */
@Component
public class FMEATableDaoImpl implements FMEATableDao {

    @Resource
    MongoTemplate mongoTemplate;

    @Override
    public void saveFMEATable(FMEATable fmeaTable) {
        mongoTemplate.save(fmeaTable);
    }

    @Override
    public DeleteResult removeFMEATable(String id) {
        Query query = new Query(Criteria.where("_id").is(id));
        DeleteResult deleteResult = mongoTemplate.remove(query, FMEATable.class);
        return deleteResult;
    }

    @Override
    public void updateFMEATable(FMEATable fmeaTable) {
//        Query query = new Query(Criteria.where("_id").is(fmeaTable.getHazardId()));
//        mongoTemplate.updateFirst(query, BaseUtil.getInstance().setObjectToUpdate(fmeaTable), FMEATable.class);
    }

    @Override
    public FMEATable findFMEATableById(String id) {
        Query query = new Query(Criteria.where("_id").is(id));
        FMEATable fmeaTable = mongoTemplate.findOne(query, FMEATable.class);
        return fmeaTable;
    }

    @Override
    public List<FMEATable> getAllFMEATable() {
        return mongoTemplate.findAll(FMEATable.class);
    }

    @Override
    public void approveFMEATable(String id) {
        Query query = new Query(Criteria.where("_id").is(id));
        Update update = new Update();
        update.set("acceptability", true);
        mongoTemplate.updateFirst(query, update, FMEATable.class);
    }
}
