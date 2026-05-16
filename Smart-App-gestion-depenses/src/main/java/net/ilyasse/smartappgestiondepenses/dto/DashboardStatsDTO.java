package net.ilyasse.smartappgestiondepenses.dto;

import lombok.*;

import java.util.Map;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DashboardStatsDTO {

    private Double totalIncome;
    private Double totalExpense;
    private Double balance;
    private Double budget;
    private Boolean budgetExceeded;
    private Map<String, Double> expensesByCategory;
}
