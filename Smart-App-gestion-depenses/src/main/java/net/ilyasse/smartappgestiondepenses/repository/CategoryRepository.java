package net.ilyasse.smartappgestiondepenses.repository;

import net.ilyasse.smartappgestiondepenses.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category,Long> {
}
