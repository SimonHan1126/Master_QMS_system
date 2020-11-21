package nz.ac.autuni.qmssystem.daoImpl;

import com.mongodb.client.result.DeleteResult;
import nz.ac.autuni.qmssystem.dao.FMEATableGroupDao;
import nz.ac.autuni.qmssystem.model.FMEATableGroup;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author Simon-the-coder
 * @date 21/11/20 11:28 am
 */
@Component
public class FMEATableGroupDaoImpl implements FMEATableGroupDao {

    @Resource
    MongoTemplate mongoTemplate;

    @Override
    public List<FMEATableGroup> getAllFMEATableGroup() {
        return mongoTemplate.findAll(FMEATableGroup.class);
    }

    @Override
    public void saveFMEATableGroup(FMEATableGroup fmeaTableGroup) {
        mongoTemplate.save(fmeaTableGroup);
    }

    @Override
    public DeleteResult removeFMEATableGroupById(String id) {
        Query query = new Query(Criteria.where("_id").is(id));
        DeleteResult deleteResult = mongoTemplate.remove(query, FMEATableGroup.class);
        return deleteResult;
    }
}
