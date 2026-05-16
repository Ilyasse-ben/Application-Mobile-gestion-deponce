package net.ilyasse.smartappgestiondepenses.Controller;



import net.ilyasse.smartappgestiondepenses.Service.BudgetService;
import net.ilyasse.smartappgestiondepenses.entity.Budget;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/budgets")
@CrossOrigin("*")
public class BudgetController {
    @Autowired
    private final BudgetService budgetService;

    public BudgetController(BudgetService budgetService) {
        this.budgetService = budgetService;
    }

    @PostMapping
    public Budget saveBudget(@RequestBody Budget budget) {
        return budgetService.saveBudget(budget);
    }

    @GetMapping("/{month}")
    public Budget getBudget(@PathVariable String month) {
        return budgetService.getBudgetByMonth(month);
    }
}
