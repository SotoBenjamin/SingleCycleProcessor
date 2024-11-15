#!/bin/bash

# Limpiar compilaciones anteriores
rm -f simulation.out simulation.vcd

# Compilar todos los módulos con iverilog
iverilog -o simulation.out \
  top.v \
  testbench.v \
  arm.v \
  controller.v \
  datapath.v \
  decode.v \
  condlogic.v \
  condcheck.v \
  extend.v \
  imem.v \
  dmem.v \
  adder.v \
  alu.v \
  regfile.v \
  mux2.v \
  flopenr.v \
  flopr.v \
  shift.v

# Verificar si la compilación fue exitosa
if [ $? -ne 0 ]; then
  echo "Error en la compilación. Revisa tus archivos Verilog."
  exit 1
fi

# Ejecutar la simulación con vvp
vvp simulation.out

# Verificar si la simulación generó el archivo VCD
if [ ! -f simulation.vcd ]; then
  echo "La simulación no generó un archivo VCD. Revisa el testbench."
  exit 1
fi

# Abrir el archivo de ondas en GTKWave
gtkwave simulation.vcd &