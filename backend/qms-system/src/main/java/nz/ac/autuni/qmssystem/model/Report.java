package nz.ac.autuni.qmssystem.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Simon-the-coder
 * @date 3/09/20 5:34 pm
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Report {
    private RiskProcedure procedure;
    private FMEATable table;
}
