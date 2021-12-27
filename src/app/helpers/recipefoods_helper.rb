module RecipefoodsHelper
  
  def recipefood_format(myfood, amount)
    if amount.present?
      myfood.to_f * amount.to_f
    else
      myfood.to_f
    end
  end
  
end
