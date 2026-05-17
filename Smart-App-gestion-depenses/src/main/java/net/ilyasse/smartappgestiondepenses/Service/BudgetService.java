package net.ilyasse.smartappgestiondepenses.Service;


import lombok.RequiredArgsConstructor;
import net.ilyasse.smartappgestiondepenses.entity.Budget;
import net.ilyasse.smartappgestiondepenses.repository.BudgetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class BudgetService {
    

    private final BudgetRepository budgetRepository;

    public Budget saveBudget(Budget budget) {
        Optional<Budget> existing =
                budgetRepository.findByMonth(budget.getMonth());
        if (existing.isPresent()) {
            Budget oldBudget = existing.get();
            oldBudget.setAmount(budget.getAmount());

            return budgetRepository.save(oldBudget);
        }

        return budgetRepository.save(budget);
    }

    public Budget getBudgetByMonth(String month) {
        return budgetRepository
                .findByMonth(month)
                .orElse(new Budget(0, month));
    }
}
