require ('empleado')
require ('generador_cheque')
require ('cheque')
require ('date')
require('consola_test')


describe "Generar cheque para empleado con salario fijo" do

  subject(:empleado) {Empleado.new(Date.new(2012,1,1))}

  it "deberia generar cheque para un empleado" do
    empleado.asignar_salario_fijo(300)
    generador = GeneradorCheque.new(Date.new(2013,1,1))
    cheque = generador.ejecutar(empleado)
    cheque.obtener_monto.should == 300
  end

  it "deberia generar cheque para otro empleado(salario 500)" do
    empleado.asignar_salario_fijo(500)
    generador = GeneradorCheque.new(Date.new(2013,1,1))
    cheque = generador.ejecutar(empleado)
    cheque.obtener_monto.should == 500
  end

  it "deberia asignar una fecha de contratacion a un empleado" do
    empleado.asignar_fecha_inicio_contrato(Date.new(2013,1,1))
    empleado.obtener_fecha_inicio_contrato.should == Date.new(2013,1,1)
  end

  it "deberia asignar una fecha de contratacion a cualquier empleado" do
    empleado.asignar_fecha_inicio_contrato(Date.new(2012,1,1))
    empleado.obtener_fecha_inicio_contrato.should == Date.new(2012,1,1)
  end

  it "deberia generar cheque con salario completo para un empleado que se contrato el primero del mes" do
    empleado.asignar_salario_fijo(500)
    empleado.asignar_fecha_inicio_contrato(Date.new(2013,4,1))
    generador = GeneradorCheque.new(Date.new(2013,4,30))
    cheque = generador.ejecutar(empleado)
    cheque.obtener_monto.to_i.should == 500
  end

  it "deberia generar cheque con mitad de salario para un empleado que se contrato a mitad del mes" do
    empleado.asignar_salario_fijo(500)
    empleado.asignar_fecha_inicio_contrato(Date.new(2013,4,16))
    generador = GeneradorCheque.new(Date.new(2013,4,30))
    cheque = generador.ejecutar(empleado)
    cheque.obtener_monto.to_i.should == 250
  end

  it "el cheque generado deberia corresponder al empleado" do
    empleado.con_nombre('pedro')
    empleado.con_apellido('mamani')
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.obtener_nombre_empleado.should == "pedro mamani"
  end

  it "el cheque generado de otro empleado deberia corresponder a otro empleado" do
    empleado.con_nombre('juan')
    empleado.con_apellido('perez')
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.obtener_nombre_empleado.should == "juan perez"
  end

  it "el cheque generado para empleado deberia tener su carnet" do
    empleado.con_ci('4312322')
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.obtener_ci_receptor.should == "4312322"
  end

  it "el cheque generado para cualquier empleado deberia tener su respectivo carnet" do
    empleado.con_ci('3838333')
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.obtener_ci_receptor.should == "3838333"
  end

  it "el cheque generado para empleado deberia tener una fecha de emision al momento de generarse" do
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.obtener_fecha_emision.should == Date.today
  end

  it "el cheque generado para empleado deberia tener una fecha de emision al momento de generarse, y no otra fecha" do
    generador = GeneradorCheque.new
    cheque = generador.ejecutar(empleado)
    cheque.obtener_fecha_emision.should_not == Date.today.next_day
  end



  it "no generar (imprimiendo) cheque si no es ultimo dia del mes" do
    consola = ConsolaTest.new
    generador = GeneradorCheque.new(Date.new(2013,12,12), consola)
    cheque = generador.ejecutar(empleado)
    generador.imprimir_cheque(cheque)
    consola.buffer_pantalla.should == "No se pudo imprimir el cheque, porque aun no es fin de mes"
  end

  it "generar (imprimiendo) cheque si es ultimo dia del mes, para un empleado" do
    consola = ConsolaTest.new
    generador = GeneradorCheque.new(Date.new(2013,12,31), consola)
    empleado.asignar_salario_fijo(2000)
    empleado.con_nombre('pedro')
    empleado.con_apellido('mamani')
    empleado.con_ci('123456')
    cheque = generador.ejecutar(empleado)
    generador.imprimir_cheque(cheque)
    consola.buffer_pantalla.should == "Nombre completo: pedro mamani\nCi: 123456\nMonto a cobrar: 2000$\nFecha emision:"+Date.today.to_s+"\nFirma:___________________________"
  end

  it "generar (imprimiendo) cheque si es ultimo dia del mes, para cualquier empleado" do
    consola = ConsolaTest.new
    generador = GeneradorCheque.new(Date.new(2013,12,31), consola)
    empleado.asignar_salario_fijo(1000)
    empleado.con_nombre('juan')
    empleado.con_apellido('perez')
    empleado.con_ci('654321')
    cheque = generador.ejecutar(empleado)
    generador.imprimir_cheque(cheque)
    consola.buffer_pantalla.should == "Nombre completo: juan perez\nCi: 654321\nMonto a cobrar: 1000$\nFecha emision:"+Date.today.to_s+"\nFirma:___________________________"
  end

end