# Dragon Ball Flutter App

## Descripción

Aplicación móvil desarrollada con **Flutter** que consume la **Dragon Ball API** para mostrar una lista de personajes. La aplicación permite buscar personajes, ver sus detalles y marcarlos como favoritos. Los personajes favoritos se gestionan dentro de la app, y los usuarios pueden eliminarlos de su lista de favoritos.

## Tecnologías Utilizadas

- **Flutter**: Framework para el desarrollo de aplicaciones móviles.
- **Bloc**: Patrón de gestión de estado para manejar la lógica de la aplicación.
- **Dragon Ball API**: API pública que proporciona datos sobre personajes de Dragon Ball. [Documentación de la API](https://dragonball-api.com/api-docs#/).

## Requisitos

- **Flutter SDK** (versión recomendada: 3.x o superior).
- **Conexión a Internet**: Para consumir los datos de la API de Dragon Ball.
- **Emulador o dispositivo físico**: Para ejecutar la aplicación.

## Instalación

### 1. Clonar el Repositorio

Clona el repositorio utilizando Git:

git clone https://github.com/tu_usuario/dragon_ball_flutter_app.git


### 2. Instalar Dependencias

Accede al directorio del proyecto y descarga las dependencias necesarias con el siguiente comando:

cd dragon_ball_flutter_app
flutter pub get


### 3. Ejecutar la Aplicación

Para ejecutar la aplicación, utiliza el siguiente comando:

flutter run


## Funcionalidades

### Pantalla Principal

- Muestra una lista de personajes obtenidos de la Dragon Ball API.
- Permite buscar personajes por nombre.
- Cada personaje en la lista muestra:
  - **Imagen**: Foto del personaje.
  - **Nombre**: Nombre del personaje.
  - **Raza**: Especie o raza (por ejemplo, Saiyan, Namekiano, etc.).
  - **Favorito**: Opción para marcar o desmarcar el personaje como favorito.

### Sistema de Favoritos

- **Pantalla de Favoritos**: Vista separada donde se muestran los personajes marcados como favoritos.
- **Contador de Favoritos**: Se muestra un contador de favoritos en la aplicación.
- **Eliminar de Favoritos**: Los personajes pueden ser eliminados de la lista de favoritos.
- **Persistencia en Memoria**: Los favoritos se mantienen durante la sesión de la aplicación (no se requiere persistencia en almacenamiento local).

### Detalles del Personaje

Al seleccionar un personaje de la lista, se muestra una vista detallada con información adicional sobre el personaje, como:

- Descripción.
- Habilidades o poderes.
- Información adicional proporcionada por la API.

Además, en la vista de detalles, los usuarios pueden seguir marcando o desmarcando el personaje como favorito.


## API

La aplicación consume la Dragon Ball API a través de los siguientes endpoints:

- `GET /characters`: Obtiene una lista de personajes.
- `GET /characters/{id}`: Obtiene los detalles de un personaje específico.

## Gestión de Estado (Bloc)

La aplicación utiliza el patrón Bloc para manejar el estado:

### Eventos

- `LoadCharacters`: Carga los personajes desde la API.
- `AddToFavorites`: Agrega un personaje a la lista de favoritos.
- `RemoveFromFavorites`: Elimina un personaje de la lista de favoritos.

### Estados

- `CharactersLoading`: Muestra que los personajes se están cargando.
- `CharactersLoaded`: Contiene la lista de personajes cargados.
- `Error`: Muestra si ocurrió un error al cargar los personajes.

## Cómo Contribuir

Si deseas contribuir al proyecto, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza los cambios que deseas añadir.
4. Haz un commit de tus cambios (`git commit -am 'Agrega nueva funcionalidad'`).
5. Empuja tus cambios a tu repositorio (`git push origin feature/nueva-funcionalidad`).
6. Crea un pull request.

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.

## Contacto

Desarrollado por: Daniel León  
Correo: [daniel.leon07@hotmail.com](mailto:daniel.leon07@hotmail.com)

