package net.ilyasse.smartappgestiondepenses.Controller;
import lombok.RequiredArgsConstructor;
import net.ilyasse.smartappgestiondepenses.Service.TransactionService;
import net.ilyasse.smartappgestiondepenses.entity.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequestMapping("/api/transactions")
@RequiredArgsConstructor
@CrossOrigin("*")
public class TransactionController {
    @Autowired
    private  TransactionService transactionService;

    /*
     * CREATE TRANSACTION
     */
    @PostMapping
    public Transaction createTransaction(@RequestBody Transaction transaction) {

        return transactionService.createTransaction(transaction);
    }

    /*
     * GET ALL TRANSACTIONS
     */
    @GetMapping
    public List<Transaction> getAllTransactions() {

        return transactionService.getAllTransactions();
    }

    /*
     * GET TRANSACTION BY ID
     */
    @GetMapping("/{id}")
    public Transaction getTransactionById(@PathVariable Long id) {

        return transactionService.getTransactionById(id);
    }

    /*
     * DELETE TRANSACTION
     */
    @DeleteMapping("/{id}")
    public void deleteTransaction(@PathVariable Long id) {

        transactionService.deleteTransaction(id);
    }
    @GetMapping("/filter")
    public List<Transaction> filter(
            @RequestParam Long userId,
            @RequestParam(required = false) Long categoryId,
            @RequestParam int month,
            @RequestParam int year
    ) {
        return transactionService.filter(userId, categoryId, month, year);
    }

}
