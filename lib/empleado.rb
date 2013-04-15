require('date')

class Empleado
  attr_reader :nombre, :apellido, :ci
  def initialize(ci, nombre, apellido, fecha_inicio_contrato)
    @ci = ci
    @nombre = nombre
    @apellido = apellido
    @fecha_inicio_contrato = fecha_inicio_contrato

    @descuento_fijo_por_sindicato = 0
    @tarjetas_de_servicio = Array.new
    @descuento_por_servicios = 0
    @tarjetas_de_tiempo = Array.new
    @total_horas_trabajadas = 0
  end

  def asignar_salario_fijo(monto)
     @salario = monto
  end

  def asignar_fecha_inicio_contrato(fecha)
    @fecha_inicio_contrato = fecha
  end

  def calcular_salario(fecha_ejecucion)
    if (ha_sido_contratado_este_mes?(fecha_ejecucion))
          calcular_salario_prorrateado(fecha_ejecucion) - @descuento_fijo_por_sindicato - calcular_monto_por_servicios_sindicato
    else
      @salario - @descuento_fijo_por_sindicato - calcular_monto_por_servicios_sindicato
    end
  end

  def calcular_salario_prorrateado(fecha_ejecucion)
    dias_trabajados = calcular_dias_trabajados_hasta(fecha_ejecucion)
    salario_diario = calcular_salario_diario(fecha_ejecucion)
    salario_diario * dias_trabajados
  end

  def asignar_descuento_sindicato(monto)
    @descuento_fijo_por_sindicato = monto
  end

  def registrar_tarjeta_de_servicio(tarjeta_de_servicio)
    @tarjetas_de_servicio.push(tarjeta_de_servicio)
  end

  def calcular_monto_por_servicios_sindicato
    @tarjetas_de_servicio.each { |t| @descuento_por_servicios += t.monto}
    @descuento_por_servicios
  end

  #metodos para empleados que trabajan por hora

  def asignar_pago_por_hora(monto)
    @monto_por_hora = monto
  end
  
  def registrar_tarjeta_de_tiempo(tarjeta_de_tiempo)
    @tarjetas_de_tiempo.push(tarjeta_de_tiempo)
  end

  def calcular_salario_con_tarjetas_de_tiempo()
    @tarjetas_de_tiempo.each { |t| @total_horas_trabajadas += t.calcular_horas_trabajadas }
    (@total_horas_trabajadas * @monto_por_hora) - @descuento_fijo_por_sindicato
  end

  private

  def calcular_salario_diario(fecha_ejecucion)
    fact_salario = @salario / (Date.civil(fecha_ejecucion.year, fecha_ejecucion.month, -1)).day.to_f
  end

  def calcular_dias_trabajados_hasta(fecha_ejecucion)
    dias_trabajados = (fecha_ejecucion.mjd - @fecha_inicio_contrato.mjd) + 1
  end

  def ha_sido_contratado_este_mes?(fecha_ejecucion)
    @fecha_inicio_contrato.month==fecha_ejecucion.month &&
        @fecha_inicio_contrato.year==fecha_ejecucion.year
  end

end