package corp.yumyv.ifh.repositories;

import corp.yumyv.ifh.entities.Record;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RecordRepository extends JpaRepository<Record, Long> {
    Record findByName(String name);
}
