package net.ilyasse.smartappgestiondepenses.Controller;

import lombok.RequiredArgsConstructor;
import net.ilyasse.smartappgestiondepenses.Service.DashboardService;
import net.ilyasse.smartappgestiondepenses.dto.DashboardStatsDTO;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dashboard")
@RequiredArgsConstructor
@CrossOrigin("*")
public class DashboardController {

    private final DashboardService dashboardService;

    @GetMapping("/{userId}")
    public DashboardStatsDTO getDashboard(
            @PathVariable Long userId,
            @RequestParam Double budget
    ) {
        return dashboardService.getDashboard(userId, budget);
    }
}