package nz.ac.autuni.qmssystem.daoImpl;

import nz.ac.autuni.qmssystem.dao.RiskProcedureDao;
import nz.ac.autuni.qmssystem.model.FMEATable;
import nz.ac.autuni.qmssystem.model.RiskProcedure;
import nz.ac.autuni.qmssystem.util.BaseUtil;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @author Simon-the-coder
 * @date 3/09/20 6:02 pm
 */
@Component
public class RiskProcedureDaoImpl implements RiskProcedureDao {

    @Resource
    MongoTemplate mongoTemplate;

    @Override
    public void saveRiskProcedure(RiskProcedure riskProcedure) {
        mongoTemplate.save(riskProcedure);
    }

    @Override
    public void removeRiskProcedure(Long id) {
        mongoTemplate.remove(id);
    }

    @Override
    public void updateRiskProcedure(RiskProcedure riskProcedure) {
        Query query = new Query(Criteria.where("_id").is(riskProcedure.getRiskProcedureId()));
        mongoTemplate.updateFirst(query, BaseUtil.getInstance().pushObjectToUpdate(riskProcedure), FMEATable.class);
    }

    @Override
    public RiskProcedure findRiskProcedureById(Long id) {
        Query query = new Query(Criteria.where("_id").is(id));
        RiskProcedure riskProcedure = mongoTemplate.findOne(query, RiskProcedure.class);
        return riskProcedure;
    }

    @Override
    public void approveRiskProcedure(Long id) {
        Query query = new Query(Criteria.where("_id").is(id));

        Update update = new Update();
        update.set("isApprove", true);
        mongoTemplate.updateFirst(query, update, FMEATable.class);
    }
}
