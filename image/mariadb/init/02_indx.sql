ALTER TABLE `analyse_anonymised`.`student_vle` 
ADD INDEX `mod_pres` (`code_module` ASC, `code_presentation` ASC) VISIBLE;