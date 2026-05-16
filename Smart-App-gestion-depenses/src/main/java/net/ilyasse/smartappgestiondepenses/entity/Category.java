package net.ilyasse.smartappgestiondepenses.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String name;

    private String icon;

    private String color;

    @OneToMany(mappedBy = "category")
    @JsonIgnore

    private List<Transaction> transactions;
}
