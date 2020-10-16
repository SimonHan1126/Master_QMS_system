package nz.ac.autuni.qmssystem.errorModel;

import lombok.*;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 5/09/20 10:05 am
 */
@RequiredArgsConstructor
@NoArgsConstructor
public class ErrorMessageObject implements Serializable {
    @Setter @Getter @NonNull
    private String message;
    @Getter
    private int errorTag = 1;
}
