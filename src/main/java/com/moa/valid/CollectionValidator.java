package com.moa.valid;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.SpringValidatorAdapter;

import javax.validation.Validation;
import java.lang.reflect.Field;
import java.util.Collection;
import java.util.Collections;

@Component
public class CollectionValidator implements Validator {

    private SpringValidatorAdapter validator;

    public CollectionValidator() {
        this.validator = new SpringValidatorAdapter(
                Validation.buildDefaultValidatorFactory().getValidator()
        );
    }

    @Override
    public boolean supports(Class clazz) {
        return Collection.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        if (target instanceof Collection) {
            Collection collection = (Collection) target;
            for (Object object : collection) {
                validator.validate(object, errors);
            }
        } else {
                validator.validate(target, errors);
        }
    }
}