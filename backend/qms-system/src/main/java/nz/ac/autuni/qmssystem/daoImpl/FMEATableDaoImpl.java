package nz.ac.autuni.qmssystem.daoImpl;

import nz.ac.autuni.qmssystem.dao.FMEATableDao;
import nz.ac.autuni.qmssystem.model.FMEATable;
import nz.ac.autuni.qmssystem.util.BaseUtil;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

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
    public void removeFMEATable(Long id) {
        mongoTemplate.remove(id);
    }

    @Override
    public void updateFMEATable(FMEATable fmeaTable) {
        Query query = new Query(Criteria.where("_id").is(fmeaTable.getHazardId()));
        mongoTemplate.updateFirst(query, BaseUtil.getInstance().pushObjectToUpdate(fmeaTable), FMEATable.class);
    }

    @Override
    public FMEATable findFMEATableById(Long id) {
        Query query = new Query(Criteria.where("_id").is(id));
        FMEATable fmeaTable = mongoTemplate.findOne(query, FMEATable.class);
        return fmeaTable;
    }

    @Override
    public void approveFMEATable(Long id) {
        Query query = new Query(Criteria.where("_id").is(id));
        Update update = new Update();
        update.set("acceptability", true);
        mongoTemplate.updateFirst(query, update, FMEATable.class);
    }
}
