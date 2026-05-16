package net.ilyasse.smartappgestiondepenses.Service;

import lombok.RequiredArgsConstructor;
import net.ilyasse.smartappgestiondepenses.entity.Category;
import net.ilyasse.smartappgestiondepenses.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryService {
    @Autowired
    private final CategoryRepository categoryRepository;

    public List<Category> getAll() {
        return categoryRepository.findAll();
    }

    public Category create(Category category) {
        return categoryRepository.save(category);
    }

    public void delete(Long id) {
        categoryRepository.deleteById(id);
    }
}
