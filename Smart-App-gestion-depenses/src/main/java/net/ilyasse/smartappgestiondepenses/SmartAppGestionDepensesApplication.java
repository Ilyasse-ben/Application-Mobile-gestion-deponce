package net.ilyasse.smartappgestiondepenses;

import net.ilyasse.smartappgestiondepenses.entity.Category;
import net.ilyasse.smartappgestiondepenses.entity.Transaction;
import net.ilyasse.smartappgestiondepenses.entity.TransactionType;
import net.ilyasse.smartappgestiondepenses.entity.User;
import net.ilyasse.smartappgestiondepenses.repository.CategoryRepository;
import net.ilyasse.smartappgestiondepenses.repository.TransactionRepository;
import net.ilyasse.smartappgestiondepenses.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.time.LocalDate;

@SpringBootApplication
public class SmartAppGestionDepensesApplication {

    public static void main(String[] args) {
        SpringApplication.run(SmartAppGestionDepensesApplication.class, args);
    }

    @Bean
    CommandLineRunner run(
            UserRepository userRepository,
            CategoryRepository categoryRepository,
            TransactionRepository transactionRepository
    ) {
        return args -> {

            // éviter duplication
            if (userRepository.count() > 0) return;

            // USER
            User user = User.builder()
                    .fullName("Ilyasse")
                    .email("ilyasse@gmail.com")
                    .monthlyBudget(5000.0)
                    .build();

            userRepository.save(user);

            // CATEGORIES
            Category food = categoryRepository.save(
                    Category.builder()
                            .name("Food")
                            .icon("restaurant")
                            .color("#FF6384")
                            .build()
            );

            Category transport = categoryRepository.save(
                    Category.builder()
                            .name("Transport")
                            .icon("car")
                            .color("#36A2EB")
                            .build()
            );

            Category rent = categoryRepository.save(
                    Category.builder()
                            .name("Rent")
                            .icon("home")
                            .color("#FFCE56")
                            .build()
            );

            // TRANSACTIONS
            transactionRepository.save(Transaction.builder()
                    .amount(120.0)
                    .type(TransactionType.EXPENSE)
                    .date(LocalDate.now())
                    .note("McDonald's")
                    .user(user)
                    .category(food)
                    .build()
            );

            transactionRepository.save(Transaction.builder()
                    .amount(80.0)
                    .type(TransactionType.EXPENSE)
                    .date(LocalDate.now())
                    .note("Taxi")
                    .user(user)
                    .category(transport)
                    .build()
            );

            transactionRepository.save(Transaction.builder()
                    .amount(1000.0)
                    .type(TransactionType.EXPENSE)
                    .date(LocalDate.now())
                    .note("Monthly Rent")
                    .user(user)
                    .category(rent)
                    .build()
            );

            transactionRepository.save(Transaction.builder()
                    .amount(7000.0)
                    .type(TransactionType.INCOME)
                    .date(LocalDate.now())
                    .note("Freelance Work")
                    .user(user)
                    .category(null)
                    .build()
            );

            System.out.println("✅ DATA SEEDED SUCCESSFULLY");
        };
    }

}
