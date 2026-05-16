package net.ilyasse.smartappgestiondepenses.Service;

import lombok.RequiredArgsConstructor;
import net.ilyasse.smartappgestiondepenses.dto.DashboardStatsDTO;
import net.ilyasse.smartappgestiondepenses.repository.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DashboardService {
    @Autowired
    private final TransactionRepository transactionRepository;

    public DashboardStatsDTO getDashboard(Long userId, Double budget) {

        Double income = transactionRepository.getTotalIncome(userId);
        Double expense = transactionRepository.getTotalExpense(userId);

        income = income == null ? 0.0 : income;
        expense = expense == null ? 0.0 : expense;

        Double balance = income - expense;

        // CATEGORY MAP
        List<Object[]> rawData = transactionRepository.getExpensesByCategory(userId);

        Map<String, Double> expensesByCategory = new HashMap<>();

        for (Object[] row : rawData) {
            String category = (String) row[0];
            Double amount = (Double) row[1];
            expensesByCategory.put(category, amount);
        }

        return DashboardStatsDTO.builder()
                .totalIncome(income)
                .totalExpense(expense)
                .balance(balance)
                .budget(budget)
                .budgetExceeded(expense > budget)
                .expensesByCategory(expensesByCategory)
                .build();
    }
}
