package net.ilyasse.smartappgestiondepenses.Service;

import lombok.RequiredArgsConstructor;
import net.ilyasse.smartappgestiondepenses.entity.Transaction;
import net.ilyasse.smartappgestiondepenses.repository.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TransactionService {
    @Autowired
    private final TransactionRepository transactionRepository;

    /*
     * CREATE TRANSACTION
     */
    public Transaction createTransaction(Transaction transaction) {

        return transactionRepository.save(transaction);
    }

    /*
     * GET ALL TRANSACTIONS
     */
    public List<Transaction> getAllTransactions() {

        return transactionRepository.findAll();
    }

    /*
     * GET TRANSACTION BY ID
     */
    public Transaction getTransactionById(Long id) {

        return transactionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Transaction not found"));
    }

    /*
     * DELETE TRANSACTION
     */
    public void deleteTransaction(Long id) {

        transactionRepository.deleteById(id);
    }
    public List<Transaction> filter(Long userId, Long categoryId, int month, int year) {

        List<Transaction> transactions;

        if (categoryId != null) {
            transactions = transactionRepository.findByUserIdAndCategoryId(userId, categoryId);
        } else {
            transactions = transactionRepository.findByUserId(userId);
        }

        return transactions.stream()
                .filter(t -> t.getDate().getMonthValue() == month)
                .filter(t -> t.getDate().getYear() == year)
                .toList();
    }

}
