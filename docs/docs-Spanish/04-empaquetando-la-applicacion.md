# Laboratorio 4: Integración continua - Paso 2: Construcción y empaquetado de la aplicación

El objetivo de este laboratorio es mostrarte cómo agregar una etapa en nuestro pipeline para construir y empaquetar la aplicación.

> Nota: este laboratorio se basa en los resultados de los laboratorios anteriores.

## Agregar una etapa de construcción a nuestro proceso de implementación continua

En la etapa anterior de nuestro pipeline nos aseguramos de que los cambios más recientes estén integrados y las pruebas estén pasando. Por lo tanto, ya hemos logrado la integración continua (CI). Para avanzar con la entrega continua, el siguiente paso es construir y empaquetar una nueva versión de la aplicación cada vez que agregamos nuevo código.

Agreguemos un nuevo trabajo llamado build con los siguientes pasos:

```yaml
jobs:
    [...]
    build:
        name: Construcción
        needs: test
        runs-on: ubuntu-latest
        steps:
            - name: Verificar código
              uses: actions/checkout@v4
            - name: Configurar Node.js ${{ env.NODE_VERSION }}
              uses: actions/setup-node@v4
              with:
                  node-version: ${{ env.NODE_VERSION }}
            - name: Construir la aplicación
              run: |
                npm ci
                npm run build
            - name: Subir artefactos
              uses: actions/upload-artifact@v4
              with:
                name: modern-web-app-v${{ github.sha }}
                path: modern-web-app/.next/

```

Como puedes ver, agregamos un paso para construir la aplicación y sus dependencias con NPM. Finalmente, usamos la acción de GitHub upload-artifact para subir un artefacto de construcción al servidor de GitHub que contiene una versión empaquetada de la aplicación.

> "Solo construye paquetes una vez. Queremos estar seguros de que lo que estamos implementando es lo mismo que hemos probado en todo el pipeline de implementación, para que si una implementación falla, podamos eliminar los paquetes como la fuente del fallo." -- por [continuousdelivery.com](https://continuousdelivery.com/implementing/patterns/)

### Conceptos del Pipeline
- **_needs_**: Este paso no se ejecutará a menos que el paso definido aquí sea exitoso.
- **_uses_**: Para especificar acciones de GitHub ya definidas. Puedes pensar en estas como acciones reutilizables que puedes incorporar en tu pipeline, por ejemplo, checkout, setup-node... 
Para documentación y encontrar otras acciones, puedes ir al [mercado oficial de GitHub](https://github.com/marketplace?type=actions). También es bueno verificar la documentación para obtener la versión más reciente de la acción. Algunas de las acciones que hemos utilizado aquí son: 
[setup-node-js](https://github.com/marketplace/actions/setup-node-js-environment)
[checkout](https://github.com/marketplace/actions/checkout)
- **_with_**: Para pasar los parámetros a acciones de GitHub ya definidas.

## Lista de verificación del laboratorio

- [ ] Leer las instrucciones
- [ ] Agregar el trabajo de construcción al flujo de trabajo de implementación continua
- [ ] Subir los cambios y verificar los registros del pipeline en la pestaña de Acciones
- [ ] Pensar en otras tareas que podrían automatizarse como parte de la etapa de construcción en el pipeline