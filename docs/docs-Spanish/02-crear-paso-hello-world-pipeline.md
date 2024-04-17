# Laboratorio 2: Creación de un paso "hola mundo"

### Acciones de GitHub para crear un pipeline de CI/CD

El objetivo de este tutorial es entender el uso básico de las GitHub actions creando un pipeline de "hola mundo".

> Nota: En el último laboratorio ingresaste al directorio modern-web-app, regresa al directorio raíz antes de continuar con las siguientes instrucciones.

El primer paso es crear un GitHub workflow, crea la siguiente estructura de carpetas:

```
   mkdir .github/
   mkdir .github/workflows/
```

Navega hasta la carpeta que acabamos de crear

```
   cd .github/workflows/
```

Ahora creamos un workflow (flujo de trabajo) dentro de la carpeta de flujos de trabajo.

```
touch pipeline.yml
```

El siguiente paso es agregar la definición del pipeline en el archivo que acabamos de crear.

```yml
name: Pipeline CI/CD

on: push

jobs:
  hello-world:
    runs-on: ubuntu-latest
    steps:
      - name: Paso de Hola Mundo
        run: echo "¡Hola Mundo!"
```

### Conceptos Básicos del Pipeline

- **_Name_**: Esto simplemente especifica un nombre para el flujo de trabajo.
- **_On_**: El comando on se utiliza para especificar un evento que activará el flujo de trabajo, este evento puede ser push, pull_request, etc.
- **_Jobs_**: Aquí estamos especificando el trabajo que queremos ejecutar, en este caso, estamos configurando un trabajo de construcción.
- **_Runs-on_**: especifica el sistema operativo en el que desea que se ejecute su flujo de trabajo.
- **_Steps_**: Los pasos simplemente indican los diversos pasos que desea ejecutar en ese trabajo.

### Probemos nuestro Pipeline

Una vez que los cambios se hayan confirmado, el pipeline debería ejecutarse automáticamente como se especifica para ejecutarse en push.

```bash
git add .
git commit -m "Agregar archivo de flujo de trabajo"
git push
```

## Teoría Útil

[¿Qué es un pipeline?](https://www.atlassian.com/devops/devops-tools/devops-pipeline#:~:text=A%20DevOps%20pipeline%20is%20a,code%20to%20a%20production%20environment.)
Un pipeline de DevOps es un sistema de procesos automatizados diseñados para mover de manera rápida y precisa nuevas adiciones y actualizaciones de código desde el control de versiones hasta la producción.

[¿Qué es la integración continua (CI)?](https://martinfowler.com/articles/continuousIntegration.html#:~:text=Continuous%20Integration%20is%20a%20software,to%20multiple%20integrations%20per%20day.)
La Integración Continua es una práctica de desarrollo de software donde los miembros de un equipo integran su trabajo con frecuencia, generalmente cada persona integra al menos diariamente, lo que lleva a múltiples integraciones por día.

[¿Qué es la entrega continua (CD)?](https://aws.amazon.com/devops/continuous-delivery/?nc1=h_ls)
Es una práctica de desarrollo de software donde los cambios de código se preparan automáticamente para una versión.
Con la entrega continua, cada cambio de código se construye, se prueba y luego se envía automáticamente a un entorno de prueba o puesta en escena no productivo.
La entrega continua automatiza todo el proceso de lanzamiento de software.

[¿Qué son las GitHub actions?](https://resources.github.com/downloads/What-is-GitHub.Actions_.Benefits-and-examples.pdf)
GitHub Actions lleva la automatización directamente al ciclo de vida del desarrollo de software en GitHub a través de disparadores basados en eventos. Estos
disparadores son eventos especificados que van desde la creación de una solicitud de extracción hasta la construcción de una nueva rama en un repositorio.

[Documentación de GitHub actions](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions?learn=getting_started)

## Lista de verificación del laboratorio

- [ ] Leer las instrucciones
- [ ] Crear la estructura de carpetas
- [ ] Crear un flujo de trabajo de GitHub
- [ ] Subir los cambios y verificar la ejecución del pipeline en la pestaña Actions