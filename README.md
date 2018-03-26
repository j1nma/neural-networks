# README #


### Propósito ###

* Red neuronal con aprendizaje supervisado para Sistemas de Inteligancia Artificial, I.T.B.A.
* TPE1

### Instrucciones Para La Instalación ###

1. Descargar el repositorio.
2. Dirigirse a la carpeta src dentro de la carpeta descargada en el paso anterior.
3. En la ventana de comandos de octave ejectuar terrain.
4. Si se desea cambiar los parámetros ir a la carpeta config.
5. Abrir terrainConfig y cambiar los parámetros deseados:
*		setSizePercentage es el porcentage del total de patrones que se van a usar para el entrenamiento y testeo.
*		hiddenLayers contiene el número de neuronas por capa oculta.
* 		trainingType puede ser batch o incremental.
*		momentum se desactiva cuando esta en 0.
*		normalizedPatterns y adaptiveLearningRate se pueden activar o desactivar con 1 y 0 respetivamente.
*		outputError es el error deseado para la salida calculada de la red
*		dataFile es el archivo de data a utilizar, por ejemplo, '../res/terrain11.data'

### Contacto ###

* Ante cualquier duda contactar a los miembros del grupo.