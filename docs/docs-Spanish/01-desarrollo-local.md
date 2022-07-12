# Laboratorio 1: Flujo de trabajo de desarrollo local

## Probemos nuestro desarrollo local

Este tutorial utiliza NPM como herramienta de construcción. NPM te permite definir tareas en el fichero package.json. En este, puedes ver algunas tareas de construcción ya definidas:

```javascript
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "test:unit": "jest --ci"
  }
```

Para construir la aplicación, simplemente le decimos a npm que lo haga.

```sh
npm run build
```

Nuestro equipo es muy profesional y ha escrito algunas pruebas unitarias para asegurarse de que podamos refactorizar la aplicación si es necesario. Asegurémonos de que todas estén en verde:

```sh
npm run test:unit
```

Si queremos implementar la aplicación en el entorno local en modo de desarrollo, simplemente ejecutamos:

```sh
npm run dev
```

y luego abrimos http://localhost:3000 para verificar nuestra aplicación web moderna.

## Lista de verificación del laboratorio

- [ ] Leer las instrucciones
- [ ] Construir la aplicación localmente
- [ ] Ejecutar las pruebas unitarias localmente
- [ ] Implementar la aplicación localmente en modo de desarrollo