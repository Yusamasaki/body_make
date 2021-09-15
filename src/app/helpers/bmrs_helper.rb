module BmrsHelper
  
  def bmr_format(gender, body_weight, height, age)
    if gender == "男性"
      (body_weight * 13.397) + (height * 4.799) - (age * 5.677) + 88.362
    else
      (body_weight * 9.247) + (height * 3.098) - (age * 4.33) + 447.593
    end
  end
end
