# Laboratorio 3: Integración continua - Paso 1: Ejecución de pruebas

El objetivo de este laboratorio es crear la primera etapa en nuestro pipeline de CI/CD, el paso de prueba. Utilizaremos lo que aprendimos en el laboratorio 2 y reemplazaremos nuestro pipeline de "hola mundo" por algo más útil.

## Agregar el paso de prueba a nuestro CI

Dado que nuestro código de la aplicación no está en la carpeta raíz, necesitamos indicar a GitHub Actions dónde ejecutar los comandos desde. Especifiquemos que los comandos de NPM deben ejecutarse desde el directorio modern-web-app. Agreguemos a nuestro `pipeline.yml` lo siguiente:

```yml
defaults:
  run:
    working-directory: modern-web-app
```

También necesitamos indicar a una de las acciones de GitHub la versión de Node.js que necesitamos. Primero ejecuta `node --version` en tu terminal y luego agrega la versión como una variable de entorno:

```yml
env:
  NODE_VERSION: "21.6.2"
```

El siguiente paso es simplemente especificar el trabajo de prueba y agregarlo a la definición del pipeline (`pipeline.yml`):

```yml
on: push

env: 
  ...

defaults:
  ...

jobs:
  test:
    name: Prueba
    runs-on: ubuntu-latest

    steps:
      - name: Verificar código
        uses: actions/checkout@v4
      - name: Configurar Node.js ${{ env.NODE_VERSION }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
      - name: Ejecutar pruebas unitarias
        run: |
          npm ci
          npm run test:unit
```

## Control de pruebas
Ahora veremos qué sucede si agregamos un paso ficticio después de la prueba y hacemos fallar intencionalmente la prueba.

Añadiremos nuevamente el paso de Hola Mundo, después de la prueba:

```yml
jobs:
  test:
    [...]
    steps:
      [...]
      - name: Paso de Hola Mundo
        run: |
          echo "¡Hola Mundo!"
```

Y luego agregaremos una prueba para que falle:

```tsx
it('Cero no es igual a Uno', () => {
    expect(1).toBe(0)
  })
```

¿Qué sucedió ahora? ¿Por qué el paso de Hola Mundo no se ejecutó? ¿Qué tiene que cambiar para que el paso después de la prueba se ejecute?

### Bonus - snapshot test
Si vas al archivo `snapshot.tsx`, verás que estamos probando una instantánea de nuestra aplicación. Esto significa que si cambiamos el HTML de la aplicación sin actualizar la instantánea actual, la prueba fallará. Así que si quieres jugar cambiando la parte visual, después usa `jest --updateSnapshot` para actualizar la instantánea actual y evitar que la prueba falle.

### Conceptos del Pipeline

- **_env_**: Para especificar variables de entorno que se pueden reutilizar en toda la definición del pipeline.
- **_working-directory_**: Para cambiar el directorio desde el cual GitHub Actions ejecutará los comandos de ejecución.
- **_uses_**: Para especificar acciones de GitHub ya definidas. Puedes pensar en estas como acciones reutilizables que puedes incorporar en tu pipeline, por ejemplo, checkout, setup-node... 
Para documentación y encontrar otras acciones, puedes ir al [mercado oficial de GitHub](https://github.com/marketplace?type=actions). También es bueno verificar la documentación para obtener la versión más reciente de la acción. Algunas de las acciones que hemos utilizado aquí son: 
[setup-node-js](https://github.com/marketplace/actions/setup-node-js-environment)
[checkout](https://github.com/marketplace/actions/checkout)
- **_with_**: Para pasar los parámetros a acciones de GitHub ya definidas.

### Probemos nuestra nueva etapa del pipeline

Una vez que los cambios estén confirmados y enviados, el pipeline debería ejecutarse automáticamente.

```bash
git add .
git commit -m "Agregar paso de prueba al pipeline de CI"
git push
```

## Teoría Útil

[¿Qué es la prueba continua?](https://continuousdelivery.com/foundations/test-automation/)
La prueba continua es la práctica de ejecutar muchos tipos diferentes de pruebas, tanto manuales como automatizadas, continuamente durante todo el proceso de entrega con el objetivo de encontrar problemas lo antes posible.

[¿Qué es la automatización de pruebas?](https://www.atlassian.com/devops/devops-tools/test-automation)
La automatización de pruebas es la práctica de automatizar tareas de prueba para asegurarse de que la aplicación esté lista para ser implementada y cumpla con los estándares de calidad predefinidos.

## Lista de verificación del laboratorio

- [ ] Leer las instrucciones
- [ ] Reemplazar el trabajo de hola mundo con el nuevo trabajo de prueba
- [ ] Subir los cambios y verificar la ejecución del pipeline en la pestaña de Acciones
- [ ] Romper las pruebas, confirmar y enviar los cambios. Verificar qué sucede.