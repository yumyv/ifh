package corp.yumyv.ifh.repositories;

import corp.yumyv.ifh.entities.Operation;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OperationRepository extends CrudRepository<Operation, Long> {
    List<Operation> findByUserIdOrderByIdDesc(Long userId);

    List<Operation> findFirst20ByUserIdOrderByIdDesc(Long userId);
}
