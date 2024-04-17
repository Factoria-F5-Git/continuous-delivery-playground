# Laboratorio 6 - Entrega continua: Paso 4: Agregar una Smoke test

El objetivo de este laboratorio es mostrarte cómo podrías agregar una Smoke test simple a tu pipeline para asegurarte de que la aplicación siga funcionando después de una implementación.

> Nota: este laboratorio se basa en los resultados de los laboratorios anteriores.

## Smoke test para verificar que la implementación fue exitosa

Para nuestro caso, verificaremos que la aplicación se cargue y que el usuario pueda ver la página de inicio.

> Nota: Si eliges simular una implementación en el paso anterior del pipeline, también necesitas simular la Smoke test.

Contenido del script de Smoke test:

```bash
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

target_url=${1:-http://localhost}

echo "Ejecutando Smoke test contra: [${target_url}]"
echo "Smoke test iniciada"
curl ${target_url}
echo "¡Smoke test completada exitosamente!"
```

Para poder ejecutar el script de Smoke test, debes definirlo en el package.json en el modern-web-app. Agregaremos la tarea test:smoke para apuntar a nuestro script de Smoke test.

```json
{
  "private": true,
  "scripts": {
    [...]
    "test:smoke": "../scripts/smoke-test.sh"
  }
}
```

Agreguemos un nuevo trabajo a nuestro pipeline que ejecute este script:

```yaml
jobs:
    [...]
    verify-prod-deployment:
      name: Verificar implementación en prod
      needs: deploy-prod
      runs-on: ubuntu-latest
      steps:
          - name: Verificar código
            uses: actions/checkout@v4
          - name: Implementar con Node.js ${{ env.NODE_VERSION }}
            uses: actions/setup-node@v4
            with:
                node-version: ${{ env.NODE_VERSION }}
          - name: Ejecutar Smoke test
            run: |
              npm run test:smoke
```

## Teoría útil

[¿Qué son los smoke tests?](https://circleci.com/blog/smoke-tests-in-cicd-pipelines/)
Las smoke tests están diseñadas para revelar este tipo de fallos temprano mediante la ejecución de casos de prueba que cubren los componentes críticos y la funcionalidad de la aplicación. También aseguran que la aplicación funcionará como se espera en un escenario implementado.

## Lista de verificación del laboratorio

- [ ] Leer las instrucciones
- [ ] Agregar el trabajo de Smoke test al pipeline
- [ ] Subir los cambios y verificar los registros del pipeline en la pestaña de Acciones
- [ ] Pensar en otras formas de realizar smoke tests en lugar de usar curl