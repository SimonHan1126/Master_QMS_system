package nz.ac.autuni.qmssystem.service;

import nz.ac.autuni.qmssystem.repository.FMEATableRepository;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author Simon-the-coder
 * @date 3/09/20 6:01 pm
 */
public class FMEATableService implements IFMEATableService{

    @Autowired
    private FMEATableRepository fmeaTableRepository;
}
