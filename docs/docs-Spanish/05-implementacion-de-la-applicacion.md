# Laboratorio 5: Entrega continua - Paso 3: Implementación de la aplicación

El objetivo de este laboratorio es mostrarte cómo podrías automatizar la implementación de la aplicación en un entorno específico, por ejemplo, de pruebas o producción.

> Nota: este laboratorio se basa en los resultados de los laboratorios anteriores.

## Agregar una etapa de implementación a nuestro pipeline de entrega continua

En las etapas anteriores del pipeline nos aseguramos de que los cambios más recientes estuvieran integrados, las pruebas pasaran y la aplicación se construyera y empaquetara. Eso nos da suficiente confianza para implementar la última versión de la aplicación en un entorno.

Piénsalo, ¿cuándo comienzan a aportar valor los cambios de código más recientes? ¿Es cuando se prueban y se construye la aplicación o cuando se implementan y se lanzan a los usuarios finales?

Esta etapa del pipeline es un poco más complicada. Hasta ahora solo estábamos ejecutando comandos en las máquinas de trabajo de GitHub Actions. Para automatizar una implementación, necesitamos desencadenar una acción en un servicio externo, el que proporciona el entorno de implementación. Necesitamos autenticarnos con el servicio donde implementaremos nuestra aplicación.

Para el alcance de este tutorial, utilizaremos Vercel. Puedes pensar en Vercel como un servidor gratuito donde puedes exponer tu aplicación a usuarios reales. Si no tienes una cuenta de Vercel, ¡no te preocupes! Puedes optar por la opción 1 en este laboratorio donde simulamos una implementación.

> "Implementar de la misma manera en todos los entornos, incluido el desarrollo. De esta manera, probamos el proceso de implementación muchas veces antes de que llegue a producción, y nuevamente, podemos eliminarlo como la fuente de cualquier problema." -- por [continuousdelivery.com](https://continuousdelivery.com/implementing/patterns/)

## Realicemos una implementación real usando Vercel

Primero probémoslo localmente:

1. Instala vercel usando `npm i -g vercel`
2. Ejecuta `vercel` para configurar el entorno
3. Ejecuta `vercel --prod` para enviar a producción la última versión de la aplicación

Agreguemos un nuevo trabajo que nos permita implementar nuestra aplicación web moderna en un entorno que llamaremos producción.

Primero tenemos que crear un token para que GitHub pueda suplantar nuestra cuenta personal de Vercel a través de la API de Vercel.
Primero crearemos un token en Vercel yendo a `Configuración de la cuenta > Tokens > Crear token`

![Crear token](../images/vercel-token.png)

Luego agregaremos este secreto en las acciones de GitHub, <code style="color : red"> IMPORTANTE: nunca comprometas secretos en tu repositorio</code>

`Secrets and variables > Actions > Actions secrets > New secret`

![Crear secreto](../images/github-secrets.png)

Ahora podemos agregar la siguiente infraestructura como código en nuestro pipeline:

```yaml
jobs:
    [...]
  deploy-prod:
    name: Implementar en Vercel prod
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    env:
      VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
      VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
      VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
    steps:
      - name: Verificar código
        uses: actions/checkout@v4
      - name: Implementar con Node.js ${{ env.NODE_VERSION }}
        uses: actions/setup-node@v4
        with:
            node-version: ${{ env.NODE_VERSION }}
      - name: Instalar Vercel
        run: npm install --global vercel@latest
      - name: Implementar proyecto en Vercel
        working-directory: .
        run: vercel --prod --token=${{ secrets.VERCEL_TOKEN }}
```

En el paso anterior, primero instalamos vercel en el servidor para poder usar los comandos de vercel y luego implementamos la última versión del proyecto en Vercel. Es importante destacar que para la implementación estamos configurando el directorio actual (a.k.a. working-directory) como `.` en lugar del predeterminado `modern-web-app`. Eso se debe a que implementamos localmente la aplicación desde ese nivel, y no desde la raíz del proyecto.

## Teoría Útil

[¿Cuáles son las diferencias entre integración continua vs. entrega vs. implementación continuas?](https://www.atlassian.com/continuous-delivery/principles/continuous-integration-vs-delivery-vs-deployment)

## Lista de verificación del laboratorio

- [ ] Leer las instrucciones
- [ ] Agregar las tareas de deploy:simulate en la declaración de scripts de NPM
- [ ] Agregar el trabajo de implementación automatizada al pipeline de entrega continua
- [ ] Subir los cambios y verificar los registros del pipeline en la pestaña de Acciones
- [ ] Responder a esta pregunta: ¿El pipeline implementa entrega continua o implementación continua?