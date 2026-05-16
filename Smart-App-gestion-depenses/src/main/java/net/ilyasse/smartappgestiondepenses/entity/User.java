package net.ilyasse.smartappgestiondepenses.entity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String fullName;

    @Column(unique = true)
    private String email;

    private Double monthlyBudget;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @JsonIgnore

    private List<Transaction> transactions;
}
