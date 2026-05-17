package net.ilyasse.smartappgestiondepenses.Service;

import net.ilyasse.smartappgestiondepenses.entity.Category;
import net.ilyasse.smartappgestiondepenses.repository.CategoryRepository;

import java.util.List;

public interface ICategoryService {

    List<Category> getAll();
    Category create(Category category);
    void delete(Long id);
}
