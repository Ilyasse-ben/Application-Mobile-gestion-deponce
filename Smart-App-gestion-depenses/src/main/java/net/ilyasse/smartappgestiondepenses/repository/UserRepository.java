package net.ilyasse.smartappgestiondepenses.repository;

import net.ilyasse.smartappgestiondepenses.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    boolean existsByEmail(String email);

}
