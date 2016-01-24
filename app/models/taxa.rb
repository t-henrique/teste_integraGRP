class Taxa

  def defineTaxa(valor, created_at)
    valorTaxa = 0.00
    valorTaxa += defineValorTaxa(created_at, valor)
    # valorTaxa += defineValorTaxa(valor)
    return valorTaxa
  end

  # private
  def defineValorTaxa(horarioTransferencia, valorTransferencia)
    valor = defineDia(horarioTransferencia)
    valor += defineTaxaSobreValor(valorTransferencia)
    return valor
  end

  def defineDia(horarioTransferencia)
    if (horarioTransferencia.sunday? || horarioTransferencia.saturday?)
      valor = 7.00
      return valor
    elsif (horarioTransferencia.between?(Time.parse("8am"), Time.parse("18pm")))
      valor = 5.00
    else
      valor = 7.00
    end
  end

  def defineTaxaSobreValor(valorTransferencia)
    valor = 0
    if valorTransferencia > 1000
      valor += 10.00
    else
      valor = 0
    end
    return valor
  end
  # def defineValorTaxa(horarioTransferencia, valorTransferencia)
  #   valor = 0
  #   if (horarioTransferencia.sunday? || horarioTransferencia.saturday?)
  #     valor = 7.00
  #     return valor
  #   end
  #   if (horarioTransferencia.between?(Time.parse("8am"), Time.parse("18pm")))
  #       valor = 5.00
  #     end
  #   else
  #     valor = 7.00
  #   end
  #   if valorTransferencia > 1000
  #     valor += 10.00
  #   end
  #   return valor
  # end
  #
  #
  # def defineValorTaxa(valor)
  #   valorTaxa = 0
  #   if valor > 1000
  #     valorTaxa += 10.00
  #   end
  #   return valorTaxa
  # end

end
