package nz.ac.autuni.qmssystem.repository;

import nz.ac.autuni.qmssystem.model.RiskProcedure;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

/**
 * @author Simon-the-coder
 * @date 3/09/20 5:49 pm
 */
@Repository
public interface RiskProcedureRepository extends MongoRepository<RiskProcedure, Long> {

}
