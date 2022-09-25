module SuppliersHelper
  def formatted_cnpj(cnpj_number)
    CNPJ.new(cnpj_number).formatted
  end
end
