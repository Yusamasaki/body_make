module PfcRatiosHelper
  
  def pfc_ratios_protein(pfc)
    if pfc.nil?
      20
    else
      pfc
    end
  end
  
  def pfc_ratios_fat(pfc)
    if pfc.nil?
      20
    else
      pfc
    end
  end
  
  def pfc_ratios_carbo(pfc)
    if pfc.nil?
      60
    else
      pfc
    end
  end
  
end
