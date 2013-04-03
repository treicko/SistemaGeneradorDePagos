require('date')

class Empleado
  def initialize(ci, nombre, apellido, fecha_inicio_contrato)
    @ci = ci
    @nombre = nombre
    @apellido = apellido
    @fecha_inicio_contrato = fecha_inicio_contrato
  end

  def asignar_salario_fijo(monto)
     @salario = monto
  end

  def obtener_salario()
    @salario
  end

  def obtener_nombre()
    @nombre
  end

  def obtener_apellido()
    @apellido
  end

  def obtener_ci()
    @ci
  end

  def asignar_fecha_inicio_contrato(fecha)
    @fecha_inicio_contrato = fecha
  end

  def obtener_fecha_inicio_contrato()
    @fecha_inicio_contrato
  end

  def calcular_salario(fecha_ejecucion)
    if (ha_sido_contratado_este_mes?(fecha_ejecucion))
          calcular_salario_prorrateado(fecha_ejecucion)
    else
      @salario
    end
  end

  def calcular_salario_prorrateado(fecha_ejecucion)
    dias_trabajados = calcular_dias_trabajados_hasta(fecha_ejecucion)
    salario_diario = calcular_salario_diario(fecha_ejecucion)
    salario_diario * dias_trabajados
  end

  private

  def calcular_salario_diario(fecha_ejecucion)
    fact_salario = obtener_salario / (Date.civil(fecha_ejecucion.year, fecha_ejecucion.month, -1)).day.to_f
  end

  def calcular_dias_trabajados_hasta(fecha_ejecucion)
    dias_trabajados = (fecha_ejecucion.mjd - obtener_fecha_inicio_contrato.mjd) + 1
  end

  def ha_sido_contratado_este_mes?(fecha_ejecucion)
    obtener_fecha_inicio_contrato.month==fecha_ejecucion.month &&
        obtener_fecha_inicio_contrato.year==fecha_ejecucion.year
  end

end