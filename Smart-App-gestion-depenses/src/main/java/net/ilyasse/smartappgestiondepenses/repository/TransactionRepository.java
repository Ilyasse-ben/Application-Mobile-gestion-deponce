package net.ilyasse.smartappgestiondepenses.repository;

import net.ilyasse.smartappgestiondepenses.entity.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import org.springframework.data.jpa.repository.Query;

public interface TransactionRepository extends JpaRepository<Transaction,Long> {
    List<Transaction> findByUserId(Long userId);

    List<Transaction> findByCategoryId(Long categoryId);

    List<Transaction> findByDateBetween(LocalDate start, LocalDate end);
    List<Transaction> findByUserIdAndCategoryId(Long userId, Long categoryId);
    @Query("SELECT SUM(t.amount) FROM Transaction t WHERE t.type = 'INCOME' AND t.user.id = :userId")
    Double getTotalIncome(Long userId);
    @Query("SELECT SUM(t.amount) FROM Transaction t WHERE t.type = 'EXPENSE' AND t.user.id = :userId")
    Double getTotalExpense(Long userId);
    @Query("""
        SELECT t.category.name, SUM(t.amount)
        FROM Transaction t
        WHERE t.type = 'EXPENSE' AND t.user.id = :userId
        GROUP BY t.category.name
       """)
    List<Object[]> getExpensesByCategory(Long userId);
}
