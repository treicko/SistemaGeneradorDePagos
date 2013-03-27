require('date')

class Empleado
  def initialize(fecha_inicio_contrato)
    @fecha_inicio_contrato = fecha_inicio_contrato
  end
  def con_salario_fijo(monto)
     @salario = monto
  end

  def obtener_salario()
    @salario
  end

  def con_nombre(nombre)
    @nombre = nombre
  end

  def obtener_nombre()
    @nombre
  end

  def con_apellido(apellido)
    @apellido = apellido
  end

  def obtener_apellido()
    @apellido
  end

  def con_ci(ci)
    @ci = ci
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

  def generar_salario(fecha_ejecucion)
    if (ha_sido_contratado_este_mes?(fecha_ejecucion))
      prorratear_salario(fecha_ejecucion)
    end
  end

  def prorratear_salario(fecha_ejecucion)
    dias_trabajados = (fecha_ejecucion.mjd - obtener_fecha_inicio_contrato.mjd) + 1
    fact_salario = obtener_salario / (Date.civil(fecha_ejecucion.year, fecha_ejecucion.month, -1)).day.to_f
    monto_correspondiente = fact_salario * dias_trabajados
    con_salario_fijo(monto_correspondiente)
  end

  def ha_sido_contratado_este_mes?(fecha_ejecucion)
    obtener_fecha_inicio_contrato.month==fecha_ejecucion.month &&
        obtener_fecha_inicio_contrato.year==fecha_ejecucion.year
  end

end